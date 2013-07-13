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
			outcomeDescription = Game.creatureName + " roughhouses with other monsters!";
			outComeBool = true;
			// add red/power/fire skill
			
			/* outcomeDescription = Game.creatureName + " has no friends to play with.";
			outComeBool = false;
			deduct red/power/fire skill */			
		}
	}

}