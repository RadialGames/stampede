package monsters 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class Sloth extends Monster
	{
		
		public function Sloth() 
		{
			name = "Sloth";
			description = Game.creatureName + " was lazy and became a Sloth";
			graphic = new Sprite();
		}
		
		override public function willEvolveInto():Boolean 
		{
			return true;
		}
	}

}