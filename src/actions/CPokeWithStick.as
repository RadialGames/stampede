package actions 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class CPokeWithStick extends Card
	{
		
		public function CPokeWithStick() 
		{
			title = "Poke with a Stick!"
			colour = Config.RED;
		}
		
		override public function doAction():void 
		{
			outcomeDescription = "You poke "+Game.creatureName+" with a stick, their anger went up!";
		}
	}

}