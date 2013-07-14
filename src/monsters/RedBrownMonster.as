package monsters 
{
	import actions.cards.*;
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class RedBrownMonster extends Monster
	{
		
		public function RedBrownMonster() 
		{
			name = "Terratrope";
			description = Game.creatureName + " evolved into a Terratrope!";
			
			// NOT BALANCED
			solution = new <Number>[50,50,30,30,30,30];
			activeStats = new <Boolean>[true, true, true, true, false, false];
			
			buildDeck(TRed, TRed, TBrown, TBrown, TGreen, TOrange);
		}
		
	}

}