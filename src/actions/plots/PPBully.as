package actions.plots 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class PPBully extends PlotPoint
	{
		
		public function PPBully() 
		{
			title = "Bully"
			colour = Config.RED;
		}
		
		override public function doAction():void 
		{
			outcomeDescription = Game.creatureName + " scares off a potential bully!";
			outComeBool = true;
			// add blue/clean/water skill
			
			/* outcomeDescription = Game.creatureName + " is picked on by a larger monster.";
			outComeBool = false;
			deduct blue/clean/water skill */			
		}
	}

}