package actions.plots 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class PPLake extends PlotPoint
	{
		
		public function PPLake() 
		{
			title = "Lake Trip"
			colour = Config.ORANGE;
		}
		
		override public function doAction():void 
		{
			outcomeDescription = Game.creatureName + " goes for a great swim!";
			outComeBool = true;
			// add blue/clean/water skill
			
			/* outcomeDescription = Game.creatureName + " almost drowns, and sulks on the shore.";
			outComeBool = false;
			deduct blue/clean/water skill */			
		}
	}

}