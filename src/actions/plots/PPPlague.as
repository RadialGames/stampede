package actions.plots 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class PPPlague extends PlotPoint
	{
		
		public function PPPlague() 
		{
			title = "Monster Plague"
			colour = Config.ORANGE;
		}
		
		override public function doAction():void 
		{
			outcomeDescription = Game.creatureName + " doesn't get sick!";
			outComeBool = true;
			// add red/power/fire skill
			
			/* outcomeDescription = Game.creatureName + " comes down with the monster plague!";
			outComeBool = false;
			deduct red/power/fire skill */			
		}
	}

}