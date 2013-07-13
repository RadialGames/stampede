package actions.cards 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class CBrush extends Card
	{
		
		public function CBrush() 
		{
			title = "Brush"
			colour = Config.BLUE;
		}
		
		override public function doAction():void 
		{
			simpleCardAction(
				Game.creatureName + "'s coat shines!",
				Config.STAT_WATER,
				Config.CARD_LOW_CHANGE
			);
		}
	}

}