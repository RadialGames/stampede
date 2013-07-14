package actions.plots 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class PPLost extends PlotPoint
	{
		
		public function PPLost() 
		{
			title = "Lost"
			colour = Config.BLUE;
		}
		
		override public function doAction():void 
		{
			simplePlotAction(
				Game.creatureName + " stays calm and finds its way home!",
				Game.creatureName + " cries and spends the night alone in the woods!",
				Config.STAT_BLUE,
				Config.PLOT_HIGH_THRESH,
				Config.STAT_WHITE,
				Config.PLOT_MID_CHANGE
			);			
		}
	}

}