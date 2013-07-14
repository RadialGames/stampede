package
{
	import flash.display.ShaderParameter;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.text.TextField;
	import gui.*;
	import monsters.EasyMidMonster;

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
			
			Utils.pickOriginalRandomSeed();
			//Game.init(new EasyMidMonster());
			addChild(new Gui());
			SaveManager.load();
			snipeLayer = new Sprite();
			addChild(snipeLayer);
			particles = new ShittyParticleManager();
			snipeLayer.addChild(particles);
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
		public static var snipeLayer:Sprite;
		public static var particles:ShittyParticleManager;
	}
}