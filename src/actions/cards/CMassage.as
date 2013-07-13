package actions.cards 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class CMassage extends Card
	{
		
		public function CMassage() 
		{
			title = "Massage"
			colour = Config.BLUE;
		}
		
		override public function doAction():void 
		{
			simpleCardAction(
				Game.creatureName + " enjoys an invigorating hot rock massage.",
				Config.STAT_WATER,
				Config.CARD_HIGH_CHANGE
			);
		}
	}

}