package actions.cards 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class CSpar extends Card
	{
		
		public function CSpar() 
		{
			title = "Sparring"
			colour = Config.RED;
		}
		
		override public function doAction():void 
		{
			simpleCardAction(
				Game.creatureName + " spars energetically with other monsters!",
				Config.STAT_FIRE,
				Config.CARD_HIGH_CHANGE
			);
		}
	}

}