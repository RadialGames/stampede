package actions.cards 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class CBook extends Card
	{
		
		public function CBook() 
		{
			title = "Book"
			colour = Config.GREEN;
		}
		
		override public function doAction():void 
		{
			outcomeDescription = Game.creatureName + " quietly listens to the story.";
			// add green/logic/air skill
		}
	}

}