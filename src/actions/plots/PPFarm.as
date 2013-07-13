package actions.plots 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class PPFarm extends PlotPoint
	{
		
		public function PPFarm() 
		{
			title = "Help Farm"
			colour = Config.RED;
		}
		
		override public function doAction():void 
		{
			simplePlotAction(
				Game.creatureName + " helps out around the farm!",
				Game.creatureName + " is too weak to help out around the farm.",
				Config.STAT_FIRE,
				Config.PLOT_HIGH_THRESH,
				Config.STAT_SKY,
				Config.PLOT_MID_CHANGE
			);		
		}
	}

}