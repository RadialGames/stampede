package actions.plots 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class PPPlague extends PlotPoint
	{
		
		public function PPPlague() 
		{
			title = "Monster Plague"
			colour = Config.ORANGE;
		}
		
		override public function doAction():void 
		{
			simplePlotAction(
				Game.creatureName + " doesn't get sick!",
				Game.creatureName + " comes down with the monster plague!",
				Config.STAT_BROWN,
				Config.PLOT_HIGH_THRESH,
				Config.STAT_RED,
				Config.PLOT_MID_CHANGE
			);			
		}
	}

}