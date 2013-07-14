package gui
{
	import actions.cards.Card;
	import aze.motion.eaze;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import actions.cards.Card;
	import monsters.Monster;
	/**
	 * Does something with the monster.
	 */
	public dynamic class GuiMonster
	{
		public function GuiMonster(gfx:MovieClip)
		{
			this.gfx = gfx;
			gfx.addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		public function setMonster(monster:Monster):void
		{
			if (gfx.hasOwnProperty(monster.name)) {
				Utils.toggleChildVisibility(gfx, monster.name);
			} else {
				Utils.toggleChildVisibility(gfx, "tungee");
			}
		}
		
		public var ticks:Number = 0;
		protected function enterFrame(...ig):void
		{
			ticks++;
			gfx.rotation = Math.sin(ticks / 5) * 5;
			//Utils.log("im walking here");
		}
		
		protected var gfx:MovieClip;
	}
}