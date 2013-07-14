package monsters 
{
	import actions.cards.*;
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class HarderMonster2 extends Monster
	{
		
		public function HarderMonster2() 
		{
			name = "Mlorb";
			description = Game.creatureName + " evolved into a Aqualope!";
			
			solution = new <Number>[10,10,50,50,90,90];
			activeStats = new <Boolean>[true, true, false, false, true, true];
			
			buildDeck(TWhite, TBlue, TWhite, TBlue, TGreen, TOrange, TGreen, TOrange);
		}
		
	}

}