package monsters 
{
	import actions.cards.*;
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class HardesterMonster extends Monster
	{
		
		public function HardesterMonster() 
		{
			name = "Windross";
			description = Game.creatureName + " ascended into an Windross!";
			
			// NOT YET BALANCED
			solution = new <Number>[45,45,45,45,45,45];
			activeStats = new <Boolean>[true, true, true, true, true, true];
			
			buildDeck(TWhite, TBlue, TRed, TBrown, TGreen, TOrange, TStandardizeLow, TStandardizeHigh);
		}
		
	}

}