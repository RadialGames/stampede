package  {
	import actions.cards.CBrush;
	import actions.plots.PPBully;
	import flash.display.InteractiveObject;
	import actions.Action;
	import actions.cards.Card;
	import actions.plots.PlotPoint;
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
			if ( _currentSlot > timeline.length ) {
				Utils.logError("Can't .next, Timeline is done!");
			}
			if ( timeline[_currentSlot] != null ) {
				timeline[_currentSlot].doAction();
			}
			_currentSlot++;
		}
		
		public static function initDeck():void {
			deck = new Vector.<Card>();
			for (var i:Number = 0; i < Config.DECK_SIZE; i++) {
				var cardClass:Class = Card.allCards()[Utils.getRandomInt(0, Card.allCards().length-1)];
				deck.push(new cardClass() as Card);
			}
		}
		
		public static function initTimeline():void {
			timeline = new Vector.<Action>();
			var slotsPerPlotPoint:int = Math.floor(Config.NUM_SLOTS / (Config.NUM_PLOTPOINTS - 1));
			
			for (var i:Number = 0; i < Config.NUM_SLOTS-1; i++) {
				//add nulls where there will be cards and add the events
				if ( i % slotsPerPlotPoint == 0 ) {
					var plotClass:Class = PlotPoint.allPlotPoints()[Utils.getRandomInt(0, PlotPoint.allPlotPoints().length-1)];
					timeline.push(new plotClass() as PlotPoint);
					//timeline.push(new PPBully());
				}else {
					timeline.push(null);
				}
			}
			//It always ends with a PlotPoint
			plotClass = PlotPoint.allPlotPoints()[Utils.getRandomInt(0, PlotPoint.allPlotPoints().length-1)];
			timeline.push(new plotClass() as PlotPoint);
			//timeline.push(new PPBully());
		}
		
		public static function putCardOnSlot(card:Action, slotNum:Number):Boolean { // Returns True if operation successful
			if (Config.ALLOW_SWAPPING_CARDS && Config.ALLOW_CARD_OVERWRITE) {
				throw new Error("Fuck you, don't make this harder for all of us");
			}
			
			if (slotNum > timeline.length) {
				Utils.log("slotNum too high");
				return false; // Slotnum shouldn't exist
			}
			
			if (timeline[slotNum] != null && (!Config.ALLOW_CARD_OVERWRITE && !Config.ALLOW_SWAPPING_CARDS)) {
				Utils.log("overwrite or swap false");
				return false;
			}
						
			//timeline[slotNum] = deck.pop(); // this is handled elsewhere now cuz, sarah, that's what happened
			return true;
		}
		
	}

}