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
			outcomeDescription = Game.creatureName + " plays a complicated game with other monsters!";
			outComeBool = true;
			// add blue/clean/water skill 
			
			/* outcomeDescription = Game.creatureName + " can't figure out how to play.";
			outComeBool = false;
			deduct blue/clean/water skill */			
		}
	}

}