package gui
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
			
			timeline = new GuiTimeline(gfx.timeline);
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
		
		/** fills a slot; either a GuiCard or a GfxEvent */
		protected var actions:Vector.<*> = new Vector.<*>();
		
		protected var stats:Vector.<GfxStat> = new Vector.<GfxStat>();
		
		protected var gfx:GfxGui;
		public var timeline:GuiTimeline;
		protected var slotSpacing:Number;
		protected var cardSpacing:Number;
		protected var statSpacing:Number;
		
		public static var instance:Gui;
	}
}