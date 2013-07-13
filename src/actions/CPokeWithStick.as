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
			description = "Poke "+Game.creatureName+" with a Stick!"
		}
		
		override public function doAction():void 
		{
			outcomeDescription = "You poke "+Game.creatureName+" with a stick, their anger went up!";
		}
	}

}