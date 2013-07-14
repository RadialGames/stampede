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
				Game.stats.getStat(Config.STAT_EARTH) <= Config.EVOLVE_REQ_VERY_LOW &&
				Game.stats.getStat(Config.STAT_FIRE) <= Config.EVOLVE_REQ_VERY_LOW &&
				Game.stats.getStat(Config.STAT_WATER) <= Config.EVOLVE_REQ_VERY_LOW &&
				Game.stats.getStat(Config.STAT_SKY) <= Config.EVOLVE_REQ_VERY_LOW
			) {
				return true;
			}else {
				return false;
			}
		}
	}

}