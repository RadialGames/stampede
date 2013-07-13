package  {
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Andy Moore
	 */
	public class Stats {
		
		protected var _stats:Dictionary;
		
		public function Stats() {
			_stats = new Dictionary();
		}
		
		public function reset():void {
			_stats = new Dictionary();
		}
		
		public function getStat(statName:String, defaultVal:Number = 50):Number
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