package actions.cards 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class CMuseum extends Card
	{
		
		public function CMuseum() 
		{
			title = "Teach Tricks"
			colour = Config.GREEN;
		}
		
		override public function doAction():void 
		{
			outcomeDescription = Game.creatureName + " immerses itself in culture!";
			// add 3x green/logic/air skill
		}
	}

}