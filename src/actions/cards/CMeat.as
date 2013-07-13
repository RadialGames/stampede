package actions.cards 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class CMeat extends Card
	{
		
		public function CMeat() 
		{
			title = "Meat"
			colour = Config.ORANGE;
		}
		
		override public function doAction():void 
		{
			outcomeDescription = Game.creatureName + " devours some cruelty-free imitation meat!";
			// add 2x orange/health/earth skill
		}
	}

}