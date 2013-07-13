package
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	/**
	 * Sprite representation of a thing you can do to your Rabbaroo.
	 */
	public dynamic class GuiCard extends Sprite
	{
		public function GuiCard()
		{
			gfx = new GfxCard();
			addChild(gfx);
			
			gfx.info.text = "skating";
			this.value = "skating";
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
		}
		
		protected function mouseDown(...ig):void
		{
			if (!Gui.instance.isNextCard(this)) {
				return;
			}
			startDrag();
			addEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}
		
		protected function mouseUp(...ig):void
		{
			stopDrag();
			Gui.instance.cardDropped(this);
		}
		
		protected var gfx:GfxCard;
	}
}