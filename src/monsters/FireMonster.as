package monsters 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class FireMonster extends Monster
	{
		
		public function FireMonster() 
		{
			name = "Firebolg";
			description = Game.creatureName + " erupted into a Firebolg!";
			graphic = new Sprite();
		}
		
		override public function willEvolveInto():Boolean 
		{
			if ( Game.stats.getStat(Config.STAT_FIRE) > Config.EVOLVE_REQ_HIGH ) {
				return true;
			}else {
				return false;
			}
		}
	}

}