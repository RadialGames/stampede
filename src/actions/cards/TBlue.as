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
			title = "Blue"
			colour = Config.BLUE;
			outcomeDescription = "Raises early, lowers late.";
		}
		
		override public function doAction():void 
		{
			if( Game.currentSlot < Config.NUM_SLOTS / 2 ){
				Game.stats.setStat(Config.STAT_BLUE, Game.stats.getStat(Config.STAT_BLUE) + 20);
			}else {
				Game.stats.setStat(Config.STAT_BLUE, Game.stats.getStat(Config.STAT_BLUE) - 20);
			}
		}
	}

}