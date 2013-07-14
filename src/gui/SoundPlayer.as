package gui
{
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	/**
	 * Handles sound effects in the game.  The same sound cannot be played over itself or
	 * queued up, but different sounds will play simultaneously on different channels.
	 *
	 * @author Sarah Northway
	 */
	public class SoundPlayer
	{
		public static function playMonsterSound (up:Boolean) :void
		{
			if (Config.MUTE) {
				return;
			}
			
			var soundClass:Class = Utils.pickRandom((up) ? ALL_UP : ALL_DOWN);
			var soundName:String = Utils.classNameFromClass(soundClass).substring("snd".length);
			
			var sound :Music = sounds[soundName];
			if (sound == null) {
				sound = new Music(soundName, true);
				sounds[soundName] = sound;
			}
			if (sound.playing) {
				return;
			}
			sound.reset();
			sound.play();
			sound.volume = VOLUME;
			return;
		}
		
		/** How loud are the sounds by default */
		public static const VOLUME :Number = 1.0;
		
		protected static const SOUND_UP_1:Class = SndUp1;
		protected static const SOUND_UP_2:Class = SndUp2;
		protected static const SOUND_UP_3:Class = SndUp3;
		protected static const SOUND_UP_4:Class = SndUp4;
		protected static const SOUND_UP_5:Class = SndUp5;
		protected static const SOUND_UP_6:Class = SndUp6;
		protected static const SOUND_UP_7:Class = SndUp7;
		protected static const SOUND_UP_8:Class = SndUp8;
		protected static const SOUND_UP_9:Class = SndUp9;
		protected static const SOUND_UP_10:Class = SndUp10;
		protected static const SOUND_UP_11:Class = SndUp11;
		protected static const SOUND_UP_12:Class = SndUp12;
		protected static const SOUND_UP_13:Class = SndUp13;
		protected static const SOUND_UP_14:Class = SndUp14;
		protected static const SOUND_UP_15:Class = SndUp15;
		protected static const SOUND_UP_16:Class = SndUp16;
		protected static const SOUND_UP_17:Class = SndUp17;
		protected static const SOUND_UP_18:Class = SndUp18;
		protected static const SOUND_UP_19:Class = SndUp19;
		protected static const SOUND_UP_20:Class = SndUp20;
		protected static const SOUND_UP_21:Class = SndUp21;
		protected static const SOUND_UP_22:Class = SndUp22;
		protected static const SOUND_UP_23:Class = SndUp23;
		protected static const SOUND_UP_24:Class = SndUp24;
		protected static const SOUND_UP_25:Class = SndUp25;
		protected static const SOUND_UP_26:Class = SndUp26;
		protected static const SOUND_UP_27:Class = SndUp27;
		protected static const SOUND_UP_28:Class = SndUp28;
		protected static const SOUND_UP_29:Class = SndUp29;
		protected static const SOUND_UP_30:Class = SndUp30;
		protected static const SOUND_UP_31:Class = SndUp31;
		protected static const SOUND_UP_32:Class = SndUp32;
		protected static const SOUND_UP_33:Class = SndUp33;
		protected static const ALL_UP:Array = [SOUND_UP_1, SOUND_UP_2, SOUND_UP_3, SOUND_UP_4, SOUND_UP_5, SOUND_UP_6, SOUND_UP_7, SOUND_UP_8, SOUND_UP_9, SOUND_UP_10, SOUND_UP_11, SOUND_UP_12, SOUND_UP_13, SOUND_UP_14, SOUND_UP_15, SOUND_UP_16, SOUND_UP_17, SOUND_UP_18, SOUND_UP_19, SOUND_UP_20, SOUND_UP_21, SOUND_UP_22, SOUND_UP_23, SOUND_UP_24, SOUND_UP_25, SOUND_UP_26, SOUND_UP_27, SOUND_UP_28, SOUND_UP_29, SOUND_UP_30, SOUND_UP_31, SOUND_UP_32, SOUND_UP_33];
		
		protected static const SOUND_DOWN_1:Class = SndDown1;
		protected static const SOUND_DOWN_2:Class = SndDown2;
		protected static const SOUND_DOWN_3:Class = SndDown3;
		protected static const SOUND_DOWN_4:Class = SndDown4;
		protected static const SOUND_DOWN_5:Class = SndDown5;
		protected static const SOUND_DOWN_6:Class = SndDown6;
		protected static const SOUND_DOWN_7:Class = SndDown7;
		protected static const SOUND_DOWN_8:Class = SndDown8;
		protected static const SOUND_DOWN_9:Class = SndDown9;
		protected static const SOUND_DOWN_10:Class = SndDown10;
		protected static const SOUND_DOWN_11:Class = SndDown11;
		protected static const SOUND_DOWN_12:Class = SndDown12;
		protected static const SOUND_DOWN_13:Class = SndDown13;
		protected static const SOUND_DOWN_14:Class = SndDown14;
		protected static const SOUND_DOWN_15:Class = SndDown15;
		protected static const SOUND_DOWN_16:Class = SndDown16;
		protected static const SOUND_DOWN_17:Class = SndDown17;
		protected static const SOUND_DOWN_18:Class = SndDown18;
		protected static const SOUND_DOWN_19:Class = SndDown19;
		protected static const SOUND_DOWN_20:Class = SndDown20;
		protected static const SOUND_DOWN_21:Class = SndDown21;
		protected static const SOUND_DOWN_22:Class = SndDown22;
		protected static const SOUND_DOWN_23:Class = SndDown23;
		protected static const ALL_DOWN:Array = [SOUND_DOWN_1, SOUND_DOWN_2, SOUND_DOWN_3, SOUND_DOWN_4, SOUND_DOWN_5, SOUND_DOWN_6, SOUND_DOWN_7, SOUND_DOWN_8, SOUND_DOWN_9, SOUND_DOWN_10, SOUND_DOWN_11, SOUND_DOWN_12, SOUND_DOWN_13, SOUND_DOWN_14, SOUND_DOWN_15, SOUND_DOWN_16, SOUND_DOWN_17, SOUND_DOWN_18, SOUND_DOWN_19, SOUND_DOWN_20, SOUND_DOWN_21, SOUND_DOWN_22, SOUND_DOWN_23];
		
		// Music classes indexed by sound name string
		protected static var sounds :Dictionary = new Dictionary();
	}
}