package actions.plots 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class PPMushrooms extends PlotPoint
	{
		
		public function PPMushrooms() 
		{
			title = "Wild Mushrooms"
			colour = Config.GREEN;
		}
		
		override public function doAction():void 
		{
			outcomeDescription = Game.creatureName + " wisely avoids the mushrooms and plays instead!";
			outComeBool = true;
			// add orange/health/earth skill
			
			/* outcomeDescription = Game.creatureName + " eats the mushrooms and makes itself sick!";
			outComeBool = false;
			deduct orange/health/earth skill */	
		}
	}

}