package gui 
{
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
				lines[i].graphics.lineStyle(4, Config.STAT_COLOURS[i]);
				lines[i].graphics.moveTo(0, graphHeight - (stats[i] / Config.STAT_MAX) * graphHeight);
				addChild(lines[i]);
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
		
		public function reset():void 
		{
			for (var i:int = 0; i < lines.length; i++) {
				removeChild(lines[i]);
			}
			initLines();
		}
		
		public function update(stats:Vector.<Number>, currentSlot:int):void
		{
			for (var i:int = 0; i < stats.length; i++) {
				var yVal:Number = (stats[i] / Config.STAT_MAX) * graphHeight;
				yVal = graphHeight - yVal;
				//yVal = Math.random() * graphHeight;
				
				lines[i].graphics.lineTo((currentSlot+1) * graphSpacing, yVal );
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