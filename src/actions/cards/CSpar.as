package actions.cards 
{
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class CSpar extends Card
	{
		
		public function CSpar() 
		{
			title = "Sparring"
			colour = Config.RED;
		}
		
		override public function doAction():void 
		{
			outcomeDescription = Game.creatureName + " spars energetically with other monsters!";
			// add 3x red/power/fire skill
		}
	}

}