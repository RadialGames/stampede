package monsters 
{
	import actions.cards.Card;
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
		
		public var solution:Vector.<Number> = new Vector.<Number>();
		public var activeStats:Vector.<Boolean> = new Vector.<Boolean>();
		public var deck:Vector.<Class> = new Vector.<Class>();
		
		protected static var _allMonsters:Vector.<Monster>;
		
		public function Monster() 
		{
			
		}
		
		public static function get allMonsters():Vector.<Monster>
		{
			if ( _allMonsters == null ) {
				initMonsters();
			}
			return _allMonsters;
		}
		
		protected static function initMonsters():void
		{
			_allMonsters = new Vector.<Monster>();
			_allMonsters.push(new EasyMidMonster());
			/*_allMonsters.push(new OmniMonster());
			_allMonsters.push(new NegaMonster());
			_allMonsters.push(new EarthMonster());
			_allMonsters.push(new SkyMonster());
			_allMonsters.push(new WaterMonster());
			_allMonsters.push(new FireMonster());
			_allMonsters.push(new Sloth());*/
		}
		
		public static function whichMoster():Monster
		{
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
		
		public function buildDeck(...classes):void 
		{
			deck = new Vector.<Class>();
			for (var i:int = 0; i < classes.length; i++) {
				deck.push(classes[i] as Class);
			}
		}
		
	}

}