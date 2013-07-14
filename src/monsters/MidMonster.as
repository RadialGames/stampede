package monsters 
{
	import actions.cards.*;
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class MidMonster extends Monster
	{
		
		public function MidMonster() 
		{
			name = "Windross";
			description = Game.creatureName + " evolved into a Windross!";
			
			solution = new <Number>[50,50,50,50,50,50];
			activeStats = new <Boolean>[true, true, true, true, false, false];
			
			buildDeck(TWhite, TWhite, TBlue, TBlue, TRed, TRed, TBrown, TBrown);
		}
		
	}

}