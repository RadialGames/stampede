package  actions {
	/**
	 * ...
	 * @author Andy Moore
	 */
	public class PlotPoint extends Action {
		
		public function PlotPoint() {
			
		}
		
		public static function AllPlotPoints():Vector.<Class>
		{
			var plotPoints:Vector.<Class> = new Vector.<Class>();
			
			plotPoints.push(PPBully);
			
			return plotPoints;
		}
		
	}

}