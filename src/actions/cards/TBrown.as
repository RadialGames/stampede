package actions.cards 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class TBrown extends Card
	{
		
		public function TBrown() 
		{
			title = "Grooming"
			colour = Config.BROWN;			
			outcomeDescription = "Brushing the monster's coat.\nIncrementally raises the black stat early, lowers it late.";
		}
		
		override public function doAction():void 
		{
			if ( Game.currentSlot >= Config.NUM_SLOTS / 2 ) {
				isOutcomePositive = true;
				Game.stats.setStat(Config.STAT_BROWN, Game.stats.getStat(Config.STAT_BROWN) - ((5-(((Config.NUM_SLOTS-1) - Game.currentSlot)+1))*5));
			}else {
				isOutcomePositive = false;				
				Game.stats.setStat(Config.STAT_BROWN, Game.stats.getStat(Config.STAT_BROWN) + ((((Config.NUM_SLOTS-1) - Game.currentSlot)+1)*5) - 20);
			}
		}
	}

}