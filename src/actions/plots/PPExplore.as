package actions.plots 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class PPExplore extends PlotPoint
	{
		
		public function PPExplore() 
		{
			title = "Exploration"
			colour = Config.ORANGE;
		}
		
		override public function doAction():void 
		{
			simplePlotAction(
				Game.creatureName + " explores a nearby cave!",
				Game.creatureName + " gets tired and goes home.",
				Config.STAT_BROWN,
				Config.PLOT_HIGH_THRESH,
				Config.STAT_WHITE,
				Config.PLOT_MID_CHANGE
			);		
		}
	}

}