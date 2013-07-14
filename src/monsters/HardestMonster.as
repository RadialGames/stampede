package monsters 
{
	import actions.cards.*;
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class HardestMonster extends Monster
	{
		
		public function HardestMonster() 
		{
			name = "Windross";
			description = Game.creatureName + " ascended into an Windross!";
			
			solution = new <Number>[45,45,45,45,45,45];
			activeStats = new <Boolean>[true, true, true, true, true, true];
			
			buildDeck(TWhite, TBlue, TRed, TBrown, TGreen, TOrange, TStandardizeLow, TNormalize);
		}
		
	}

}