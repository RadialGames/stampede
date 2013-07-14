package
{
	import flash.events.KeyboardEvent;
	import flash.net.SharedObject;
	import flash.utils.ByteArray;
	import gui.MusicPlayer;
	import monsters.Monster;
	
	/**
	 * Handles saving and loading the game from a cookie (SharedObject).  Flash shared objects
	 * default to 100KB maximum storage.  10KB is the minimum.
	 *
	 * @author Sarah Northway
	 */
	public class SaveManager
	{
		public static function collectMonster(monster:Monster):void
		{
			Utils.addToVector(collectedMonsters, monster);
			save();
		}
		
		public static function hasCollectedMonster(monster:Monster):Boolean
		{
			if (collectedMonsters == null) {
				load();
			}
			return Utils.vectorContains(collectedMonsters, monster);
		}
		
		public static function load():void
		{
			collectedMonsters = new Vector.<Monster>();
			
			var xml:XML = loadCookie();
			if (xml == null) {
				Utils.log("first time loading cookie, keeping defaults");
				return;
			}
			
			Config.MUTE = (xml.mute == 1) ? true : false;
			if (Config.MUTE) {
				MusicPlayer.stopMusic();
			}
			
			for each (var monsterXml :XML in xml.monsters.children()) {
				var monsterName:String = monsterXml.name;
				for each (var monster:Monster in Monster.allMonsters) {
					if (monster.name == monsterName) {
						collectedMonsters.push(monster);
					}
				}
			}
		}
		
		public static function save():void
		{
			var xml :XML = <data />;
			xml.mute = Config.MUTE ? "1" : "0";
			xml.appendChild(<monsters />);
			for each (var monster:Monster in collectedMonsters) {
				var monsterXml:XML = <monster />;
				monsterXml.name = monster.name;
				xml.monsters.appendChild(monsterXml);
			}
			
			saveCookie(xml);
		}
		
		protected static function loadCookie () :XML
		{
			var cookie :SharedObject = getCookie();
			
			if (cookie.size > 0) {
				var byteArray :ByteArray = cookie.data.xml as ByteArray;
				if (byteArray == null) {
					return null;
				}
				
				// deep clone the bytearray to avoid decompressing the cookie data itself
				var cloner :ByteArray = new ByteArray();
				cloner.writeObject(byteArray);
				cloner.position = 0;
				byteArray = cloner.readObject();
				
				try {
					byteArray.uncompress();
					var foundXML :XML = byteArray.readObject() as XML;
					if (foundXML == null) {
						Utils.log("Couldn't get xml from cookie byteArray.", byteArray.toString());
					}
					return foundXML;
				} catch (e :Error) {
					Utils.logError("problem while uncompressing and reading cookie xml.", byteArray);
				}
				return null;
			}
			
			return null;
		}
		
		protected static function saveCookie (xml :XML) :void
		{
			var cookie :SharedObject = getCookie();
			try {
				var byteArray :ByteArray = new ByteArray();
				byteArray.writeObject(xml);
				byteArray.compress();
				cookie.data.xml = byteArray;
				cookie.flush();
			} catch (e :Error) {
				Utils.logError("Couldn't save cookie: " + e);
				return;
			}
		}
		
		public static function deleteCookie():void
		{
			try {
				var cookie:SharedObject = getCookie();
				cookie.clear();
				cookie.flush();
				Utils.log("All cookies have been deleted.");
			} catch (error:Error) {
				Utils.logError("Failed to delete cookies.", error);
			}
		}
		
		protected static function getCookie () :SharedObject
		{
			return SharedObject.getLocal(COOKIE_NAME, "/");
		}
		
		protected static const COOKIE_NAME:String = "Stampede";
		protected static var collectedMonsters:Vector.<Monster>;
	}
}