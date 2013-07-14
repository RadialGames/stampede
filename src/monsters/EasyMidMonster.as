package monsters 
{
	import actions.cards.*;
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class EasyMidMonster extends Monster
	{
		
		public function EasyMidMonster() 
		{
			name = "Terratrope";
			description = Game.creatureName + " burst into a Terratrope!";
			
			solution = new <Number>[50,50,50,50,50,50];
			activeStats = new <Boolean>[true, true, false, false, false, false];
			
			buildDeck(TWhite, TWhite, TBlue, TBlue);
		}
		
	}

}