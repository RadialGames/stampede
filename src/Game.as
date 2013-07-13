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
			var tempDeck:Array = new Array();
			for (var i:Number = 0; i < Config.DECK_SIZE; i++) {
				// I guess we should figure a way to make new Cards randomly
				tempDeck.push(new Card());
			}
			
			// The shittiest shuffling job ever:
			deck = new Vector.<Card>();
			while (tempDeck.length > 0) {
				deck.push((tempDeck.splice(Utils.getRandomInt(0, tempDeck.length), 1)) as Card);
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
			if (slotNum > timeline.length) return false; // Slotnum shouldn't exist
			if (timeline[slotNum] != null) return false; // Can't overwrite cards? This might change.
			timeline[slotNum] = deck.pop();
			recalculateStats();
			return true;
		}
		
		public static function recalculateStats():void {
			// stats.reset(); // doesn't exist yet
			//for (var action:Action in timeline) {
				// action.do (); // or whatever makes it go
			//}
		}
		
	}

}