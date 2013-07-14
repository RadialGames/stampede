package actions.cards 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class TRed extends Card
	{
		
		public function TRed() 
		{
			title = "Sparring"
			colour = Config.RED;
			outcomeDescription = "Teaching the monster how to fight.\nIncrementally lowers stats early, raises late.";
		}
		
		override public function doAction():void 
		{
			if ( Game.currentSlot >= Config.NUM_SLOTS / 2 ) {
				Game.stats.setStat(Config.STAT_RED, Game.stats.getStat(Config.STAT_RED) + ((5-(((Config.NUM_SLOTS-1) - Game.currentSlot)+1))*5));
			}else {
				Game.stats.setStat(Config.STAT_RED, Game.stats.getStat(Config.STAT_RED) - ((((Config.NUM_SLOTS-1) - Game.currentSlot)+1)*5 - 20));
			}
		}
	}

}