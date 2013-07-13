package  actions.cards {
	/**
	 * ...
	 * @author Andy Moore
	 */
	public class Card extends Action {
		
		public function Card() {
			
		}
		
		public static function AllCards():Vector.<Class>
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