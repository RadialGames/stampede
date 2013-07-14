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
			return true;
		}
	}

}