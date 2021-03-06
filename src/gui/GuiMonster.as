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
	 *
		Aqualope
		Terratrope
		Windross
		Firebat
		Blorb
		Omniolyte
		Tonguy
		-- recolors:
		Mockalope
		Terrortrope
		Pinkdross
		Pyrebat
		Mlorb
		Bobolyte
		Negagore
	 */
	public dynamic class GuiMonster
	{
		//protected static const ALL_MONSTER_NAMES:Array = ["Aqualope", "Terratrope", "Windross", "Firebat", "Blorb", "Omniolyte", "Tonguy", "Negagore", "Mockalope", "Terrortrope", "Pinkdross", "Pyrebat", "Mlorb", "Bobolyte"];
		
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
				Utils.toggleChildVisibility(gfx, "Aqualope");
			}
		}
		
		private var chaseMode:Boolean = false;
		protected function monsterClick(...ig):void {
			if (chaseMode) {
				chaseMode = false;
				//eaze(gfx).to(0.5, { x:0, y:0 }, false);
			} else {
				chaseMode = true;
			}
		}
		
		public var mouseAvoidScore:Number = 0;
		public var ticks:Number = 0;
		public var velocity:Point = new Point();
		protected function enterFrame(...ig):void {
			ticks++;
			gfx.rotation = Math.sin(ticks / 5) * 5;
			
			if (chaseMode) {
				mouseAvoidScore++;
				Utils.log("MouseAvoidScore: " + mouseAvoidScore);
				var mouseLoc:Point = new Point(gfx.stage.mouseX, gfx.stage.mouseY);
				var thisLoc:Point = new Point(gfx.x, gfx.y);
				var relative:Point = mouseLoc.subtract(thisLoc);
				relative.normalize(5);
				velocity = velocity.add(relative);
				if (velocity.length > 25) velocity.normalize(25);
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
			mouseAvoidScore = 0;
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