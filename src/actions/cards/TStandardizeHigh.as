package actions.cards 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class TStandardizeHigh extends Card
	{
		
		public function TStandardizeHigh() 
		{
			title = "Work the Farm"
			colour = Config.PURPLE;
			outcomeDescription = "Have the monster help around the ranch.\nMakes all stats equal the monster's highest.";
		}
		
		override public function doAction():void 
		{
			isOutcomePositive = true;
			
			var highestStat:Number = 0;
			for each (var stat:String in Config.ALL_STATS) {
				if (Game.stats.getStat(stat) > highestStat) {
					highestStat = Game.stats.getStat(stat)
				}
			}
			for each (var adjustStat:String in Config.ALL_STATS) {
				Game.stats.setStat(adjustStat, highestStat)
			}
		}
	}

}