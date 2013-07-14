package monsters 
{
	import actions.cards.*;
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class EasyMidMonster3 extends Monster
	{
		
		public function EasyMidMonster3() 
		{
			name = "Blorb";
			description = Game.creatureName + " evolved into a Blorb!";
			
			solution = new <Number>[70,70,50,50,50,50];
			activeStats = new <Boolean>[true, true, false, false, false, false];
			
			buildDeck(TWhite, TWhite, TBlue, TBlue);
		}
		
	}

}