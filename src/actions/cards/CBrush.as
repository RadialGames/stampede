package actions.cards 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class CBrush extends Card
	{
		
		public function CBrush() 
		{
			title = "Brush"
			colour = Config.BLUE;
		}
		
		override public function doAction():void 
		{
			outcomeDescription = Game.creatureName + "'s coat shines!";
			// add blue/clean/water skill
		}
	}

}