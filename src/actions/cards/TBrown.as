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
			title = "Brown"
			colour = Config.BROWN;			
			outcomeDescription = "Incrementally raises early, lowers late.";
		}
		
		override public function doAction():void 
		{
			if ( Game.currentSlot >= Config.NUM_SLOTS / 2 ) {
				Game.stats.setStat(Config.STAT_BROWN, Game.stats.getStat(Config.STAT_BROWN) - ((5-(((Config.NUM_SLOTS-1) - Game.currentSlot)+1))*5));
			}else {
				Game.stats.setStat(Config.STAT_BROWN, Game.stats.getStat(Config.STAT_BROWN) + ((((Config.NUM_SLOTS-1) - Game.currentSlot)+1)*5) - 20);
			}
		}
	}

}