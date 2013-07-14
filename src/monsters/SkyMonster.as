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
			return true;
		}
	}

}