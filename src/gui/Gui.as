package gui
{
	import actions.Action;
	import actions.cards.Card;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
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
			gfx.edgeScrollerLeft.useHandCursor = false;
			
			GuiButton.replaceButton(gfx.edgeScrollerRight);
			gfx.edgeScrollerRight.addEventListener(MouseEvent.MOUSE_OVER, scrollerOver);
			gfx.edgeScrollerRight.useHandCursor = false;
			
			addEventListener(Event.ENTER_FRAME, enterFrame);
			
			drawNextCard();
		}
		
		/**
		 * Show or hide the tooltip when over a card.
		 */
		protected function enterFrame(...ig):void
		{
			// if we're over a card or plotPoint, show the tooltip for it
			var globalPoint:Point = new Point(stage.mouseX, stage.mouseY);
			var objectsUnderPoint:Array = stage.getObjectsUnderPoint(globalPoint);
			Utils.log("\n\nobj under point: " + objectsUnderPoint.length);
			var showtingTooltip:Boolean = false;
			for each (var object:DisplayObject in objectsUnderPoint) {
				var action:GuiAction = Utils.findAncestor(object, GuiAction);
				if (action != null && (action is GuiPlotPoint || !isNextCard(action as GuiCard))) {
					showTooltip(action);
					showtingTooltip = true;
				}
			}
			if (!showtingTooltip) {
				hideTooltip();
			}
		}
		
		protected function scrollerOver(event:MouseEvent):void
		{
			event.target.addEventListener(MouseEvent.MOUSE_OUT, scrollerOut);
			event.target.addEventListener(Event.ENTER_FRAME, scrollerEnterFrame);
		}
		
		protected function scrollerEnterFrame(event:Event):void
		{
			var left:Boolean = (event.target == gfx.edgeScrollerLeft);
			
			// from 0 (inside) to 1 (outside)
			var scrollXPercent:Number = event.target.mouseX / event.target.width;
			var diffX:Number = 20 * scrollXPercent;
			if (event.target != gfx.edgeScrollerLeft) {
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
		}
		
		protected function showTooltip(guiAction:GuiAction):void
		{
			if (Utils.isEmpty(guiAction.action.outcomeDescription)) {
				gfx.tooltip.info.text = "Blah blahblahblah blah";
			} else {
				gfx.tooltip.info.text = guiAction.action.outcomeDescription;
			}
			gfx.tooltip.x = guiAction.localToGlobal(new Point(0, 0)).x + (guiAction.width / 2);
			Utils.addToParent(gfx, gfx.tooltip);
		}
		
		public function hideTooltip(...ig):void
		{
			Utils.removeFromParent(gfx.tooltip);
		}
		
		public function drawNextCard():void
		{
			Utils.clearChildren(gfx.nextCard);
			
			var card:Card;
			try {
				card = Game.deck.pop();
			} catch (error:Error) {
				Utils.logError(error);
				card = new Card();
			}
			var nextCard:GuiCard = new GuiCard(card);
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
		
		public static var instance:Gui;
	}
}