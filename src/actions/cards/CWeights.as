package actions.cards 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class CWeights extends Card
	{
		
		public function CWeights() 
		{
			title = "Weight Training"
			colour = Config.RED;
		}
		
		override public function doAction():void 
		{
			outcomeDescription = Game.creatureName + " carries some heavy weights!";
			// add 2x red/power/fire skill
		}
	}

}