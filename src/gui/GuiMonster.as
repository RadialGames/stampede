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
			setMonsterSomewhere(gfx, monster);
		}
		
		public static function setMonsterSomewhere(gfx:MovieClip, monster:Monster):void
		{
			if (gfx.hasOwnProperty(monster.name)) {
				Utils.toggleChildVisibility(gfx, monster.name);
			} else {
				Utils.toggleChildVisibility(gfx, "tungee");
			}
		}
		
		protected function enterFrame(...ig):void
		{
			//Utils.log("im walking here");
		}
		
		protected var gfx:MovieClip;
	}
}