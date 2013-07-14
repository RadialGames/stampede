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
			gfx.addEventListener(MouseEvent.CLICK, monsterClick);
			bubbleOnMouseOver(1.5);
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
		
		private var chaseMode:Boolean = false;
		protected function monsterClick(...ig):void {
			if (chaseMode) {
				chaseMode = false;
				eaze(gfx).to(0.5, { x:0, y:0 }, false);
			} else {
				chaseMode = true;
			}
		}
		
		public var ticks:Number = 0;
		public var velocity:Point = new Point();
		protected function enterFrame(...ig):void
		{
			ticks++;
			gfx.rotation = Math.sin(ticks / 5) * 5;
			
			if (chaseMode) {
				var mouseLoc:Point = new Point(gfx.stage.mouseX, gfx.stage.mouseY);
				var thisLoc:Point = new Point(gfx.x, gfx.y);
				var relative:Point = mouseLoc.subtract(thisLoc);
				relative.normalize(3);
				velocity = velocity.add(relative);
				if (velocity.length > 15) velocity.normalize(15);
				gfx.x += velocity.x;
				gfx.y += velocity.y;
			}
			//Utils.log("im walking here");
		}
		
		protected var gfx:MovieClip;
		
		public function cancelBubble():void {
			if (isNaN(originalScale))
				mouseOverShrink(null);
			gfx.removeEventListener(MouseEvent.MOUSE_OVER, mouseOverGrow);
		}
		
		private var scaleAmount:Number;
		private var overrideTween:Boolean;
		public function bubbleOnMouseOver(scaleAmount:Number = 1.2, overrideTween:Boolean = true):void {
			this.overrideTween = overrideTween;
			this.scaleAmount = scaleAmount;
			gfx.addEventListener(MouseEvent.MOUSE_OVER, mouseOverGrow);
		}
		
		private var originalScale:Number;
		private function mouseOverGrow(e:MouseEvent):void {
			gfx.addEventListener(MouseEvent.MOUSE_OUT, mouseOverShrink);
			if (isNaN(originalScale)) originalScale = gfx.scaleX;
			eaze(gfx)
				.to(0.2, { scaleX:originalScale * scaleAmount, scaleY:originalScale * scaleAmount } , overrideTween);
		}
		
		private function mouseOverShrink(e:MouseEvent):void {
			gfx.removeEventListener(MouseEvent.MOUSE_OUT, mouseOverShrink);
			eaze(gfx)
				.to(0.2, { scaleX:originalScale, scaleY:originalScale }, overrideTween)
				.onComplete(mouseOverShrinkComplete);
		}
		
		private function mouseOverShrinkComplete():void {
			originalScale = NaN;
		}
			
	}
}