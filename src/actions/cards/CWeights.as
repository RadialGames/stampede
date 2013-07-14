package actions.cards 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class CWeights extends Card
	{
		
		public function CWeights() 
		{
			title = "Weight Training"
			colour = Config.RED;
		}
		
		override public function doAction():void 
		{
			simpleCardAction(
				Game.creatureName + " carries some heavy weights!",
				Config.STAT_RED,
				Config.CARD_MID_CHANGE
			);
		}
	}

}