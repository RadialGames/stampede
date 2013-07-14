package gui
{
	import flash.events.Event;
	import flash.utils.Dictionary;
	import worddog.*;
	import worddog.game.*;
	
	/**
	 * Handles sound effects in the game.  The same sound cannot be played over itself or
	 * queued up, but different sounds will play simultaneously on different channels.
	 *
	 * @author Sarah Northway
	 */
	public class SoundPlayer
	{
		public static function playBark () :void
		{
			if (sounds == null) {
				return;
			}
			
			// don't play bark if already playing
			if ((sounds[SOUND_BARK_ONCE] != null && sounds[SOUND_BARK_ONCE].playing)
				|| (sounds[SOUND_BARK_TWICE] != null && sounds[SOUND_BARK_TWICE].playing)) {
				return;
			}
			
			if (Utils.getRandChance(1, 2)) {
				playSound(SOUND_BARK_ONCE);
			} else {
				playSound(SOUND_BARK_TWICE);
			}
		}
		
		public static function playClick () :void
		{
			playSound(SOUND_CLICK);
		}
		
		public static function playDynamite () :void
		{
			stopSound(SOUND_DYNAMITE);
			playSound(SOUND_DYNAMITE);
		}
		
		public static function playScratch () :void
		{
			playSound(SOUND_SCRATCH);
		}
		
		public static function playRinging (short :Boolean) :void
		{
			if (short) {
				playSound(SOUND_RINGING_SHORT);
			} else {
				playSound(SOUND_RINGING);
			}
		}
		
		public static function playVoice (num:int = 0) :void
		{
			if (num == 0) {
				currentVoice = playSound(Utils.pickRandom(VOICE_FILES));
			} else {
				currentVoice = playSound("Voice" + num);
			}
			if (currentVoice != null) {
				currentVoice.volume = VOICE_VOLUME;
			}
		}
		
		public static function stopVoice () :void
		{
			if (currentVoice != null) {
				currentVoice.stop();
				currentVoice = null;
			}
		}
		
		public static function playDigging (short :Boolean) :void
		{
			stopDigging();
			if (short) {
				playSound(SOUND_DIGGING_SHORT);
			} else {
				playSound(SOUND_DIGGING);
			}
		}
		
		public static function stopDigging () :void
		{
			if (!Player.sound) {
				return;
			}
			stopSound(SOUND_DIGGING);
			stopSound(SOUND_DIGGING_SHORT);
		}
		
		protected static function stopSound (soundName :String) :void
		{
			if (!Player.sound || sounds == null) {
				return;
			}
			var sound :Music = sounds[soundName];
			if (sound != null) {
				sound.stop();
			}
		}
		
		/**
		 * Preload all the sound effects.
		 */
		protected static function init () :void
		{
			sounds  = new Dictionary();
			for each (var soundFile :String in SOUND_FILES) {
				// will start loading immediately but won't play
				var sound :Music = new Music(soundFile, true);
				sounds[soundFile] = sound;
			}
		}
		
		/**
		 * Play the given sound.
		 */
		protected static function playSound (soundName :String) :Music
		{
			if (!Player.sound) {
				return null;
			}
			
			// only needs to be done once to initialize once instance of each sound
			if (sounds == null) {
				init();
			}
			
			var sound :Music = sounds[soundName];
			if (sound == null) {
				Utils.logError("Couldn't find preloaded sound: " + soundName);
				return null;
			}
			if (sound.playing) {
				//Utils.log("sound currently playing, not restarting.");
				return sound;
			}
			sound.reset();
			sound.play();
			sound.volume = VOLUME;
			return sound;
		}
		
		/** Scratch-voice being played (or last played if finished) */
		protected static var currentVoice:Music;
		
		/** How loud are the sounds by default */
		public static const VOLUME :Number = 0.4;
		public static const VOICE_VOLUME :Number = 0.4;
		
		protected static const SOUND_BARK_ONCE :String = "BarkOnce";
		protected static const SOUND_BARK_TWICE :String = "BarkTwice";
		protected static const SOUND_CLICK :String = "Click";
		protected static const SOUND_DIGGING :String = "Digging";
		protected static const SOUND_DIGGING_SHORT :String = "DiggingShort";
		protected static const SOUND_DYNAMITE :String = "Dynamite";
		protected static const SOUND_SCRATCH :String = "Scratch";
		protected static const SOUND_RINGING :String = "Ringing";
		protected static const SOUND_RINGING_SHORT :String = "RingingShort";
		protected static const SOUND_VOICE_1 :String = "Voice1";
		protected static const SOUND_VOICE_2 :String = "Voice2";
		protected static const SOUND_VOICE_3 :String = "Voice3";
		protected static const SOUND_VOICE_4 :String = "Voice4";

		protected static var SOUND_FILES :Vector.<String> = new <String>[
			SOUND_BARK_ONCE, SOUND_BARK_TWICE,
			SOUND_CLICK, SOUND_DIGGING, SOUND_DIGGING_SHORT, SOUND_DYNAMITE,
			SOUND_SCRATCH, SOUND_RINGING, SOUND_RINGING_SHORT,
			SOUND_VOICE_1, SOUND_VOICE_2, SOUND_VOICE_3, SOUND_VOICE_4];
			
		protected static var VOICE_FILES:Vector.<String> = new <String>[
			SOUND_VOICE_1, SOUND_VOICE_2, SOUND_VOICE_3, SOUND_VOICE_4];
			
		// Music classes indexed by SOUND_ name string
		protected static var sounds :Dictionary;
	
		// reference all the music classes so they'll be compiled into the swf
		private static var classes :Array = [SndBarkOnce, SndBarkTwice, SndClick, SndDigging,
			SndDiggingShort, SndDynamite, SndScratch, SndRinging, SndRingingShort,
			SndVoice1, SndVoice2, SndVoice3, SndVoice4];
	}
}