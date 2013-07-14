package monsters 
{
	import actions.cards.*;
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class FirstMidMonster2 extends Monster
	{
		
		public function FirstMidMonster2() 
		{
			name = "Terratrope";
			description = Game.creatureName + " evolved into a Terratrope!";
			
			solution = new <Number>[30,30,30,30,30,30];
			activeStats = new <Boolean>[true, true, true, true, false, false];
			
			buildDeck(TWhite, TBlue, TRed, TRed, TBrown, TBrown);
		}
		
	}

}