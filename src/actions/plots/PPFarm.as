package actions.plots 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class PPFarm extends PlotPoint
	{
		
		public function PPFarm() 
		{
			title = "Help Farm"
			colour = Config.RED;
		}
		
		override public function doAction():void 
		{
			outcomeDescription = Game.creatureName + " helps out around the farm!";
			outComeBool = true;
			// add green/logic/air skill
			
			/* outcomeDescription = Game.creatureName + " is too weak to help out around the farm.";
			outComeBool = false;
			deduct green/logic/air skill */			
		}
	}

}