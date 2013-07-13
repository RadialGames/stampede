package actions.plots 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class PPExplore extends PlotPoint
	{
		
		public function PPExplore() 
		{
			title = "Exploration"
			colour = Config.ORANGE;
		}
		
		override public function doAction():void 
		{
			outcomeDescription = Game.creatureName + " explores a nearby cave!";
			outComeBool = true;
			// add green/logic/air skill
			
			/* outcomeDescription = Game.creatureName + " gets tired and goes home.";
			outComeBool = false;
			deduct green/logic/air skill */			
		}
	}

}