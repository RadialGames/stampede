package actions.cards 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class TWhite extends Card
	{
		
		public function TWhite() 
		{
			title = "Training"
			colour = Config.WHITE;
			outcomeDescription = "Teaching the monster to follow commands.\nRaises the White stat late, lowers it early.";
		}
		
		override public function doAction():void 
		{
			if ( Game.currentSlot >= Config.NUM_SLOTS / 2 ) {
				isOutcomePositive = true;
				
				Game.stats.setStat(Config.STAT_WHITE, Game.stats.getStat(Config.STAT_WHITE) + 20);
			}else {
				isOutcomePositive = false;
				
				Game.stats.setStat(Config.STAT_WHITE, Game.stats.getStat(Config.STAT_WHITE) - 20);
			}
		}
	}

}