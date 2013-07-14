package actions.cards 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class TBlue extends Card
	{
		
		public function TBlue() 
		{
			title = "Reading"
			colour = Config.BLUE;
			outcomeDescription = "Reading to the monster.\nRaises stats early, lowers late.";
		}
		
		override public function doAction():void 
		{
			if( Game.currentSlot < Config.NUM_SLOTS / 2 ){
				Game.stats.setStat(Config.STAT_BLUE, Game.stats.getStat(Config.STAT_BLUE) + 20);
				isOutcomePositive = true;
			}else {
				isOutcomePositive = false;								
				Game.stats.setStat(Config.STAT_BLUE, Game.stats.getStat(Config.STAT_BLUE) - 20);
			}
		}
	}

}