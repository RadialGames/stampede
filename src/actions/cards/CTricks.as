package actions.cards 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class CTricks extends Card
	{
		
		public function CTricks() 
		{
			title = "Teach Tricks"
			colour = Config.GREEN;
		}
		
		override public function doAction():void 
		{
			simpleCardAction(
				Game.creatureName + " patiently learns a new command!",
				Config.STAT_WHITE,
				Config.CARD_MID_CHANGE
			);
		}
	}

}