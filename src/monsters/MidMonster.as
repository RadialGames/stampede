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
			name = "Firebat";
			description = Game.creatureName + " erupted into a Firebat!";
			
			solution = new <Number>[50,50,50,50,50,50];
			activeStats = new <Boolean>[true, true, true, true, false, false];
			
			buildDeck(TWhite, TWhite, TBlue, TBlue, TRed, TRed, TBrown, TBrown);
		}
		
	}

}