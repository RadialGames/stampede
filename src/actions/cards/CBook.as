package actions.cards 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class CBook extends Card
	{
		
		public function CBook() 
		{
			title = "Book"
			colour = Config.GREEN;
		}
		
		override public function doAction():void 
		{
			simpleCardAction(
				Game.creatureName + " quietly listens to the story.",
				Config.STAT_SKY,
				Config.CARD_LOW_CHANGE
			);
		}
	}

}