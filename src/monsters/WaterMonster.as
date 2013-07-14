package monsters 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class WaterMonster extends Monster
	{
		
		public function WaterMonster() 
		{
			name = "Aqualope";
			description = Game.creatureName + " coalesced into an Aqualope!";
			graphic = new Sprite();
		}
		
		override public function willEvolveInto():Boolean 
		{
			if ( Game.stats.getStat(Config.STAT_BLUE) > Config.EVOLVE_REQ_HIGH ) {
				return true;
			}else {
				return false;
			}
		}
	}

}