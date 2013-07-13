package actions.plots 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class PPLake extends PlotPoint
	{
		
		public function PPLake() 
		{
			title = "Lake Trip"
			colour = Config.ORANGE;
		}
		
		override public function doAction():void 
		{
			simplePlotAction(
				Game.creatureName + " goes for a great swim!",
				Game.creatureName + " almost drowns, and sulks on the shore.",
				Config.STAT_EARTH,
				Config.PLOT_HIGH_THRESH,
				Config.STAT_WATER,
				Config.PLOT_MID_CHANGE
			);			
		}
	}

}