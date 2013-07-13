package actions.plots 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class PPSkating extends PlotPoint
	{
		
		public function PPSkating() 
		{
			title = "Skating"
			colour = Config.GREEN;
		}
		
		override public function doAction():void 
		{
			outcomeDescription = Game.creatureName + " skates beautifully!";
			outComeBool = true;
			// add red/power/fire skill
			
			/* outcomeDescription = Game.creatureName + " can't stop falling down on the ice.";
			outComeBool = false;
			deduct red/power/fire skill */			
		}
	}

}