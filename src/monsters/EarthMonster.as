package monsters 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class EarthMonster extends Monster
	{
		
		public function EarthMonster() 
		{
			name = "Terratrope";
			description = Game.creatureName + " burst into a Terratrope!";
			graphic = new Sprite();
		}
		
		override public function willEvolveInto():Boolean 
		{
			if ( Game.stats.getStat(Config.STAT_EARTH) > Config.EVOLVE_REQ_HIGH ) {
				return true;
			}else {
				return false;
			}
		}
	}

}