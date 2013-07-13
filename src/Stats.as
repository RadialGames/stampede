package  {
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Andy Moore
	 */
	public class Stats extends Dictionary {
		
		protected var _stats:Dictionary;
		
		public function Stats() {
			super();
			reset();
		}
		
		public function reset():void {
			_stats = new Dictionary();
			for (var i:int = 0; i < Config.ALL_STATS.length; i++) {
				setStat(Config.ALL_STATS[i], (i * 10)+35);
			}
		}
		
		public function getStat(statName:String, defaultVal:Number = Config.STAT_DEFAULT):Number
		{
			if ( !_stats.hasOwnProperty(statName) ) {
				_stats[statName] = defaultVal;
			}
			return _stats[statName];
		}
		
		public function setStat(statName:String, val:Number):void 
		{
			_stats[statName] = val;
		}
		
	}

}