package
{
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	/**
	 * Static constants
	 */
	public class Config
	{
		public static const NUM_SLOTS:int = 8;
		public static const NUM_PLOTPOINTS:int = 3;
		public static const DECK_SIZE:int = 40; //
		
		public static const ALLOW_CARD_OVERWRITE:Boolean = false;
		
		public static const STAT_HAPPINESS:String = "happiness";
		public static const STAT_TOUGHNESS:String = "toughness"; // vs tenderness?
		public static const STAT_CURIOSITY:String = "curiosity"; // vs concetration?
		public static const STAT_GREED:String = "greed"; // vs generosity?
		public static const ALL_STATS:Vector.<String> = new <String>[STAT_HAPPINESS,
			STAT_TOUGHNESS, STAT_CURIOSITY, STAT_GREED];
		
		public static const NONRANDOM_SEED:int = 12345;
		public static const DEBUG_MODE:Boolean = true;
	}
}