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
		
		public static const SNIPE_FONT_SIZE:int = 25;
		
		public static const ALLOW_CARD_OVERWRITE:Boolean = false;
		
		public static const STAT_EARTH:String = "earth";
		public static const STAT_SKY:String = "sky";
		public static const WATER:String = "water";
		public static const STAT_FIRE:String = "fire";
		public static const ALL_STATS:Vector.<String> = new <String>[STAT_EARTH,
			STAT_SKY, WATER, STAT_FIRE];
		public static const STAT_COLOURS:Vector.<uint> = new <uint>[0x41270D,
			0x0000FF, 0xFFFFFF, 0xFF0000];
			
		public static const STAT_DEFAULT:int = 50;
		public static const STAT_MAX:int = 100;
			
		public static const NONRANDOM_SEED:int = 12345;
		public static const DEBUG_MODE:Boolean = true;
		
		public static const RED:uint = 0xFF0000;
		public static const GREEN:uint = 0x00FF00;
		public static const BLUE:uint = 0x0000FF;
		public static const ORANGE:uint = 0xFFA500;
	}
}