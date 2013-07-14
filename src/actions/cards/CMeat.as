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
			simpleCardAction(
				Game.creatureName + " devours some cruelty-free imitation meat!",
				Config.STAT_BROWN,
				Config.CARD_MID_CHANGE
			);
		}
	}

}