package actions.cards 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class CMuseum extends Card
	{
		
		public function CMuseum() 
		{
			title = "Teach Tricks"
			colour = Config.GREEN;
		}
		
		override public function doAction():void 
		{
			simpleCardAction(
				Game.creatureName + " immerses itself in culture!",
				Config.STAT_SKY,
				Config.CARD_HIGH_CHANGE
			);
		}
	}

}