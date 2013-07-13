package  actions.plots {
	/**
	 * ...
	 * @author Andy Moore
	 */
	public class PlotPoint extends Action {
		
		public var outComeBool:Boolean;
		
		public function PlotPoint() {
			
		}
		
		public static function AllPlotPoints():Vector.<Class>
		{
			var plotPoints:Vector.<Class> = new Vector.<Class>();
			
			plotPoints.push(PPBully);
			plotPoints.push(PPChess);
			plotPoints.push(PPExplore);
			plotPoints.push(PPFarm);
			plotPoints.push(PPFriend);
			plotPoints.push(PPLake);
			plotPoints.push(PPLost);
			plotPoints.push(PPMushrooms);
			plotPoints.push(PPPlague);
			plotPoints.push(PPPlay);
			plotPoints.push(PPSkating);
			plotPoints.push(PPWildMonster);
			
			return plotPoints;
		}
		
		override public function doAction():void 
		{
			outcomeDescription = "no PlotPoint description";
			outComeBool = true;
		}
	}

}