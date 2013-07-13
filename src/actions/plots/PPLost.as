package actions.plots 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class PPLost extends PlotPoint
	{
		
		public function PPLost() 
		{
			title = "Lost"
			colour = Config.BLUE;
		}
		
		override public function doAction():void 
		{
			outcomeDescription = Game.creatureName + " stays calm and finds its way home!";
			outComeBool = true;
			// add green/logic/air skill
			
			/* outcomeDescription = Game.creatureName + " cries and spends the night alone in the woods!";
			outComeBool = false;
			deduct green/logic/air skill */			
		}
	}

}