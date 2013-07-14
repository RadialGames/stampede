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
			name = "Firebat";
			description = Game.creatureName + " evolved into a Terratrope!";
			
			solution = new <Number>[30,30,30,30,50,50];
			activeStats = new <Boolean>[true, true, true, true, false, false];
			
			buildDeck(TWhite, TBlue, TRed, TBrown);
		}
		
	}

}