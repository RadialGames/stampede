package gui
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.utils.getDefinitionByName;
		
	/**
	 * Simple object containing Sound, SoundChannel, etc for a single song.  Starts loading the
	 * sound file as soon as it is instanciated.  Cashes songs so they are not reloaded.
	 */
	public class Music
	{
		public function Music (soundName :String, isSfx:Boolean = false, loop :Boolean = false)
		{
			this.soundName = soundName;
			this.stopPosition = 0;
			this.isSfx = isSfx;
			this.loop = loop
			
			// music has already been played once so reuse it
			if (isSfx && playedSounds[soundName] != null) {
				sound = playedSounds[soundName];
				return;
			}
			
			// music is compiled into the file
			try {
				var musicClass :Class = getDefinitionByName("Snd" + soundName) as Class;
			} catch (e :Error) {
				Utils.logError(e);
				sound = new Sound();
				return;
			}
			//Utils.log("creating new music class " + musicClass);
			if (musicClass == null) {
				Utils.logError("Could not get class for music filename " + soundName);
				sound = new Sound();
				return;
			}
			sound = new musicClass();
				
			// store the loaded music for later
			if (isSfx) {
				playedSounds[soundName] = sound;
			}
		}
		
		public function play () :void
		{
			if (soundChannel != null) {
				soundChannel.stop();
			}
			
			if (Config.MUTE) {
				return;
			}
			
			if (!isSfx) {
				Utils.log("music now playing/resuming: " + soundName);
			}
			
			//if (!isSfx && MusicPlayer.disabled) {
				//Utils.log("not playing music because it's disabled.");
				//return;
			//}
			
			try {
				soundChannel = sound.play(stopPosition, (loop ? 999 : 0));
				if (!isSfx) {
					volume = MusicPlayer.musicVolume;
				}
			} catch (error :Error) {
				Utils.logError("Couldn't play music.", error);
				return;
			}
		}
		
		public function stop () :void
		{
			if (soundChannel == null) {
				return;
			}
			// can't record stop position because loop will loop continuously from there
			if (!loop) {
				stopPosition = soundChannel.position;
			}
			soundChannel.stop();
			soundChannel = null;
		}
		
		public function reset () :void
		{
			stopPosition = 0;
		}
		
		public function get playing () :Boolean
		{
			// if it hasn't been started or has been stopped, it's not playing
			if (soundChannel == null) {
				return false;
			}
			// if it's still loading, it's still playing
			if (!doneLoading) {
				return true;
			}
			// if has reached the end it's not playing
			if (isSecondsFromEnd(0)) {
				//Utils.log("not playing, is 0 seconds from end.");
				return false;
			}
			return true;
		}
		
		public function set volume (value :Number) :void
		{
			_volume = value;
			if (soundChannel == null) {
				return;
			}
			soundChannel.soundTransform = new SoundTransform(value);
		}
		
		public function get volume () :Number
		{
			return _volume;
		}
		
		public function get doneLoading () :Boolean
		{
			if (sound == null) {
				return false;
			}
			return sound.bytesLoaded > 0 && sound.bytesLoaded >= sound.bytesTotal;
		}
		
		public function isSecondsFromEnd (seconds :Number) :Boolean
		{
			if (soundChannel == null) {
				Utils.logError("music sound channel is null", this);
				return true;
			}
			if (soundChannel.position >= (sound.length - (seconds * 1000))){
				//Utils.log("music fading out at at " + soundChannel.position + " of "
					//+ sound.length + " (" + sound.bytesLoaded
					//+ " of " + sound.bytesTotal + " loaded)", this);
				return true;
			}
			return false;
		}
		
		public function toString () :String
		{
			return soundName;
		}
		
		public var soundName :String;
		
		protected var _volume :Number;
		protected var sound :Sound;
		protected var soundChannel :SoundChannel;
		protected var stopPosition :Number;
		protected var isSfx :Boolean;
		//public var looping :Boolean;
		public var loop :Boolean;
		
		// all the music that has been loaded indexed by filename so we don't load the same one twice
		protected static var playedSounds :Object = new Object();
	}
}