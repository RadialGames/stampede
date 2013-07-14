package gui
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author Andy Moore
	 */
	public class Particle extends Sprite {
		private var clip:*;
		private var moveVec:Point;
		private var gravSpeed:Number;
		private var rotateSpeed:Number;
		
		public function Particle( artAsset:Class, gravSpeed:Number = 0.15 ) {
			super();
			clip = new GfxMonsterInner(); // This should actually load the passed art asset.
			
			addChild(clip);
			this.cacheAsBitmap = true;
			this.gravSpeed = gravSpeed;
						
			moveVec = new Point(Utils.getRandomNumber(-3, 3), Utils.getRandomNumber( -3, -1));
			clip.scaleX = Utils.getRandomNumber(0.15,0.5);
			clip.scaleY = clip.scaleX;
			this.rotation = Utils.getRandomInt(0, 360);
			this.rotateSpeed = Utils.getRandomNumber(0.15, 0.5);
			mouseChildren = false;
			mouseEnabled = false;
			clip.mouseChildren = false;
			clip.mouseEnabled = false;
		}

		private var previousTime:Number;
		public function moveWithVec():void {
			var currentTime:Number = getTimer();
			if (!previousTime) previousTime = currentTime;
			var difference:Number = currentTime - previousTime;
			previousTime = currentTime;

			moveVec.y += (gravSpeed * (difference / 16));
			
			this.x += moveVec.x;
			this.y += moveVec.y;
			this.rotation += rotateSpeed;
		}
		
		public function removeAndKill():void {
			if (this.parent) this.parent.removeChild(this);
			while (numChildren > 0) removeChildAt(0);
			
		}
	}
}