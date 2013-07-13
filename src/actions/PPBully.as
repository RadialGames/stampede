package actions 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class PPBully extends PlotPoint
	{
		
		public function PPBully() 
		{
			description = "A bully attacks "+Game.creatureName+"!"
		}
		
		override public function doAction():void 
		{
			outcomeDescription = Game.creatureName+ " beat up the bully!";
			outComeBool = true;
		}
	}

}