package actions.cards 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class TGreen extends Card
	{
		
		public function TGreen() 
		{
			title = "Green"
			colour = Config.GREEN;			
			outcomeDescription = "Raises on even slots, lowers on odd.";
		}
		
		override public function doAction():void 
		{			
			if ( Game.currentSlot % 2 == 0) {
				Game.stats.setStat(Config.STAT_GREEN, Game.stats.getStat(Config.STAT_GREEN) - 20);
			}else {
				Game.stats.setStat(Config.STAT_GREEN, Game.stats.getStat(Config.STAT_GREEN) + 20);
			}
		}
	}

}