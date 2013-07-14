package monsters 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class SkyMonster extends Monster
	{
		
		public function SkyMonster() 
		{
			name = "Windross";
			description = Game.creatureName + " hatched into a Windross!";
			graphic = new Sprite();
		}
		
		override public function willEvolveInto():Boolean 
		{
			if ( Game.stats.getStat(Config.STAT_WHITE) > Config.EVOLVE_REQ_HIGH ) {
				return true;
			}else {
				return false;
			}
		}
	}

}