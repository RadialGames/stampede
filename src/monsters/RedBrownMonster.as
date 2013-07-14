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
			
			solution = new <Number>[50,50,80,80,30,30];
			activeStats = new <Boolean>[false, false, true, true, true, true];
			
			buildDeck(TRed, TRed, TBrown, TBrown, TGreen, TOrange);
		}
		
	}

}