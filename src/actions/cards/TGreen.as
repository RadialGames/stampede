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
		}
		
		override public function doAction():void 
		{
			Game.stats.setStat(Config.STAT_GREEN, Game.stats.getStat(Config.STAT_GREEN) + (((Config.NUM_SLOTS-1) - Game.currentSlot)+1)*5);
		}
	}

}