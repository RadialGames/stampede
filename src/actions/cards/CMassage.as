package actions.cards 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class CMassage extends Card
	{
		
		public function CMassage() 
		{
			title = "Massage"
			colour = Config.BLUE;
		}
		
		override public function doAction():void 
		{
			outcomeDescription = Game.creatureName + " enjoys an invigorating hot rock massage.";
			// add 3x blue/clean/water skill
		}
	}

}