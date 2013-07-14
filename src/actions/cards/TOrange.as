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
			title = "Orange"
			colour = Config.ORANGE;
		}
		
		override public function doAction():void 
		{
			Game.stats.setStat(Config.STAT_ORANGE, Game.stats.getStat(STAT_ORANGE) + (((Config.NUM_SLOTS-1) - Game.currentSlot)+1)*5);
		}
	}

}