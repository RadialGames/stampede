package actions.plots 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class PPMushrooms extends PlotPoint
	{
		
		public function PPMushrooms() 
		{
			title = "Wild Mushrooms"
			colour = Config.GREEN;
		}
		
		override public function doAction():void 
		{
			simplePlotAction(
				Game.creatureName + " wisely avoids the mushrooms and plays instead!",
				Game.creatureName + " eats the mushrooms and makes itself sick!",
				Config.STAT_SKY,
				Config.PLOT_HIGH_THRESH,
				Config.STAT_EARTH,
				Config.PLOT_MID_CHANGE
			);
		}
	}

}