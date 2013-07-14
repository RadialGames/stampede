package monsters 
{
	import actions.cards.*;
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class FirstMidMonster extends Monster
	{
		
		public function FirstMidMonster() 
		{
			name = "Aqualope";
			description = Game.creatureName + " burst into a Aqualope!";
			
			solution = new <Number>[30,30,30,30,30,30];
			activeStats = new <Boolean>[true, true, true, true, false, false];
			
			buildDeck(TWhite, TBlue, TRed, TRed, TBrown, TBrown);
		}
		
	}

}