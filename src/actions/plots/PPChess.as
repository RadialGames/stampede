package actions.plots 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class PPChess extends PlotPoint
	{
		
		public function PPChess() 
		{
			title = "Chess"
			colour = Config.GREEN;
		}
		
		override public function doAction():void 
		{
			simplePlotAction(
				Game.creatureName + " plays a complicated game with other monsters!",
				Game.creatureName + " can't figure out how to play.",
				Config.STAT_WHITE,
				Config.PLOT_HIGH_THRESH,
				Config.STAT_BLUE,
				Config.PLOT_MID_CHANGE
			);		
		}
	}

}