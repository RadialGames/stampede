package actions.cards 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class TRadicalize extends Card
	{
		
		public function TRadicalize() 
		{
			title = "Explore"
			colour = Config.PURPLE;
			outcomeDescription = "Explore the world with your monster.\nMoves stats away from the center.";
		}
		
		override public function doAction():void 
		{
			for each (var stat:String in Config.ALL_STATS) {
				if (Game.stats.getStat(stat) > 50) {
					isOutcomePositive = false;					
					Game.stats.setStat(stat, Game.stats.getStat(stat) + 20);
				}
				else {
					isOutcomePositive = true;					
					Game.stats.setStat(stat, Game.stats.getStat(stat) - 20);
				}
			}
		}
	}

}