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
		}
		
		override public function doAction():void 
		{
			Game.stats.setStat(Config.STAT_BROWN, Game.stats.getStat(Config.STAT_BROWN) + (((Config.NUM_SLOTS-1) - Game.currentSlot)+1)*5);
		}
	}

}