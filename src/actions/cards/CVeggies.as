package actions.cards 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class CVeggies extends Card
	{
		
		public function CVeggies() 
		{
			title = "Veggies"
			colour = Config.ORANGE;
		}
		
		override public function doAction():void 
		{
			outcomeDescription = Game.creatureName + " munches away happily!";
			// add orange/health/earth skill
		}
	}

}