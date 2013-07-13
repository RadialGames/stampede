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
			
			cards.push(CBathe);
			cards.push(CBook);
			cards.push(CBrush);
			cards.push(CFeast);
			cards.push(CMassage);
			cards.push(CMeat);
			cards.push(CMuseum);
			cards.push(CSpar);
			cards.push(CSpeedBag);
			cards.push(CTricks);
			cards.push(CVeggies);			
			cards.push(CWeights);
			
			return cards;
		}
	}

}