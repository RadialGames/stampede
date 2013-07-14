package monsters 
{
	import actions.cards.*;
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class HardesterMonster extends Monster
	{
		
		public function HardesterMonster() 
		{
			name = "Omniolyte";
			description = Game.creatureName + " evolved into an Omniolyte!";
			
			solution = new <Number>[85,65,65,65,85,85];
			activeStats = new <Boolean>[true, true, true, true, true, true];
			
			buildDeck(TWhite, TBlue, TRed, TBrown, TGreen, TOrange, TStandardizeLow, TStandardizeHigh);
		}
		
	}

}