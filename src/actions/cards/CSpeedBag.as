package actions.cards 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class CSpeedBag extends Card
	{
		
		public function CSpeedBag() 
		{
			title = "Speed Bag"
			colour = Config.RED;
		}
		
		override public function doAction():void 
		{
			simpleCardAction(
				Game.creatureName + " works up a sweat!",
				Config.STAT_FIRE,
				Config.CARD_LOW_CHANGE
			);
		}
	}

}