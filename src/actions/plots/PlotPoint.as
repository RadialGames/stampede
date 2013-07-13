package  actions.plots {
	import actions.Action;
	/**
	 * ...
	 * @author Andy Moore
	 */
	public class PlotPoint extends Action{
		
		public var outComeBool:Boolean;
		
		public function PlotPoint() {
			
		}
		
		public static function allPlotPoints():Vector.<Class>
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
		
		public function simplePlotAction(
			succeedDesc:String, 
			failDesc:String, 
			toCheck:String, 
			checkThresh:Number, 
			toSet:String, 
			setAmount:Number, 
			setDownAmount:Number = Number.NaN):void
		{
			if ( isNaN(setDownAmount) ) {
				setDownAmount = setAmount;
			}
			
			var checkStatVal:Number = Game.stats.getStat(toCheck);
			var setStatVal:Number = Game.stats.getStat(toSet);
			
			if( (checkThresh > 0 && checkStatVal > checkThresh) || (checkThresh < 0 && checkStatVal < (checkThresh*-1)) ){
				Game.stats.setStat(toSet, setStatVal + setAmount);
				outcomeDescription = succeedDesc;
				outComeBool = true;
			}else {
				Game.stats.setStat(toSet, setStatVal - setDownAmount);
				outcomeDescription = failDesc;
				outComeBool = false;
			}
		}
	}

}