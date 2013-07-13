package  {
	import flash.display.InteractiveObject;
	/**
	 * ...
	 * @author Andy Moore
	 * yeah that's right andy moore
	 * sameline braces 4 lyfe
	 */
	public class Game {
		
		public static var stats:Stats;
		public static var timeline:Vector.<Action>;
		public static var deck:Vector.<Card>;
		
		public static function init() {
			reset();
		}
		
		public static function reset():void {
			stats = new Stats();
			setupTimeline();
			setupDeck();
		}
		
		public static function setupDeck():void {
			var tempDeck:Array = new Array();
			for (var i:Number = 0; i < Config.DECK_SIZE; i++) {
				// I guess we should figure a way to make new Cards randomly
				tempDeck.push(new Card());
			}
			
			// The shittiest shuffling job ever:
			deck = new Vector.<Card>();
			//while (tempDeck.length > 0) {
				//deck.push(tempDeck.splice(Utils.getRandomInt(0, tempDeck.length), 1));
			//}
		}
		
		public static function setupTimeline():void {
			timeline = new Vector.<Action>();
			for (var i:Number = 0; i < Config.NUM_SLOTS; i++) {
				// This should probably be evenly distributed automatically
				// based on a Config for number of plotpoints
				if (Utils.getRandChance(1, 3)) { 
					// Null timeline means no card has been played there.
					timeline.push(null);
				} else {
					// Plotpoints are "static" in the timeline, so prepopulate them
					timeline.push(new PlotPoint());
				}
			}
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