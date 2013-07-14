package gui {

import aze.motion.EazeTween;
import aze.motion.eaze;
import flash.display.Sprite;
import flash.filters.BitmapFilter;
import flash.filters.DropShadowFilter;
import flash.geom.Point;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
	
public class GuiFloatText extends Sprite {

	public var clip:BitmapText;
	private var fadeDelay:Number; // in seconds
	public var done:Boolean;
	public var headDown:Boolean;
	
	public static var oldRef:GuiFloatText;
	
	public function GuiFloatText(drawTo:Sprite, textToDisplay:String, destination:Point):void {
		super();
		done = false;
		
		// First let's see if there's an old one to clean up
		if (oldRef != null) {
			
			EazeTween.killTweensOf(oldRef);
			eaze(oldRef)
				.delay(0, true)
				.to( 0.25, { alpha:0, y:oldRef.y - 20 }, true )
				.onComplete(oldRef.removeAndKill);
			oldRef = null;
		}
		
		// IS BROKEN
		fadeDelay = 4;
		drawTo.addChild(this);
		
		var format:TextFormat = new TextFormat("adams hand");
		format.align = TextFormatAlign.CENTER;
		format.size = Config.SNIPE_FONT_SIZE;
		format.color = Config.SNIPE_COLOUR;
		var myFilters:Array = [new DropShadowFilter(2, 45, 0x0, 0.1, 0, 0, 2, 3, false, false, false)];
		
		clip = new BitmapText(textToDisplay, format, myFilters);
					
		addChild(clip);
		
		this.x = destination.x;
		this.y = destination.y;
		this.y += 20;

		eaze(this)
			.to( 0.5, { y:destination.y }, false );
			
		eaze(this)
			.delay(fadeDelay, false)
			.to( fadeDelay / 4, { alpha:0, y:destination.y - 20 }, false )
			.onComplete(removeAndKill);

		this.mouseEnabled = false;
		this.mouseChildren = false;
		oldRef = this;
	}
	
	public function removeAndKill():void {
		if (oldRef == this) oldRef = null;
		done = true;
		if (this.parent) {
			this.parent.removeChild(this);
		}
		while (this.numChildren) removeChildAt(0);
	}
}

}