package  actions {
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
			
			cards.push(CPokeWithStick);
			
			return cards;
		}
	}

}