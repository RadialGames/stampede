package actions.cards 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class CBathe extends Card
	{
		
		public function CBathe() 
		{
			title = "Bathe"
			colour = Config.BLUE;
		}
		
		override public function doAction():void 
		{
			simpleCardAction(
				Game.creatureName + " takes a long, hot bath.",
				Config.STAT_BLUE,
				Config.CARD_MID_CHANGE
			);
		}
	}

}