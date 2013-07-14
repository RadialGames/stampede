package monsters 
{
	import actions.cards.*;
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class PreHardMonster extends Monster
	{
		
		public function PreHardMonster() 
		{
			name = "Firebat";
			description = Game.creatureName + " evolved into a Firebat!";
			
			solution = new <Number>[30,30,50,50,30,30];
			activeStats = new <Boolean>[true, true, false, false, true, true];
			
			buildDeck(TWhite, TBlue, TGreen, TOrange);
		}
		
	}

}