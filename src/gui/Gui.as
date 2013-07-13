package gui
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
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
			
			GuiButton.replaceButton(gfx.edgeScrollerLeft);
			gfx.edgeScrollerLeft.addEventListener(MouseEvent.MOUSE_OVER, scrollerOver);
			
			GuiButton.replaceButton(gfx.edgeScrollerRight);
			gfx.edgeScrollerRight.addEventListener(MouseEvent.MOUSE_OVER, scrollerOver);
			
			drawNextCard();
		}
		
		protected function scrollerOver(event:MouseEvent):void
		{
			scrolling = true;
			event.target.addEventListener(MouseEvent.MOUSE_OUT, scrollerOut);
			event.target.addEventListener(Event.ENTER_FRAME, scrollerEnterFrame);
		}
		
		protected function scrollerEnterFrame(event:Event):void
		{
			var left:Boolean = (event.target == gfx.edgeScrollerLeft);
			
			// from 0 (inside) to 1 (outside)
			var scrollXPercent:Number = event.target.mouseX / event.target.width;
			var diffX:Number = 20 * scrollXPercent;
			if (event.target == gfx.edgeScrollerLeft) {
				diffX *= -1;
			}
			gfx.timeline.x += diffX;
			
			// stop from scrolling off the edge
			if (gfx.timeline.x > gfx.timelineMask.x) {
				gfx.timeline.x = gfx.timelineMask.x;
			} else if (gfx.timeline.x + gfx.timeline.width < gfx.timelineMask.x + gfx.timelineMask.width) {
				gfx.timeline.x = gfx.timelineMask.width + gfx.timelineMask.x - gfx.timeline.width;
			}
		}
		
		protected function scrollerOut(event:MouseEvent):void
		{
			event.target.removeEventListener(MouseEvent.MOUSE_OUT, scrollerOut);
			event.target.removeEventListener(Event.ENTER_FRAME, scrollerEnterFrame);
			scrolling = false;
		}
		
		public function drawNextCard():void
		{
			Utils.clearChildren(gfx.nextCard);
			
			var nextCard:GuiCard = new GuiCard();
			nextCard.card = Game.deck.pop();
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
		
		protected var scrolling:Boolean = false;
		
		public static var instance:Gui;
	}
}