package actions.cards 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class TOrange extends Card
	{
		
		public function TOrange() 
		{
			title = "Meat"
			colour = Config.ORANGE;
			outcomeDescription = "Feeding the monster some delicious meat.\nLowers states on even spaces, raises on odd.";
		}
		
		override public function doAction():void 
		{
			if ( Game.currentSlot % 2 == 0) {
				isOutcomePositive = true;
				
				Game.stats.setStat(Config.STAT_ORANGE, Game.stats.getStat(Config.STAT_ORANGE) + 20);
			}else {
				isOutcomePositive = false;				
				Game.stats.setStat(Config.STAT_ORANGE, Game.stats.getStat(Config.STAT_ORANGE) - 20);
			}
		}
	}

}