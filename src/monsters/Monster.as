package monsters 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class Monster 
	{
		public var name:String;
		public var description:String;
		public var graphic:Sprite;
		
		protected var allMonsters:Vector.<Monster>;
		
		public function Monster() 
		{
			allMonsters = new Vector.<Monster>();
			
			allMonsters.push(new Sloth());
		}
		
		public static function whichMoster():Monster
		{
			for each (var monster:Monster in allMonsters) {
				if ( monster.willEvolveInto() ) {
					return monster;
				}
			}
		}
		
		public function willEvolveInto():Boolean
		{
			return false;
		}
		
		
	}

}