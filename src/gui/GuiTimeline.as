package gui
{
	import actions.cards.Card;
	import actions.plots.PlotPoint;
	import aze.motion.easing.Bounce;
	import aze.motion.eaze;
	import aze.motion.EazeTween;
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
				if (monsterSolution != null) {
					Utils.removeFromParent(monsterSolution);
				}
				statsGraph = new StatsGraph(gfx.width-15, 100);
				statsGraph.x = 10;
				statsGraph.y = 10;
				gfx.addChild(statsGraph);
				
				monsterSolution = new MonsterSolution(100, 100);
				monsterSolution.x = 800
				monsterSolution.y = 10;
				gfx.addChild(monsterSolution);
			}
			
			refresh();
		}
		
		public function cardDropped(card:GuiCard):void
		{
			var dropPoint:Point = gfx.cards.globalToLocal(card.localToGlobal(new Point(0, 0)));
			Utils.log("dropped at " + dropPoint);

			var index:int = (slotSpacing / 2 + dropPoint.x) / slotSpacing;
			Utils.log("drop index is " + index);

			var failX:Number = NaN;
			var failIndex:Number = NaN;
			if (Utils.vectorContains(Game.timeline, card.action)) {
				for (var i:Number = 0; i < Game.timeline.length; i++) {
					if (Game.timeline[i] == card.action)
						failIndex = i;
				}
				failX = failIndex * slotSpacing;
			}
			
			if (dropPoint.y < -50 || dropPoint.y > card.height + 50 || dropPoint.x < -50) {
				Utils.log("Dropped too far outside zone.");
				EazeTween.killTweensOf(card);
				eaze(card).to(0.3, { x:failX, y:0, scaleX:1, scaleY:1 }, true);
				new GuiFloatText(Main.snipeLayer, "You suck at placing cards!", card.localToGlobal(new Point(0,-50)));
				return;
			}
			
			if (isPlotPoint(index)) {
				Utils.log("drop index is on an event");
				EazeTween.killTweensOf(card);
				eaze(card).to(0.3, { x:failX, y:0, scaleX:1, scaleY:1 }, true);
				new GuiFloatText(Main.snipeLayer, "You suck at placing cards!", card.localToGlobal(new Point(0,-50)));
				return;
			}
			
			if (!Game.putCardOnSlot(card.action, index)) {
				Utils.log("drop index disallowed by game.as");
				EazeTween.killTweensOf(card);
				eaze(card).to(0.3, { x:failX, y:0, scaleX:1, scaleY:1 }, true);
				new GuiFloatText(Main.snipeLayer, "You suck at placing cards!", card.localToGlobal(new Point(0,-50)));
				return;
			}
			
			if (isNaN(failX)) {
				// card does NOT exist on the timeline already
				gfx.cards.addChild(card);
			} else {
				// card DOES exist on the timeline
				// remove the old entry
				if (Game.timeline[index] != null) {
					// we're swapping!!!
					eaze(guiActions[index]).to(0.6, { x:failIndex * slotSpacing } );
					guiActions[failIndex] = guiActions[index];
					Game.timeline[failIndex] = Game.timeline[index];
				} else {
					// we're not swapping :(
					guiActions[failIndex] = null;
					Game.timeline[failIndex] = null;
				}
			}
			card.x = index * slotSpacing;
			card.y = 0;
			guiActions[index] = card;
			Game.timeline[index] = card.action;
			//Utils.log("guitimeline card dropped");
			if (isNaN(failX)) {
				// NOT exist on timeline, standard
				Gui.instance.cardPlaced(card.action as Card);
				
			} else {
				// DOES exist on timeline
				Gui.instance.cardMoved();
				
			}
			eaze(card).from(0.6, { y:card.y - 50 }, false).easing(Bounce.easeOut);
			//if (card.action.outcomeDescription == null) Utils.log("no outcomedesc on card");
			//else new GuiFloatText(Main.snipeLayer, card.action.outcomeDescription, card.localToGlobal(new Point(0, -50)));
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
			Utils.log("GuiTimeLineRefresh");
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
			
			trace(statValues);
			Gui.instance.setEndingMonster(Game.currentMonster); // Monster.whichMoster());
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
		protected var monsterSolution:MonsterSolution;
	}
}