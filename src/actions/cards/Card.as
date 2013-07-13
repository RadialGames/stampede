package  actions.cards {
	import actions.Action;
	/**
	 * ...
	 * @author Andy Moore
	 */
	public class Card extends Action {
		
		public function Card() {
			
		}
		
		public static function allCards():Vector.<Class>
		{
			var cards:Vector.<Class> = new Vector.<Class>();
			
			cards.push(CBook);
			cards.push(CBrush);
			cards.push(CSpeedBag);
			cards.push(CVeggies);
			
			return cards;
		}
	}

}