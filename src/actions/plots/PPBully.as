package actions.plots 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class PPBully extends PlotPoint
	{
		
		public function PPBully() 
		{
			title = "Bully"
			colour = Config.RED;
		}
		
		override public function doAction():void 
		{
			simplePlotAction(
				Game.creatureName + " scares off a potential bully!",
				Game.creatureName + " is picked on by a larger monster.",
				Config.STAT_FIRE,
				Config.PLOT_HIGH_THRESH,
				Config.STAT_WATER,
				Config.PLOT_MID_CHANGE
			);
		}
	}

}