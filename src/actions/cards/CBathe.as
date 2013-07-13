package actions.cards 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class CBathe extends Card
	{
		
		public function CBathe() 
		{
			title = "Bathe"
			colour = Config.BLUE;
		}
		
		override public function doAction():void 
		{
			outcomeDescription = Game.creatureName + " takes a long, hot bath.";
			// add blue/clean/water skill
		}
	}

}