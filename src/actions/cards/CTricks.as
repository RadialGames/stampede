package actions.cards 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class CTricks extends Card
	{
		
		public function CTricks() 
		{
			title = "Teach Tricks"
			colour = Config.GREEN;
		}
		
		override public function doAction():void 
		{
			outcomeDescription = Game.creatureName + " patiently learns a new command!";
			// add 2x green/logic/air skill
		}
	}

}