package gui
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * Handles music for the game, fading between all the songs in the playlist.
	 * Music may either be streamed from an external server or embedded into the swf.
	 *
	 * @author Sarah Northway
	 */
	public class MusicPlayer
	{
		public static function playMusic(song:Class):void
		{
			if (Config.MUTE) {
				return;
			}
			
			var songName:String = Utils.classNameFromClass(song).substring("snd".length);
			var newMusic:Music = new Music(songName, false, true);
			
			if (currentMusic != null) {
				startFadingIn(newMusic);
			} else {
				currentMusic = newMusic;
				currentMusic.play();
			}
		}
		
		/**
		 * Stop the music from playing, immediately.
		 */
		public static function stopMusic () :void
		{
			if (currentMusic != null) {
				currentMusic.stop();
				currentMusic = null;
			}
			if (fadingInMusic != null) {
				fadingInMusic.stop();
				fadingInMusic = null;
			}
		}
		
		/**
		 * Fade the given music over the current music.
		 */
		protected static function startFadingIn (music :Music) :void
		{
			if (music == null) {
				Utils.logError("Music can't fade in null music.");
				return;
			}
			if (currentMusic != null && currentMusic.soundName == music.soundName) {
				// can happen when resetting player settings
				Utils.log("Music already playing, can't fade in over itself", music);
				return;
			}
			if (currentMusic != null) {
				currentMusic.loop = false;
			}
			if (fadingInMusic != null) {
				fadingInMusic.stop();
			}
			fadingInVolumeChange = 0;
			fadingInMusic = music;
			fadingInMusic.play();
			fadingInMusic.volume = 0;
		}
		
		/**
		 * Immediately stop current music and play music being faded in at full volume.
		 */
		protected static function endFadingIn () :void
		{
			if (fadingInMusic) {
				fadingInMusic.volume = _musicVolume;
				if (currentMusic != null) {
					currentMusic.stop();
				}
				currentMusic = fadingInMusic;
				fadingInMusic = null;
			}
		}
		
		/**
		 * Used to set the max music volume while in shops. May be wrong while fading in
		 */
		public static function set musicVolume (value:Number):void
		{
			Utils.log("Music setting music volume to : " + value);
			
			if (value == _musicVolume) {
				return;
			}
			var oldVolume:Number = _musicVolume;
			_musicVolume = value;
			for each (var music:Music in [currentMusic, fadingInMusic]) {
				if (music != null) {
					if (music.volume == oldVolume) {
						music.volume = _musicVolume;
					} else {
						music.volume = music.volume * (_musicVolume / oldVolume);
					}
				}
			}
		}
		
		public static function get musicVolume () :Number
		{
			return _musicVolume;
		}
		
		/**
		 * Call occasionally while doing long operations such as loading a game, to keep the
		 * music fading in or out etc.
		 *
		 * Fires every single frame; check on music progress and maybe fade in the new one.
		 * 10 times per second * 10 steps = 1 second for fight music
		 * 2 times per second * 10 steps = 5 seconds for normal music
		 */
		public static function threadTick () :void
		{
			if (Config.MUTE) {
				return;
			}
			
			if (currentMusic == null || currentMusic.loop) {
				return;
			}
			
			// higher fades out/in faster
			var timesPerSecond :int = 10;
			
			// only fire twice a second
			var currentEnterFrameTime :Date = new Date();
			if (currentEnterFrameTime.time - lastFadingInTime.time < (1000/timesPerSecond)) {
				return;
			}
			lastFadingInTime = currentEnterFrameTime;
			
			// increase the volume of one track and decrease the other
			if (fadingInMusic) {
				fadingInVolumeChange += (0.1 * _musicVolume);
				if (fadingInVolumeChange >= _musicVolume) {
					endFadingIn();
				} else {
					currentMusic.volume = _musicVolume - fadingInVolumeChange;
					fadingInMusic.volume = fadingInVolumeChange;
				}
				
			// check the track progress and fade in the next song before the current one ends
			} else {
				// if music hasn't finished loading, we don't have the correct length
				if (currentMusic.doneLoading) {
					if (currentMusic.isSecondsFromEnd(5)) {
						//playNextSong();
					}
				}
			}
		}
		
		protected static var _musicVolume:Number = 1;
		
		protected static var currentMusic :Music;
		protected static var fadingInMusic :Music;
		
		/** Never start/advance/stop fading while anything else is happening */
		protected static var fadingInVolumeChange :Number;
		protected static var lastFadingInTime :Date = new Date();
		
		public static const CREDITS:Class = SndCredits;
		public static const DRUMS:Class = SndDrums;
		public static const LULLABY:Class = SndLullaby;
		public static const ORCHESTRAAAL:Class = SndOrchestral;
		public static const ROCKIN:Class = SndRockin;
		public static const STAMPEDE:Class = SndStampede;
		public static const MAINMENU:Class = SndMainmenu;
		public static const RACIST:Class = SndRacist;
		
		public static const GAME_SONGS:Array = [DRUMS, ORCHESTRAAAL, ROCKIN, STAMPEDE, RACIST];
	}
}