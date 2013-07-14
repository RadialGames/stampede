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
		
		protected static var allMonsters:Vector.<Monster>;
		
		public function Monster() 
		{
			
		}
		
		protected static function initMonsters():void
		{
			allMonsters = new Vector.<Monster>();
			allMonsters.push(new Sloth());
		}
		
		public static function whichMoster():Monster
		{
			if ( allMonsters == null ) {
				initMonsters();
			}
			
			for each (var monster:Monster in allMonsters) {
				if ( monster.willEvolveInto() ) {
					return monster;
				}
			}
			
			return new Sloth();
		}
		
		public function willEvolveInto():Boolean
		{
			return false;
		}
		
		
	}

}