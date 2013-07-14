package monsters 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class NegaMonster extends Monster
	{
		
		public function NegaMonster() 
		{
			name = "Negagore";
			description = Game.creatureName + " imploded into a Negagore!";
			graphic = new Sprite();
		}
		
		override public function willEvolveInto():Boolean 
		{
			if ( 
				Game.stats.getStat(Config.STAT_BROWN) <= Config.EVOLVE_REQ_VERY_LOW &&
				Game.stats.getStat(Config.STAT_RED) <= Config.EVOLVE_REQ_VERY_LOW &&
				Game.stats.getStat(Config.STAT_BLUE) <= Config.EVOLVE_REQ_VERY_LOW &&
				Game.stats.getStat(Config.STAT_WHITE) <= Config.EVOLVE_REQ_VERY_LOW
			) {
				return true;
			}else {
				return false;
			}
		}
	}

}