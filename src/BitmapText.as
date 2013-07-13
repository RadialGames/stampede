package {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.filters.BitmapFilter;
	import flash.filters.DropShadowFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author Andy Moore
	 */
	public class BitmapText extends Sprite {
		protected var textField:TextField = new TextField();
		protected var textFormat:TextFormat;
		protected var numberText:Number = 0;
		protected var wordWrap:Boolean = false;
		protected var bitmap:Bitmap;
		
		public function BitmapText(text:String, format:TextFormat, filters:Array = null, setWidth:Number = NaN) {
			textFormat = format;			
			textField = new TextField();
			
			if (!isNaN(setWidth)) {
				textField.width = setWidth;
				wordWrap = true;
			}
			
			textField.wordWrap = wordWrap;
			textField.embedFonts = true;
			textField.defaultTextFormat = textFormat;
			textField.antiAliasType = AntiAliasType.ADVANCED;
			textField.selectable = false;
			textField.mouseEnabled = false;
			textField.filters = filters;

			if (textFormat.align == TextFormatAlign.RIGHT) {
				textField.autoSize = TextFieldAutoSize.RIGHT;
			} else if (textFormat.align == TextFormatAlign.CENTER) {
				textField.autoSize = TextFieldAutoSize.CENTER;
			} else {
				textField.autoSize = TextFieldAutoSize.LEFT;
			}
						
			textField.text = text;
			drawBitmap();
		}
		
		public function set number(to:Number):void {
			numberText = Math.round(to);
			text = Utils.addCommasToNumber(numberText);
		}
		
		public function get number():Number {
			return this.numberText;
		}
		
		public function set text(to:String):void {
			textField.text = to;
			drawBitmap();
		}
		
		public function get text():String {
			return textField.text;
		}
		
		protected function drawBitmap():void {
			if (bitmap) {
				removeChild(bitmap);
				bitmap = null;
			}
			
			var tempSprite:Sprite = new Sprite();
			tempSprite.addChild(textField);
			
			// Need the +2 here for the dropshadow-bitmap
			bitmap = new Bitmap(new BitmapData(tempSprite.width+2, tempSprite.height, true, 0x000000), "auto", true);

			// Get the bounds of the object in case top-left isn't 0,0
			var bounds:Rectangle = tempSprite.getBounds(tempSprite);// bitmap);
			var m:Matrix = new Matrix();
			m.translate(-bounds.x, -bounds.y);
			
			bitmap.bitmapData.draw(tempSprite, m);
			addChild(bitmap);
			
			moveBitmap();
		}
		
		protected function moveBitmap():void {
			if (textField.autoSize == TextFieldAutoSize.RIGHT) {
				bitmap.x = 0-bitmap.width;
			} else if (textField.autoSize == TextFieldAutoSize.CENTER) {
				bitmap.x = 0 - (bitmap.width / 2);
			}
		}		
	}
}