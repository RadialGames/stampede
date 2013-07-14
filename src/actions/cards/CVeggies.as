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
			simpleCardAction(
				Game.creatureName + " munches away happily!",
				Config.STAT_EARTH,
				Config.CARD_LOW_CHANGE
			);
		}
	}

}