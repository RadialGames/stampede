package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Sarah Northway
	 */
	public class Gui extends Sprite
	{
		public function Gui()
		{
			instance = this;
			
			gfx = new GfxGui();
			addChild(gfx);
			
			slotSpacing = gfx.slots.slot2.x;
			cardSpacing = gfx.cards.card2.x;
			statSpacing = gfx.stats.stat2.x;
			
			Utils.clearChildren(gfx.slots);
			Utils.clearChildren(gfx.cards);
			Utils.clearChildren(gfx.stats);
			
			for (var i :int = 0; i < Config.NUM_SLOTS; i++) {
				var slot:GfxSlot = new GfxSlot();
				slot.x = slotSpacing * i;
				gfx.slots.addChild(slot);
				
				if (tempIsEvent(i)) {
					var event:GfxEvent = new GfxEvent();
					event.info.text = "event";
					event.x = cardSpacing * i;
					gfx.cards.addChild(event);
					actions.push(event);
				} else {
					actions.push(null);
				}
				
				var stat:GfxStat = new GfxStat();
				stat.info.text = "666\n666";
				stat.x = statSpacing * i;
				gfx.stats.addChild(stat);
				stats.push(stat);
			}
			
			drawNextCard();
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
			
			if (tempIsEvent(index)) {
				Utils.log("drop index is on an event");
				card.x = 0;
				card.y = 0;
				return;
			}
			
			gfx.cards.addChild(card);
			card.x = index * cardSpacing;
			card.y = 0;
			actions[index] = card;
			refreshStats();
			drawNextCard();
		}
		
		public function drawNextCard():void
		{
			Utils.clearChildren(gfx.nextCard);
			
			var nextCard:GuiCard = new GuiCard();
			gfx.nextCard.addChild(nextCard);
			
		}
		
		public function isNextCard(card:GuiCard):Boolean
		{
			if (gfx.nextCard.numChildren == 0) {
				return false;
			}
			return gfx.nextCard.getChildAt(0) == card;
		}
		
		public function refreshStats():void
		{
			for (var i :int = 0; i < stats.length; i++) {
				var stat:GfxStat = stats[i];
				stat.info.text = i + "\n" + i;
				
				if (tempIsEvent(i)) {
					var event:GfxEvent = actions[i] as GfxEvent;
					if (event == null) {
						Utils.logError("event is null for i " + i);
						continue;
					}
					event.info.text = "evnt" + i;
				}
			}
		}
		
		private function tempIsEvent(index:int):Boolean
		{
			return index % 3 == 2;
		}
		
		/** fills a slot; either a GuiCard or a GfxEvent */
		protected var actions:Vector.<*> = new Vector.<*>();
		
		protected var stats:Vector.<GfxStat> = new Vector.<GfxStat>();
		
		protected var gfx:GfxGui;
		protected var slotSpacing:Number;
		protected var cardSpacing:Number;
		protected var statSpacing:Number;
		
		public static var instance:Gui;
	}
}