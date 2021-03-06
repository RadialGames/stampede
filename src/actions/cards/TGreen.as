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
			title = "Veggies"
			colour = Config.GREEN;			
			outcomeDescription = "Feeding the monster some healthy greens.\nRaises the green stat on even spaces, lowers it on odd.";
		}
		
		override public function doAction():void 
		{			
			if ( Game.currentSlot % 2 == 0) {
				isOutcomePositive = false;				
				Game.stats.setStat(Config.STAT_GREEN, Game.stats.getStat(Config.STAT_GREEN) - 20);
			}else {
				isOutcomePositive = true;
				Game.stats.setStat(Config.STAT_GREEN, Game.stats.getStat(Config.STAT_GREEN) + 20);
			}
		}
	}

}