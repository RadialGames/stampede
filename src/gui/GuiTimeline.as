package gui
{
	import actions.plots.PlotPoint;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
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
			cardSpacing = gfx.cards.card2.x;
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
					plotPoint.x = cardSpacing * i;
					gfx.cards.addChild(plotPoint);
					guiActions.push(plotPoint);
				} else {
					guiActions.push(null);
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
				card.x = 0;
				card.y = 0;
				return;
			}
			
			var index:int = (cardSpacing / 2 + dropPoint.x) / cardSpacing;
			Utils.log("drop index is " + index);
			
			if (isPlotPoint(index)) {
				Utils.log("drop index is on an event");
				card.x = 0;
				card.y = 0;
				return;
			}
			
			gfx.cards.addChild(card);
			card.x = index * cardSpacing;
			card.y = 0;
			guiActions[index] = card;
			Game.timeline[index] = card.action;
			refresh();
			Gui.instance.cardPlaced();
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
						Utils.logError("event is null for i " + i);
						continue;
					}
					event.info.text = "evnt" + i;
				}
			}
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
		protected var cardSpacing:Number;
		protected var statsGraph:StatsGraph;
	}
}