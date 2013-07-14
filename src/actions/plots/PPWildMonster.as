package actions.plots 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class PPWildMonster extends PlotPoint
	{
		
		public function PPWildMonster() 
		{
			title = "Wild Monster"
			colour = Config.RED;
		}
		
		override public function doAction():void 
		{
			simplePlotAction(
				Game.creatureName + " fights off the wild monster!",
				Game.creatureName + " gets really beat up!",
				Config.STAT_RED,
				Config.PLOT_HIGH_THRESH,
				Config.STAT_BROWN,
				Config.PLOT_MID_CHANGE
			);
		}
	}

}