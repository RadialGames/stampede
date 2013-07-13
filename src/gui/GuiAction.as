package gui
{
	import actions.Action;
	import actions.Card;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	/**
	 * Either a GuiCard or a GuiPlotPoint
	 */
	public dynamic class GuiAction extends Sprite
	{
		public function GuiAction(action:Action)
		{
			this.action = action;
		}
		
		public var action:Action;
	}
}