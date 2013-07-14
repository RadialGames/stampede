package actions.plots 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class PPPlay extends PlotPoint
	{
		
		public function PPPlay() 
		{
			title = "Play with Friends"
			colour = Config.BLUE;
		}
		
		override public function doAction():void 
		{
			simplePlotAction(
				Game.creatureName + " roughhouses with other monsters!",
				Game.creatureName + " has no friends to play with.",
				Config.STAT_BLUE,
				Config.PLOT_HIGH_THRESH,
				Config.STAT_RED,
				Config.PLOT_MID_CHANGE
			);		
		}
	}

}