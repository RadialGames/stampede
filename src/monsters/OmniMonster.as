package monsters 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class OmniMonster extends Monster
	{
		
		public function OmniMonster() 
		{
			name = "Omniolyte";
			description = Game.creatureName + " ascended into an Omniolyte!";
			graphic = new Sprite();
		}
		
		override public function willEvolveInto():Boolean 
		{
			if ( 
				Game.stats.getStat(Config.STAT_EARTH) >= Config.EVOLVE_REQ_VERY_HIGH &&
				Game.stats.getStat(Config.STAT_FIRE) >= Config.EVOLVE_REQ_VERY_HIGH &&
				Game.stats.getStat(Config.STAT_WATER) >= Config.EVOLVE_REQ_VERY_HIGH &&
				Game.stats.getStat(Config.STAT_SKY) >= Config.EVOLVE_REQ_VERY_HIGH
			) {
				return true;
			}else {
				return false;
			}
		}
	}

}