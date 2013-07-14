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
		}
		
		override public function doAction():void 
		{
			Game.stats.setStat(Config.STAT_BLUE, Game.stats.getStat(Config.STAT_BLUE) + ((Config.NUM_SLOTS - Game.currentSlot)+1)*10);
		}
	}

}