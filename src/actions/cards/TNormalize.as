package actions.cards 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class TNormalize extends Card
	{
		
		public function TNormalize() 
		{
			title = "Play with Others"
			colour = Config.PURPLE;
			outcomeDescription = "Have the monster play with other monsters.\nMoves stats toward the center.";
		}
		
		override public function doAction():void 
		{
			for each (var stat:String in Config.ALL_STATS) {
				if (Game.stats.getStat(stat) > 50) {
					isOutcomePositive = false;					
					Game.stats.setStat(stat, Game.stats.getStat(stat) - 20);
				}
				else {
					isOutcomePositive = true;
					
					Game.stats.setStat(stat, Game.stats.getStat(stat) + 20);
				}
			}
		}
	}

}