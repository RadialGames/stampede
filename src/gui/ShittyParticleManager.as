package gui 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Andy Moore
	 */
	public class ShittyParticleManager extends Sprite {		
		private var bits:Vector.<Particle> = new Vector.<Particle>();
		private var paused:Boolean = false;
		
		public function ShittyParticleManager () {
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		public function addParticle(position:Point, qty:Number):void {
			var newBit:Particle;
			for (var i:Number = 0; i < qty; i++) {
				newBit = new Particle(GfxMonsterInner); // currently ignores what you pass it here
				newBit.x = position.x;
				newBit.y = position.y;
				bits.push(newBit);
				addChild(newBit);
			}
		}
		
		public function pause():void { paused = true; }
		public function resume():void { paused = false; }
		
		public function update(e:Event):void {
			if (paused) return;
			if (bits.length < 1) return;
			for (var i:Number = bits.length-1; i >= 0; i--) { // has to go backwards for splicin'
				if (!bits[i]) continue; // already null
				
				bits[i].moveWithVec();

				if (bits[i].y > 540 + bits[i].height + 10) {
					bits[i].removeAndKill();
					bits[i] = null;
					bits.splice(i, 1);
				}
			}
		}
		
		public function kill():void {
			removeEventListener(Event.ENTER_FRAME, update);
			for (var i:Number = bits.length-1; i >= 0; i--) {
				bits[i].removeAndKill();
				bits[i] = null;
			}
			bits = null;
		}
	}
}