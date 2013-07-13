package  {
	import flash.display.InteractiveObject;
	import actions.Action;
	import actions.Card;
	import actions.PlotPoint;
	/**
	 * ...
	 * @author Andy Moore
	 * sameline braces 4 lyfe
	 */
	public class Game {
		
		public static var stats:Stats;
		public static var timeline:Vector.<Action>;
		public static var deck:Vector.<Card>;
		public static var creatureName:String = "Rabaroo";
		protected static var _currentSlot:int;
		
		public static function init():void {
			stats = new Stats();
			initTimeline();
			initDeck();
			reset();
		}
		public static function get currentSlot():int { return _currentSlot; }
		
		public static function reset():void {
			stats.reset()
			_currentSlot = 0;
		}
		
		public static function next():void 
		{
			_currentSlot++;
			if ( _currentSlot > timeline.length ) {
				Utils.logError("Can't .next, Timeline is done!");
			}
			if ( timeline[_currentSlot] != null ) {
				timeline[_currentSlot].doAction();
			}
		}
		
		public static function initDeck():void {
			deck = new Vector.<Card>();
			for (var i:Number = 0; i < Config.DECK_SIZE; i++) {
				var cardClass:Class = Card.AllCards()[Utils.getRandomInt(0, Card.AllCards.length-1)];
				deck.push(new cardClass() as Card);
			}
		}
		
		public static function initTimeline():void {
			timeline = new Vector.<Action>();
			var slotsPerPlotPoint:int = Math.floor(Config.NUM_SLOTS / (Config.NUM_PLOTPOINTS - 1));
			
			for (var i:Number = 0; i < Config.NUM_SLOTS-1; i++) {
				//add nulls where there will be cards and add the events
				if ( i % slotsPerPlotPoint == 0 ) {
					timeline.push(new PlotPoint());
				}else {
					timeline.push(null);
				}
			}
			//It always ends with a PlotPoint
			timeline.push(new PlotPoint());
		}
		
		public static function putTopCardOnSlot(slotNum:Number):Boolean { // Returns True if operation successful
			if (slotNum > timeline.length) {
				return false; // Slotnum shouldn't exist
			}
			if (timeline[slotNum] != null && Config.ALLOW_CARD_OVERWRITE == false) {
				return false;
			}
			timeline[slotNum] = deck.pop();
			return true;
		}
		
	}

}