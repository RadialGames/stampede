package gui
{
	import actions.Action;
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
			
			GuiButton.replaceButton(gfx.playButton, Gui.instance.startGame);
			GuiButton.replaceButton(gfx.creditsButton, showCredits);
			GuiButton.replaceButton(gfx.credits.doneButton, hideCredits);
			GuiButton.replaceButton(gfx.muteButton.selected, toggleMute);
			GuiButton.replaceButton(gfx.muteButton.deselected, toggleMute);
			GuiButton.replaceButton(gfx.resetButton, resetMonsters);
			
			monsterSpacing = gfx.monsters.monster2.x;
			
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
				var monsterButton:GfxMonster = new GfxMonster();
				var inners:Array = Utils.buttonClasses(monsterButton, GfxMonsterInner);
				for each (var inner:GfxMonsterInner in inners) {
					inner.monsterName.text = monster.name;
					if (!SaveManager.hasCollectedMonster(monster)) {
						Utils.removeFromParent(inner.monster);
					} else {
						if (inner.monster.hasOwnProperty(monster.name)) {
							Utils.toggleChildVisibility(inner.monster, monster.name);
						} else {
							Utils.toggleChildVisibility(inner.monster, "tungee");
						}
					}
				}
				if (!SaveManager.hasCollectedMonster(monster)) {
					monsterButton.enabled = false;
				}
				monsterButton.x = i * monsterSpacing;
				gfx.monsters.addChild(monsterButton);
			}
			gfx.resetButton.text = "reset monsters";
			
			hideCredits();
		}
		
		protected function showCredits():void
		{
			Utils.addToParent(gfx, gfx.credits);
			MusicPlayer.playMusic(MusicPlayer.CREDITS);
		}
		
		protected function hideCredits():void
		{
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
		protected var monsterSpacing:Number;
	}
}