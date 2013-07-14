package monsters 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class NegaMonster extends Monster
	{
		
		public function NegaMonster() 
		{
			name = "Negagore";
			description = Game.creatureName + " imploded into a Negagore!";
			graphic = new Sprite();
		}
		
		override public function willEvolveInto():Boolean 
		{
			return true;
		}
	}

}