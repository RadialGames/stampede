package gui
{
	import actions.Action;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
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
			Utils.removeFromParent(gfx.muteButton.deselected);
			
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
		}
		
		protected var gfx:MovieClip;
	}
}