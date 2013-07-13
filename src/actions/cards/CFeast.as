package actions.cards 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class CFeast extends Card
	{
		
		public function CFeast() 
		{
			title = "Feast"
			colour = Config.ORANGE;
		}
		
		override public function doAction():void 
		{
			simpleCardAction(
				Game.creatureName + " gorges itself on a variety of foods!",
				Config.STAT_EARTH,
				Config.CARD_HIGH_CHANGE
			);
		}
	}

}