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
			title = "Normalize"
			colour = Config.BLUE;
			outcomeDescription = "Moves stats toward the center.";
		}
		
		override public function doAction():void 
		{
			for each (var stat:String in Config.ALL_STATS) {
				if (Game.stats.getStat(stat) > 50) {
					Game.stats.setStat(stat, Game.stats.getStat(stat) - 20);
				}
				else {
					Game.stats.setStat(stat, Game.stats.getStat(stat) + 20);
				}
			}
		}
	}

}