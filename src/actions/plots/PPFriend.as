package actions.plots 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class PPFriend extends PlotPoint
	{
		
		public function PPFriend() 
		{
			title = "Strange Monster"
			colour = Config.BLUE;
		}
		
		override public function doAction():void 
		{
			simplePlotAction(
				Game.creatureName + " makes a new friend!",
				Game.creatureName + " insults a stranger and gets beat up!",
				Config.STAT_WATER,
				Config.PLOT_HIGH_THRESH,
				Config.STAT_EARTH,
				Config.PLOT_MID_CHANGE
			);			
		}
	}

}