package gui
{
	import actions.plots.PlotPoint;
	import aze.motion.easing.Bounce;
	import aze.motion.eaze;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import monsters.Monster;
	/**
	 * Slots, stats, placed cards and plotpoints. Controls Gui.gfx.timeline.
	 * @author Sarah Northway
	 */
	public class GuiTimeline
	{
		public function GuiTimeline(gfx:MovieClip)
		{
			this.gfx = gfx;
			
			slotSpacing = gfx.slots.slot2.x;
		}
		
		public function reset():void
		{
			Utils.clearChildren(gfx.slots);
			Utils.clearChildren(gfx.cards);
			
			Utils.clearVector(guiActions);
			
			for (var i :int = 0; i < Config.NUM_SLOTS; i++) {
				var slot:GfxSlot = new GfxSlot();
				slot.x = slotSpacing * i;
				gfx.slots.addChild(slot);
				
				if (isPlotPoint(i)) {
					var plotPoint:GuiPlotPoint = new GuiPlotPoint(Game.timeline[i] as PlotPoint);
					plotPoint.x = slotSpacing * i;
					gfx.cards.addChild(plotPoint);
					guiActions.push(plotPoint);
				} else {
					guiActions.push(null);
				}
				
				if (statsGraph != null) {
					Utils.removeFromParent(statsGraph);
				}
				statsGraph = new StatsGraph(gfx.width, 130);
				gfx.addChild(statsGraph);
			}
			
			refresh();
		}
		
		public function cardDropped(card:GuiCard):void
		{
			var dropPoint:Point = gfx.cards.globalToLocal(card.localToGlobal(new Point(0, 0)));
			Utils.log("dropped at " + dropPoint);
			
			if (dropPoint.y < -50 || dropPoint.y > card.height + 50 || dropPoint.x < -50) {
				Utils.log("Dropped too far outside zone.");
				//card.x = 0;
				//card.y = 0;
				eaze(card).to(0.3, { x:0, y:0 }, true);
				new GuiFloatText(Main.snipeLayer, "You suck at placing cards!", card.localToGlobal(new Point(0,-50)));
				return;
			}
			
			var index:int = (slotSpacing / 2 + dropPoint.x) / slotSpacing;
			Utils.log("drop index is " + index);
			
			if (isPlotPoint(index)) {
				Utils.log("drop index is on an event");
				//card.x = 0;
				//card.y = 0;
				eaze(card).to(0.3, { x:0, y:0 }, true);
				new GuiFloatText(Main.snipeLayer, "You suck at placing cards!", card.localToGlobal(new Point(0,-50)));
				return;
			}
			
			if (!Game.putTopCardOnSlot(index)) {
				Utils.log("drop index disallowed by game.as");
				eaze(card).to(0.3, { x:0, y:0 }, true);
				new GuiFloatText(Main.snipeLayer, "You suck at placing cards!", card.localToGlobal(new Point(0,-50)));
				return;
			}
			
			gfx.cards.addChild(card);
			card.x = index * slotSpacing;
			card.y = 0;
			guiActions[index] = card;
			Game.timeline[index] = card.action;
			refresh();
			Gui.instance.cardPlaced();
			eaze(card).from(0.6, { y:card.y - 50 }, false).easing(Bounce.easeOut);
			if (card.action.outcomeDescription == null) Utils.log("no outcomedesc on card");
			else new GuiFloatText(Main.snipeLayer, card.action.outcomeDescription, card.localToGlobal(new Point(0,-50)));
		}
		
		protected function isNextCard(card:GuiCard):Boolean
		{
			if (gfx.nextCard.numChildren == 0) {
				return false;
			}
			return gfx.nextCard.getChildAt(0) == card;
		}
		
		/**
		 * Called when any card is placed. Reload all stats and plotPoints
		 */
		public function refresh():void
		{
			Game.reset();
			statsGraph.reset();
			
			for (var i :int = 0; i < Config.NUM_SLOTS; i++) {
				try {
					Game.next();
				} catch (error:Error) {
					Utils.log(error);
				}
				
				var statValues:Vector.<Number> = getStatValues();
				
				statsGraph.update(statValues, i);
				
				if (isPlotPoint(i)) {
					var event:GfxPlotPoint = guiActions[i] as GfxPlotPoint;
					if (event == null) {
						//Utils.logError("event is null for i " + i);
						continue;
					}
					event.info.text = "evnt" + i;
				}
			}
			
			Gui.instance.setEndingMonster(Monster.whichMoster());
		}
		
		/**
		 * Return an array of the current Config.ALL_STATS values from Game.as
		 */
		protected function getStatValues():Vector.<Number>
		{
			var values:Vector.<Number> = new Vector.<Number>();
			for (var j:int = 0; j < Config.ALL_STATS.length; j++) {
				var stat:String = Config.ALL_STATS[j];
				values.push(Game.stats.getStat(stat));
			}
			return values;
		}
		
		protected function isPlotPoint(index:int):Boolean
		{
			if (Game.timeline == null) {
				return false;// (index % 3 == 2);
			}
			return Game.timeline[index] is PlotPoint;
		}
		
		/** fills a slot; either a GuiCard or a GuiPlotPoint */
		protected var guiActions:Vector.<*> = new Vector.<*>();
		
		protected var gfx:MovieClip;
		
		protected var slotSpacing:Number;
		protected var statsGraph:StatsGraph;
	}
}