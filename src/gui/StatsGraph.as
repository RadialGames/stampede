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
		
		public function StatsGraph(width:int, height:int, stats:Vector.<Number>)
		{
			graphWidth = width;
			graphHeight = height;
			
			graphSpacing = graphWidth / Config.NUM_SLOTS;
			
			lines = new Vector.<Sprite>();
			for (var i:int = 0; i < Config.ALL_STATS.length; i++) {
				lines.push(new Sprite());
				lines[i].graphics.lineStyle(Config.STAT_COLOURS[i]);
				lines[i].graphics.moveTo(0, (stats[i]/Config.STAT_MAX) * graphHeight);
			}
			
			drawBase();
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
		
		public function update(stats:Vector.<Number>, currentSlot:int):void
		{
			for (var i:int = 0; i < stats.length; i++) {
				lines[i].graphics.lineTo(currentSlot * graphSpacing, (stats[i]/Config.STAT_MAX) * graphHeight );
			}
		}
	}

}