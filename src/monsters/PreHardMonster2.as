package monsters 
{
	import actions.cards.*;
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class PreHardMonster2 extends Monster
	{
		
		public function PreHardMonster2() 
		{
			name = "Terrortrope";
			description = Game.creatureName + " evolved into a Firebat!";
			
			solution = new <Number>[90,90,70,70,90,90];
			activeStats = new <Boolean>[true, true, false, false, true, true];
			
			buildDeck(TWhite, TBlue, TGreen, TGreen, TOrange, TStandardizeHigh);
		}
		
	}

}