package gui
{
	import actions.cards.Card;
	import aze.motion.eaze;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import actions.cards.Card;
	/**
	 * Sprite representation of a thing you can do to your Rabbaroo.
	 */
	public dynamic class GuiCard extends GuiAction
	{
		public function GuiCard(card:Card)
		{
			super(card);
			
			gfx = new GfxCard();
			addChild(gfx);
			eaze(gfx).to(1).tint(card.colour, 0.8, 0.8);
			
			gfx.info.text = card.title;
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
		}
		
		protected function mouseDown(...ig):void
		{
			//if (!Gui.instance.isNextCard(this)) {
				//return;
			//}
			startDrag();
			eaze(this).to(0.2, { scaleX:1.2, scaleY:1.2 }, false);
			Main.addStageEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}
		
		protected function mouseUp(...ig):void
		{
			Main.removeStageEventListener(MouseEvent.MOUSE_UP, mouseUp);
			stopDrag();
			eaze(this).to(0.2, { scaleX:1.0, scaleY:1.0 }, false);
			Gui.instance.timeline.cardDropped(this);
		}
		
		protected var gfx:GfxCard;
	}
}