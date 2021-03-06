package gui
{
	import actions.Action;
	import aze.motion.easing.Bounce;
	import aze.motion.easing.Linear;
	import aze.motion.easing.Quadratic;
	import aze.motion.eaze;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import monsters.Monster;
	/**
	 * Splash screen, credits etc.
	 * @author Sarah Northway
	 */
	public class GuiMainMenu extends Sprite
	{
		public function GuiMainMenu(gfx:MovieClip)
		{
			this.gfx = gfx;
			addChild(gfx);
			
			//GuiButton.replaceButton(gfx.playButton, Gui.instance.startGame);
			GuiButton.replaceButton(gfx.creditsButton, showCredits);
			GuiButton.replaceButton(gfx.credits.doneButton, hideCredits);
			GuiButton.replaceButton(gfx.muteButton.selected, toggleMute);
			GuiButton.replaceButton(gfx.muteButton.deselected, toggleMute);
			GuiButton.replaceButton(gfx.resetButton, resetMonsters);
			
			monsterXSpacing = gfx.monsters.monster2.x;
			monsterYSpacing = gfx.monsters.monster14.y;
			
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		
		protected function addedToStage(...ig):void
		{
			if (Config.MUTE) {
				Utils.removeFromParent(gfx.muteButton.selected);
				Utils.addToParent(gfx.muteButton, gfx.muteButton.deselected);
			} else {
				Utils.removeFromParent(gfx.muteButton.deselected);
				Utils.addToParent(gfx.muteButton, gfx.muteButton.selected);
			}
			
			Utils.clearChildren(gfx.monsters);
			for (var i :int = 0; i < Monster.allMonsters.length; i++) {
				var monster:Monster = Monster.allMonsters[i];
				var monsterButton:GuiButton = replaceMonsterButton(monster);
				monsterButton.bubbleOnMouseOver(1.5);
				var inners:Array = Utils.buttonClasses(monsterButton, GfxMonsterInner);
				for each (var inner:GfxMonsterInner in inners) {
					GuiMonster.setMonsterSomewhere(inner, monster);
					//inner.monsterName.text = monster.name;
					//if (!SaveManager.hasCollectedMonster(monster)) {
						//Utils.removeFromParent(inner.monster);
					//} else {
						//GuiMonster.setMonsterSomewhere(inner.monster, monster);
					//}
				}
				if (i != 0 && !SaveManager.hasCollectedMonster(monster)) {
					monsterButton.enabled = false;
				}
				monsterButton.x = (i % 7) * monsterXSpacing;
				if (i > 6) {
					monsterButton.y = monsterYSpacing;
					if (i % 2 == 1) {
						monsterButton.y += 10;
					}
				} else {
					if (i % 2 == 0) {
						monsterButton.y += 10;
					}
				}
				gfx.monsters.addChild(monsterButton);
			}
			gfx.resetButton.text = "reset monsters";
			
			reallyHideCredits();
		}
		
		protected function replaceMonsterButton(monster:Monster):GuiButton
		{
			var monsterButton:GuiButton = GuiButton.replaceButton(new GfxMonster(), function():void {
				Gui.instance.startGame(monster, true) } );
			return monsterButton;
		}
		
		protected function showCredits():void
		{
			Utils.addToParent(gfx, gfx.credits);
			gfx.credits.y = 640;
			eaze(gfx.credits).to(1, { y:0 }, true)
				.easing(Bounce.easeOut);
			MusicPlayer.playMusic(MusicPlayer.CREDITS);
		}
		
		protected function hideCredits():void
		{
			eaze(gfx.credits).to(0.6, { y:640 }, true)
				.easing(Quadratic.easeIn)
				.onComplete(reallyHideCredits);
			//reallyHideCredits();
		}
		
		protected function reallyHideCredits():void {
			Utils.removeFromParent(gfx.credits);
			MusicPlayer.playMusic(MusicPlayer.MAINMENU);
		}
		
		protected function toggleMute():void
		{
			Config.MUTE = !Config.MUTE;
			if (Config.MUTE) {
				Utils.removeFromParent(gfx.muteButton.selected);
				Utils.addToParent(gfx.muteButton, gfx.muteButton.deselected);
				MusicPlayer.stopMusic();
			} else {
				Utils.removeFromParent(gfx.muteButton.deselected);
				Utils.addToParent(gfx.muteButton, gfx.muteButton.selected);
				MusicPlayer.playMusic(MusicPlayer.MAINMENU);
			}
			SaveManager.save();
			eaze(gfx.muteButton).to(0.3, { scaleX:1.1, scaleY:1.1 } ).easing(Quadratic.easeOut)
				.chain(gfx.muteButton).to(0.3, { scaleX:1.0, scaleY:1.0 } ).easing(Quadratic.easeIn);
		}
		
		protected function resetMonsters():void
		{
			if (gfx.resetButton.text == "you sure??") {
				SaveManager.clearCollectedMonsters();
				new GuiFloatText(Main.snipeLayer, "okay, done!", new Point(200, 100));
				gfx.resetButton.text = "reset monsters";
				addedToStage();
			} else {
				gfx.resetButton.text = "you sure??";
			}
		}
		
		protected var gfx:MovieClip;
		protected var monsterXSpacing:Number;
		protected var monsterYSpacing:Number;
	}
}