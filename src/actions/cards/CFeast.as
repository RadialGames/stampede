package actions.cards 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class CFeast extends Card
	{
		
		public function CFeast() 
		{
			title = "Feast"
			colour = Config.ORANGE;
		}
		
		override public function doAction():void 
		{
			outcomeDescription = Game.creatureName + " gorges itself on a variety of foods!";
			// add 3x orange/health/earth skill
		}
	}

}