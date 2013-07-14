package gui 
{
	import aze.motion.eaze;
	import flash.display.Sprite;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class StatsGraph extends Sprite
	{
		protected var graphWidth:int;
		protected var graphHeight:int;
		
		protected var graphSpacing:Number;
		protected var lines:Vector.<Sprite>;
		
		public function StatsGraph(width:int, height:int)
		{
			graphWidth = width;
			graphHeight = height;
			
			graphSpacing = graphWidth / Config.NUM_SLOTS;
			
			initLines();
			drawBase();
		}
		
		protected function initLines():void 
		{
			var stats:Vector.<Number> = getStatValues();
			lines = new Vector.<Sprite>();
			for (var i:int = 0; i < Config.ALL_STATS.length; i++) {
				lines.push(new Sprite());
				lines[i].graphics.lineStyle(Config.STATS_LINE_THICKNESS, Config.STAT_COLOURS[i]);
				lines[i].graphics.moveTo(0, graphHeight - (stats[i] / Config.STAT_MAX) * graphHeight);
				lines[i].visible = Game.stats.activeStats[i];
				lines[i].y += i * (Config.STATS_LINE_THICKNESS - 1);
				addChild(lines[i]);
				if (lines[i].visible) {
					lines[i].alpha = 0.5;
					eaze(lines[i]).to(0.8, { alpha:1 }, true);				
				}
			}
		}
		
		public function drawBase():void 
		{
			graphics.beginFill(0x666666);
			graphics.drawRect(0, 0, graphWidth, graphHeight);
			
			/*var textField:TextField;
			for each (var statName:String in Config.ALL_STATS) {
				textField = new TextField();
				textField.text = statName
			}*/
		}
		
		private var oldGraph:Sprite;
		public function reset():void 
		{
			//Utils.log("StatGraph Reset");
			if (oldGraph) removeChild(oldGraph);
			oldGraph = new Sprite();
			for (var i:int = 0; i < lines.length; i++) {
				removeChild(lines[i]);
				oldGraph.addChild(lines[i]);
			}
			initLines();
			if (oldGraph) {
				addChild(oldGraph);
				oldGraph.alpha = 0.5;
				eaze(oldGraph).to(0.8, { alphaVisible:0 }, true);
			}
		}
		
		public function update(stats:Vector.<Number>, currentSlot:int):void
		{
			for (var i:int = 0; i < stats.length; i++) {
				var yVal:Number = (stats[i] / Config.STAT_MAX) * graphHeight;
				yVal = graphHeight - yVal;
				//yVal = Math.random() * graphHeight;
				
				lines[i].graphics.lineTo((currentSlot + 0.75) * graphSpacing, yVal);
				lines[i].graphics.lineTo((currentSlot + 1.25) * graphSpacing, yVal);
			}
		}
		
		protected function getStatValues():Vector.<Number>
		{
			var values:Vector.<Number> = new Vector.<Number>();
			for (var j:int = 0; j < Config.ALL_STATS.length; j++) {
				var stat:String = Config.ALL_STATS[j];
				values.push(Game.stats.getStat(stat));
			}
			return values;
		}
	}

}