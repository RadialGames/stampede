package actions.plots 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class PPSkating extends PlotPoint
	{
		
		public function PPSkating() 
		{
			title = "Skating"
			colour = Config.GREEN;
		}
		
		override public function doAction():void 
		{
			simplePlotAction(
				Game.creatureName + " skates beautifully!",
				Game.creatureName + " can't stop falling down on the ice.",
				Config.STAT_SKY,
				Config.PLOT_HIGH_THRESH,
				Config.STAT_FIRE,
				Config.PLOT_MID_CHANGE
			);		
		}
	}

}