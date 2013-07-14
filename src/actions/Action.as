package actions {
	/**
	 * ...
	 * @author Andy Moore
	 */
	public class Action {
		
		public var title:String = "";
		public var colour:uint = 0x000000;
		public var outcomeDescription:String = "";
		
		public function Action() {
			
		}
		
		public function doAction():void 
		{
			outcomeDescription = "no description";
		}
		
	}

}