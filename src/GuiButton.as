package
{
	import adobe.utils.ProductManager;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	
	/**
	 * Controller for a SimpleButton which can set it to disabled/enabled or turned on or off.
	 * Inserts itself in place of the given button.
	 *
	 * @author Sarah Northway
	 */
	public class GuiButton extends SimpleButton
	{
		public function GuiButton ()
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		
		/**
		 * Like a body snatcher, the GuiButton crawls into the skin of the original
		 * SimpleButton, taking on it's form and taking it's place on the stage.
		 * @param uniqueOverState If false, the upState and overState are the same
		 */
		public static function replaceButton (originalButton:SimpleButton,
			clickFunction:Function = null, text:String = null, uniqueOverState:Boolean = true,
			button:GuiButton = null, makeBitmap:Boolean = false, bitmapGutter:int = 0):GuiButton
		{
			if (originalButton == null) {
				if (Config.DEBUG_MODE) {
					throw new Error("Could not create GuiButton with null originalButton");
				}
				Utils.logError("Could not create GuiButton with null originalButton");
				return null;
			}
				
			if (button == null) {
				button = new GuiButton();
			}
			
			button.makeBitmap = makeBitmap;
			button.bitmapGutter = bitmapGutter;
			
			// no over state in mobile version, only down state
			if (makeBitmap) {
				originalButton.overState = originalButton.upState;
			}
			
			button.originalButton = originalButton;
			
			// always use this hitmap for all states forever
			button.hitTestState = originalButton.hitTestState;
			
			// always show the container sprite, but change its contents on mouseup/over/down
			button.upState = button.container;
			button.overState = button.container;
			button.downState = button.container;
			
			button.selectedUpState = originalButton.downState;
			button.deselectedUpState = originalButton.upState;
			
			if (uniqueOverState) {
				button.selectedOverState = originalButton.overState;
				button.deselectedOverState = originalButton.overState;
			} else {
				button.selectedOverState = originalButton.downState;
				button.deselectedOverState = originalButton.upState;
			}
			
			button.x = originalButton.x;
			button.y = originalButton.y;
			if (originalButton.parent != null) {
				originalButton.parent.addChildAt(button, originalButton.parent.getChildIndex(originalButton));
				if (originalButton.parent is MovieClip) {
					originalButton.parent[originalButton.name] = button;
				}
				originalButton.parent.removeChild(originalButton);
			}
			
			button.transform = originalButton.transform;
			button.filters = originalButton.filters;
			
			// set text without double-bitmapizing the button (don't use text=blah)
			if (text != null) {
				Utils.setButtonText(originalButton, text);
				button._text = text;
			}
			
			button.cachedUpState = originalButton.upState;
			button.cachedOverState = originalButton.overState;
			button.cachedDownState = originalButton.downState;
			
			// call buttonClicked and buttonDown at runtime to support subclassing
			button.clickFunction = clickFunction;
			button.addEventListener(MouseEvent.CLICK, button.buttonClicked);
			
			button.addEventListener(MouseEvent.MOUSE_DOWN, button.mouseDown);
			button.addEventListener(MouseEvent.MOUSE_UP, button.mouseUp);
			// use ROLL_OVER instead of MOUSE_OVER so it ignores children and only fires once
			button.addEventListener(MouseEvent.ROLL_OVER, button.mouseOver);
			button.addEventListener(MouseEvent.ROLL_OUT, button.mouseOut);
			
			// change all the layers to bitmaps
			button.bitmapize();
			
			// tell the button which graphics to show
			button.buttonState = BUTTON_STATE_UP;
			
			return button;
		}
		
		public function set selected (value:Boolean):void
		{
			_selected = value;
			if (value) {
				cachedUpState = selectedUpState;
				cachedOverState = selectedOverState;
			} else {
				cachedUpState = deselectedUpState;
				cachedOverState = deselectedOverState;
			}
			updateVisibleButtonState();
		}
		
		public function get selected ():Boolean
		{
			return _selected;
		}
		
		public function toggle (...ig):Boolean
		{
			selected = !selected;
			return selected;
		}
		
		override public function get enabled():Boolean
		{
			if (disabledWhileClicking) {
				return false;
			}
			return super.enabled;
		}
		
		override public function set enabled (value:Boolean):void
		{
			super.enabled = value;
			if (value) {
				transform.colorTransform = new ColorTransform();
			} else {
				transform.colorTransform = new ColorTransform(.5, .5, .5, 1, 100, 100, 100, 0);
			}
		}
		
		public function get text ():String
		{
			return _text;
		}
		
		public function set text (value:String):void
		{
			// don't update bitmaps if text didn't actually change
			if (_text == value) {
				return;
			}
			_text = value;
			
			setTextInClass(value);
		}
		
		/**
		 * Set the text of the button, but only in a particular class (or in all classes if
		 * inClass is null). Set it in the original button then bitmapize all states.
		 */
		public function setTextInClass (value:String, inClass:Class = null):void
		{
			if (originalButton == null) {
				return;
			}
			// don't set _text = value, because only one class is changing not total text
			//_text = value;
			
			// replace all text in all TextFields
			if (inClass == null) {
				Utils.setButtonText(originalButton, value);
				
			// replace text in TextFields inside inClass only
			} else {
				var classes:Array = Utils.buttonClasses(originalButton, inClass);
				for each (var classObject:* in classes) {
					var textfields:Array = Utils.findClasses(classObject, TextField);
					for each (var textField:TextField in textfields) {
						textField.text = value;
					}
				}
			}
			updateBitmaps();
		}
		
		public function updateBitmaps ():void
		{
			//this.upState = originalButton.upState;
			//this.overState = originalButton.overState;
			//this.downState = originalButton.downState;
			
			bitmapize();
			updateVisibleButtonState();
		}
		
		/**
		 * Replace the button states with bitmaps. Leave the hitmap alone.
		 * Note bitmapizing doesn't work on selected states but none change in Rebuild 2
		 */
		protected function bitmapize ():void
		{
			if (!makeBitmap) {
				return;
			}
			
			cachedUpState = originalButton.upState;
			cachedOverState = originalButton.overState;
			cachedDownState = originalButton.downState;
			
			//cachedUpState = Utils.bitmapize(cachedUpState, bitmapGutter);
			//cachedOverState = Utils.bitmapize(cachedOverState, bitmapGutter);
			//cachedDownState = Utils.bitmapize(cachedDownState, bitmapGutter);
			
			//for each (var state:String in ["upState", "overState", "downState"]) {
				//buttonStates[state] = Utils.bitmapize(originalButton[state], bitmapGutter);
			//}
		}
		
		/**
		 * SimpleButtons sometimes stay in the overState if they are attached to an object
		 * which is removed from the stage onclick. This blips the focus to reset buttons to
		 * the upState.
		 */
		protected function addedToStage (...ig):void
		{
			buttonState = BUTTON_STATE_UP;
			//Config.stage.focus = this;
			//Config.stage.focus = Config.stage;
		}
		
		/**
		 * Fire the clickFunction if there is one and the button's enabled. Catch all errors in
		 * production mode.
		 */
		protected function buttonClicked (...ig):void
		{
			if (clickFunction == null || !enabled) {
				return;
			}
			
			// autosaves may happen in response to any button press
			// because then the user might be expecting a pause anyway
			//if (SaveManager.timeToAutosave) {
				//SaveManager.autosave();
			//}
			
			if (Config.DEBUG_MODE) {
				//if (clickFunction.length == 1) {
				if (clickArgument) {
					clickFunction(this);
				} else {
					clickFunction();
				}
			} else {
				try {
					//if (clickFunction.length == 1) {
					if (clickArgument) {
						clickFunction(this);
					} else {
						clickFunction();
					}
				} catch (error:Error) {
					Utils.logError(originalButton.name + " click err ", error);
				}
			}
			
			disabledWhileClicking = true;
			Utils.startTimer(250, function():void {
				disabledWhileClicking = false;
			});
		}
		
		protected function mouseDown (...ig):void
		{
			if (!enabled) {
				return;
			}
			buttonState = BUTTON_STATE_DOWN;
			
			//if (enabled && clickNoise) {
				//SoundPlayer.playClick();
			//}
		}
		
		protected function mouseUp (...ig):void
		{
			if (!enabled) {
				return;
			}
			buttonState = BUTTON_STATE_OVER;
		}
		
		protected function mouseOver (...ig):void
		{
			if (!enabled) {
				return;
			}
			buttonState = BUTTON_STATE_OVER;
		}
		
		protected function mouseOut (...ig):void
		{
			//if (!enabled) {
				//return;
			//}
			buttonState = BUTTON_STATE_UP;
		}
		
		protected function get buttonState():int
		{
			return _buttonState;
		}
		
		protected function set buttonState(value:int):void
		{
			if (_buttonState == value) {
				if (name == "buttonSquares") {
					Utils.log("not changing state because it's the same as before");
				}
				return;
			}
			
			var oldState:int = _buttonState;
			_buttonState = value;
			
			// keep the button appearance down until the clickhandler has finished
			if (value == BUTTON_STATE_OVER && oldState == BUTTON_STATE_DOWN) {
				Utils.onNextFrame(updateVisibleButtonState);
			} else {
				updateVisibleButtonState();
			}
		}
		
		protected function updateVisibleButtonState():void
		{
			Utils.clearChildren(container);
			if (buttonState == BUTTON_STATE_UP) {
				Utils.addToParent(container, cachedUpState);
			} else if (buttonState == BUTTON_STATE_OVER) {
				Utils.addToParent(container, cachedOverState);
			} else if (buttonState == BUTTON_STATE_DOWN) {
				Utils.addToParent(container, cachedDownState);
			}
		}
		
		override public function get name():String
		{
			return originalButton.name;
		}
		
		/** Will be called when the button is clicked, if the button is enabled. */
		public var clickFunction:Function;
		
		/** If true, the button makes a clicking noise when pressed if it's enabled */
		public var clickNoise:Boolean = true;
		
		/** If true, will send button instance as argument to clickFunction */
		public var clickArgument:Boolean = false;
		
		/** All children go in this, to override base SimpleButton state changes */
		public var container:Sprite = new Sprite();
		
		/** Multipurpose variable for attaching a value to a button */
		public var value:* = null;
		
		/** If true, replace the button's states with Bitmaps */
		protected var makeBitmap:Boolean;
		protected var bitmapGutter:int = 0;
		
		protected var _selected:Boolean;
		protected var _text:String = null;
		
		public var originalButton:SimpleButton;
		protected var selectedUpState:DisplayObject;
		protected var deselectedUpState:DisplayObject;
		protected var selectedOverState:DisplayObject;
		protected var deselectedOverState:DisplayObject;
		
		/** Up, over or down */
		protected var _buttonState:int;
		
		protected var disabledWhileClicking:Boolean = false;
		
		//protected var buttonStates:Dictionary = new Dictionary();
		
		// these may be vector or bitmap
		protected var cachedUpState:DisplayObject;
		protected var cachedOverState:DisplayObject;
		protected var cachedDownState:DisplayObject;
		
		public static const BUTTON_STATE_UP:int = 1;
		public static const BUTTON_STATE_OVER:int = 2;
		public static const BUTTON_STATE_DOWN:int = 3;
	}
}