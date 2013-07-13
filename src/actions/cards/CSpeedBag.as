package actions.cards 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class CSpeedBag extends Card
	{
		
		public function CSpeedBag() 
		{
			title = "Speed Bag"
			colour = Config.RED;
		}
		
		override public function doAction():void 
		{
			outcomeDescription = Game.creatureName + " works up a sweat!";
			// add red/power/fire skill
		}
	}

}