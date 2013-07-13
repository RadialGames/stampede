package  {
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Andy Moore
	 */
	public class Stats extends Dictionary {
		
		// This class might not be necessary at all.
		
		public function Stats() {
			super();
		}
		
		public function reset():void {
			for (var k:Object in this) {
				this[k] = 0;
			}
		}	
	}
}