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
			title = "Red"
			colour = Config.RED;
		}
		
		override public function doAction():void 
		{
			Game.stats.setStat(Config.STAT_RED, Game.stats.getStat(Config.STAT_RED) + (1+Game.currentSlot)*5);
		}
	}

}