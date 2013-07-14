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
			return true;
		}
	}

}