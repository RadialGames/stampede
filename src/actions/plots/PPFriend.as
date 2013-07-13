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
			outcomeDescription = Game.creatureName + " makes a new friend!";
			outComeBool = true;
			// add orange/health/earth skill
			
			/* outcomeDescription = Game.creatureName + " insults a stranger and gets beat up!";
			outComeBool = false;
			deduct orange/health/earth skill */			
		}
	}

}