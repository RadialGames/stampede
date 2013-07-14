package actions.cards 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class TStandardizeLow extends Card
	{
		
		public function TStandardizeLow() 
		{
			title = "Take a Break"
			colour = Config.PURPLE;
			outcomeDescription = "Let the monster relax.\nMakes all stats equal the monster's lowest.";
		}
		
		override public function doAction():void 
		{
			var lowestStat:Number = 100;
			for each (var stat:String in Config.ALL_STATS) {
				if (Game.stats.getStat(stat) < lowestStat) {
					lowestStat = Game.stats.getStat(stat)
				}
			}
			for each (var adjustStat:String in Config.ALL_STATS) {
				Game.stats.setStat(adjustStat, lowestStat)
			}
		}
	}

}