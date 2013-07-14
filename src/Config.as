package
{
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	/**
	 * Static constants
	 */
	public class Config
	{
		public static const NUM_SLOTS:int = 6;
		public static const NUM_PLOTPOINTS:int = 0;
		public static const DECK_SIZE:int = 40; //
		
		public static const SNIPE_FONT_SIZE:int = 30;
		public static const SNIPE_COLOUR:uint = BLUE;
		
		public static const ALLOW_CARD_OVERWRITE:Boolean = false;
		public static const ALLOW_MOVING_CARDS:Boolean = true;
		public static var MUTE:Boolean = false;
		
		public static const STAT_BROWN:String = "earth";
		public static const STAT_WHITE:String = "sky";
		public static const STAT_BLUE:String = "water";
		public static const STAT_RED:String = "fire";
		public static const ALL_STATS:Vector.<String> = new <String>[STAT_WHITE, STAT_BLUE, STAT_RED];//new <String>[STAT_WHITE, STAT_BLUE, STAT_RED, STAT_BROWN];
		public static const STAT_COLOURS:Vector.<uint> = new <uint>[
			0xFFFFFF, 0x0000FF, 0xFF0000, 0x41270D];
		
		public static const PLOT_LOW_THRESH:Number = 20;
		public static const PLOT_MID_THRESH:Number = 50;
		public static const PLOT_HIGH_THRESH:Number = 80;
		
		public static const PLOT_LOW_CHANGE:Number = 10;
		public static const PLOT_MID_CHANGE:Number = 20;
		public static const PLOT_HIGH_CHANGE:Number = 40;
		
		public static const EVOLVE_REQ_HIGH:Number = 70;
		public static const EVOLVE_REQ_VERY_HIGH:Number = 100;
		public static const EVOLVE_REQ_VERY_LOW:Number = 10;
		
		public static const CARD_LOW_CHANGE:Number = 5;
		public static const CARD_MID_CHANGE:Number = 10;
		public static const CARD_HIGH_CHANGE:Number = 15;
			
		public static const STAT_DEFAULT:int = 50;
		public static const STAT_MAX:int = 100;
			
		public static const NONRANDOM_SEED:int = -1;
		public static const DEBUG_MODE:Boolean = true;
		
		public static const RED:uint = 0xFF0000;
		public static const GREEN:uint = 0x00CC00;
		public static const BLUE:uint = 0x0000FF;
		public static const ORANGE:uint = 0xFFA500;
		public static const WHITE:uint = 0xFFFFFF;
	}
}