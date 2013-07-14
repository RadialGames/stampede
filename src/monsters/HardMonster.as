package monsters 
{
	import actions.cards.*;
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class HardMonster extends Monster
	{
		
		public function HardMonster() 
		{
			name = "Firebat";
			description = Game.creatureName + " evolved into a Firebat!";
			
			solution = new <Number>[30,30,30,30,30,30];
			activeStats = new <Boolean>[true, true, true, true, true, true];
			
			buildDeck(TWhite, TBlue, TRed, TBrown, TGreen, TOrange);
		}
		
	}

}