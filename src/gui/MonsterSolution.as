package gui 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class MonsterSolution extends Sprite
	{
		protected var graphWidth:int;
		protected var graphHeight:int;
		
		protected var lines:Vector.<Sprite>;
		
		public function MonsterSolution(width:int, height:int) 
		{
			graphWidth = width;
			graphHeight = height;
			
			initLines();
			
			var solution:Vector.<Number> = Game.currentMonster.solution
			
			var numActiveStats:int;
			for (var i:int = 0; i < Config.ALL_STATS.length; i++) {
				if ( Game.currentMonster.activeStats[i] ) {
					numActiveStats++
				}
			}
			
			for (i = 0; i < Config.ALL_STATS.length; i++) {
				if ( Game.currentMonster.activeStats[i] ) {
					lines[i].graphics.lineTo(graphWidth, graphHeight - (solution[i] / Config.STAT_MAX) * graphHeight);
				}
			}
			
			Game.currentMonster.solution
			
			graphics.beginFill(0xBBBBBB);
			graphics.drawRect(0, 0, graphWidth, graphHeight);
		}
		
		protected function initLines():void 
		{
			lines = new Vector.<Sprite>();
			for (var i:int = 0; i < Config.ALL_STATS.length; i++) {
				lines.push(new Sprite());
				lines[i].y += i*2;
				lines[i].graphics.lineStyle(3, Config.STAT_COLOURS[i]);
				lines[i].graphics.moveTo(0, graphHeight - (Game.currentMonster.solution[i] / Config.STAT_MAX) * graphHeight);
				lines[i].visible = Game.stats.activeStats[i];
				addChild(lines[i]);
			}
		}
	}

}