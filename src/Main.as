package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import gui.*;

	/**
	 * ...
	 * @author Colin Northway
	 */
	[Frame(factoryClass="Preloader")]
	public class Main extends Sprite
	{

		public function Main():void
		{
			instance = this;
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			Game.init();
			addChild(new Gui());
		}
		
		/**
		 * Add a handler to the stage(immediately or when the stage exists) and
		 * record the unloader for it for later.
		*/
		public static function addStageEventListener(type:String, listener:Function,
			useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			try {
				instance.stage.addEventListener(type, listener, useCapture,
					priority, useWeakReference);
			} catch(error:Error) {
				Utils.logError("Couldn't set stage event listener", error);
			}
		}
		
		public static function removeStageEventListener(type:String, listener:Function):void
		{
			instance.stage.removeEventListener(type, listener);
		}

		public static var instance:Main;
		public static var game:Game;
	}

}