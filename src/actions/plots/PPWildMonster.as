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
			outcomeDescription = Game.creatureName + " fights off the wild monster!";
			outComeBool = true;
			// add orange/health/earth skill
			
			/* outcomeDescription = Game.creatureName + " gets really beat up!";
			outComeBool = false;
			deduct orange/health/earth skill */			
		}
	}

}