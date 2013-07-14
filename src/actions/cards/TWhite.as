package actions.cards 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class TWhite extends Card
	{
		
		public function TWhite() 
		{
			title = "White"
			colour = Config.WHITE;
		}
		
		override public function doAction():void 
		{
			if( Game.currentSlot > Config.NUM_SLOTS / 2 ){
				Game.stats.setStat(Config.STAT_WHITE, Game.stats.getStat(Config.STAT_WHITE) + (Math.ceil((Game.currentSlot+1) / 2))*10);
			}else {
				Game.stats.setStat(
					Config.STAT_WHITE, 
					Game.stats.getStat(Config.STAT_WHITE) + (Math.floor(((Config.NUM_SLOTS - Game.currentSlot)+1) / 2)*10)
				);
			}
		}
	}

}