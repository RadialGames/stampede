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
			return true;
		}
	}

}