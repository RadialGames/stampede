package monsters 
{
	import actions.cards.*;
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class HarderMonster extends Monster
	{
		
		public function HarderMonster() 
		{
			name = "Aqualope";
			description = Game.creatureName + " evolved into a Aqualope!";
			
			solution = new <Number>[90,90,90,90,90,90];
			activeStats = new <Boolean>[true, true, true, true, true, true];
			
			buildDeck(TWhite, TBlue, TRed, TBrown, TGreen, TOrange, TBrown, TNormalize);
		}
		
	}

}