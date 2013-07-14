package  {
	import actions.cards.CBrush;
	import actions.cards.TBlue;
	import actions.cards.TRed;
	import actions.cards.TWhite;
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
				//var cardClass:Class = Card.allCards()[Utils.getRandomInt(0, Card.allCards().length-1)];
				//deck.push(new cardClass() as Card);
				deck.push(new TRed());
				deck.push(new TRed());
				deck.push(new TBlue());
				deck.push(new TBlue());
				deck.push(new TWhite());
			}
		}
		
		public static function initTimeline():void {
			timeline = new Vector.<Action>();
			var slotsPerPlotPoint:int = Math.floor(Config.NUM_SLOTS / (Config.NUM_PLOTPOINTS - 1));
			
			for (var i:Number = 0; i < Config.NUM_SLOTS; i++) {
				//add nulls where there will be cards and add the events
				if ( i % slotsPerPlotPoint == 0 && i != 0 ) {
					var plotClass:Class = PlotPoint.allPlotPoints()[Utils.getRandomInt(0, PlotPoint.allPlotPoints().length-1)];
					timeline.push(new plotClass() as PlotPoint);
					//timeline.push(new PPBully());
				}else {
					timeline.push(null);
				}
			}
			//It always ends with a PlotPoint
			//plotClass = PlotPoint.allPlotPoints()[Utils.getRandomInt(0, PlotPoint.allPlotPoints().length-1)];
			//timeline.push(new plotClass() as PlotPoint);
		}
		
		public static function putTopCardOnSlot(slotNum:Number):Boolean { // Returns True if operation successful
			if (slotNum > timeline.length) {
				return false; // Slotnum shouldn't exist
			}
			if (timeline[slotNum] != null && Config.ALLOW_CARD_OVERWRITE == false) {
				return false;
			}
			//timeline[slotNum] = deck.pop(); // this is handled elsewhere now cuz, sarah, that's what happened
			return true;
		}
		
	}

}