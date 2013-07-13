package gui
{
	import actions.PlotPoint;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	/**
	 * Sprite representation of a thing you can do to your Rabbaroo.
	 */
	public dynamic class GuiPlotPoint extends GuiAction
	{
		public function GuiPlotPoint(plotPoint:PlotPoint)
		{
			super(plotPoint);
			
			gfx = new GfxPlotPoint();
			addChild(gfx);
			
			gfx.info.text = "plot pt";
		}
		
		protected var gfx:GfxPlotPoint;
	}
}