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
			return true;
		}
	}

}