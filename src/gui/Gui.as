package gui
{
	import actions.Action;
	import actions.cards.Card;
	import aze.motion.easing.Bounce;
	import aze.motion.easing.Quadratic;
	import aze.motion.eaze;
	import aze.motion.EazeTween;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import monsters.EasyMidMonster;
	import monsters.Monster;
	/**
	 * ...
	 * @author Sarah Northway
	 */
	public class Gui extends Sprite
	{
		public function Gui()
		{
			instance = this;
			
			gfx = new GfxGui();
			addChild(gfx);
			
			timeline = new GuiTimeline(gfx.timeline);
			
			Utils.removeFromParent(gfx.introMenu);
			gfx.introMenu.addEventListener(MouseEvent.CLICK, closeIntro);
			
			//GuiButton.replaceButton(gfx.edgeScrollerLeft);
			//gfx.edgeScrollerLeft.addEventListener(MouseEvent.MOUSE_OVER, scrollerOver);
			//gfx.edgeScrollerLeft.useHandCursor = false;
			
			//GuiButton.replaceButton(gfx.edgeScrollerRight);
			//gfx.edgeScrollerRight.addEventListener(MouseEvent.MOUSE_OVER, scrollerOver);
			//gfx.edgeScrollerRight.useHandCursor = false;
			
			addEventListener(Event.ENTER_FRAME, enterFrame);
			
			addChild(mainMenu = new GuiMainMenu(gfx.mainMenu));
			GuiButton.replaceButton(gfx.mainMenuButton, showMainMenu);
			
			gfx.strongFemaleProtagonist.gotoAndStop(1);
			animationTick = 1000 * 10;
			
			// controls monster running around or whatever
			monster = new GuiMonster(gfx.monster);
			
			MusicPlayer.playMusic(MusicPlayer.MAINMENU);
			
			Utils.removeFromParent(gfx.winScreen);
			GuiButton.replaceButton(gfx.winScreen.doneButton, hideWinScreen);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		private function onMouseDown(e:MouseEvent):void {
			//Main.particles.addParticle(new Point(stage.mouseX, stage.mouseY), Utils.getRandomNumber(2,5));
		}

		protected function showMainMenu():void
		{
			MusicPlayer.playMusic(MusicPlayer.MAINMENU);
			Utils.addToParent(this, mainMenu);
			mainMenu.y = 640;
			eaze(mainMenu).to(0.6, { y:0 }, true)
				.easing(Bounce.easeOut);
		}
		
		/**
		 * Called by mainMenu startButton.
		 */
		public function startGame(monster:Monster):void
		{
			Game.init(monster);
			cardsDrawn = 0;
			drawNextCard();
			timeline.reset();
			Utils.addToParent(gfx, gfx.introMenu);
			gfx.introMenu.gotoAndPlay(1);
			gfx.introMenu.y = 0;
			MusicPlayer.playMusic(MusicPlayer.LULLABY);
			eaze(mainMenu).to(0.6, { y: 640 }, true)
				.easing(Quadratic.easeIn)
				.onComplete(reallyStartGame);
				
			SaveManager.collectMonster(monster);
		}
		
		public function reallyStartGame():void {
			Utils.removeFromParent(mainMenu);
		}
		
		protected function closeIntro(...ig):void
		{
			MusicPlayer.playMusic(Utils.pickRandom(MusicPlayer.GAME_SONGS));
			eaze(gfx.introMenu).to(0.6, { y: 640 }, true)
				.easing(Quadratic.easeIn)
				.onComplete(reallyStartGame);
		}
		
		public function reallyCloseIntro():void {
			Utils.removeFromParent(gfx.introMenu);
			gfx.introMenu.y = 0;
		}
		
		/**
		 * Show or hide the tooltip when over a card.
		 */
		protected function enterFrame(...ig):void
		{
			// fade music in or out
			MusicPlayer.threadTick();
			
			// animate strongFemaleCharacter for 2 seconds
			if (animationTick < stage.frameRate * 2) {
				// framerate is 1 frame every second/3
				if (animationTick % (stage.frameRate/3) == 0) {
					var newFrame:int = gfx.strongFemaleProtagonist.currentFrame % gfx.strongFemaleProtagonist.totalFrames + 1;
					gfx.strongFemaleProtagonist.gotoAndStop(newFrame);
				}
				animationTick++;
			}
			
			// if we're over a card or plotPoint, show the tooltip for it
			var globalPoint:Point = new Point(stage.mouseX, stage.mouseY);
			var objectsUnderPoint:Array = stage.getObjectsUnderPoint(globalPoint);
			var showtingTooltip:Boolean = false;
			for each (var object:DisplayObject in objectsUnderPoint) {
				var action:GuiAction = Utils.findAncestor(object, GuiAction);
				if (action != null && (action is GuiPlotPoint || !isNextCard(action as GuiCard))) {
					showTooltip(action);
					showtingTooltip = true;
				}
			}
			if (!showtingTooltip) {
				hideTooltip();
			}
			
			// if we're over a scroller, scroll that mutherfucker
			//var scrollerFound:Boolean = false;
			/*for each (var thingy:DisplayObject in objectsUnderPoint) {
				var scroller:GfxEdgeScroller = Utils.findAncestor(thingy, GfxEdgeScroller);
				if (scroller != null) {
					scrollerOver(scroller);
					scrollerFound = true;
				}
			}
			if (!scrollerFound) {
				scrollerOut();
			}*/
		}
		
		//protected function scrollerOver(scroller:GfxEdgeScroller):void
		//{
			//scroller.addEventListener(Event.ENTER_FRAME, scrollerEnterFrame);
		//}
		
		//protected function scrollerEnterFrame(event:Event):void
		//{
			//var left:Boolean = (event.target == gfx.edgeScrollerLeft);
			//
			// from 0 (inside) to 1 (outside)
			//var scrollXPercent:Number = event.target.mouseX / event.target.width;
			//var diffX:Number = 20 * scrollXPercent;
			//if (event.target != gfx.edgeScrollerLeft) {
				//diffX *= -1;
			//}
			//gfx.timeline.x += diffX;
			//
			// stop from scrolling off the edge
			//if (gfx.timeline.x > gfx.timelineMask.x) {
				//gfx.timeline.x = gfx.timelineMask.x;
			//} else if (gfx.timeline.x + gfx.timeline.width < gfx.timelineMask.x + gfx.timelineMask.width) {
				//gfx.timeline.x = gfx.timelineMask.width + gfx.timelineMask.x - gfx.timeline.width;
			//}
		//}
		
		//protected function scrollerOut():void
		//{
			//gfx.edgeScrollerLeft.removeEventListener(Event.ENTER_FRAME, scrollerEnterFrame);
			//gfx.edgeScrollerRight.removeEventListener(Event.ENTER_FRAME, scrollerEnterFrame);
		//}
		
		public var tooltipFadingIn:Boolean = false;
		protected function showTooltip(guiAction:GuiAction):void
		{
			if (gfx.winScreen.stage) {
				return;
			}
			
			if (Utils.isEmpty(guiAction.action.outcomeDescription)) {
				gfx.tooltip.info.text = "OutcomeDescription is blank for this";
			} else {
				gfx.tooltip.info.text = guiAction.action.outcomeDescription;
			}
			gfx.tooltip.x = guiAction.localToGlobal(new Point(0, 0)).x + (guiAction.width / 2);
			
			if (gfx.tooltip.parent != null && gfx.tooltip.alpha == 1) {
				return;
			}
			Utils.addToParent(gfx, gfx.tooltip);
			
			if (tooltipFadingIn) return;
			
			gfx.tooltip.alpha = 0;
			eaze(gfx.tooltip).delay(0.5).to(0.5, { alpha:1 }, false);
			tooltipFadingIn = true;
			//Utils.fadeIn(gfx.tooltip, 100, false);
		}
		
		public function hideTooltip(...ig):void
		{
			if (gfx.tooltip.parent == null) {
				return;
			}
			EazeTween.killTweensOf(gfx.tooltip);
			gfx.tooltip.alpha = 0;
			gfx.tooltip.parent.removeChild(gfx.tooltip);
			tooltipFadingIn = false;
			//eaze(gfx.tooltip).to(0.2, { alphaVisible:0 }, true);
			//Utils.fadeOut(gfx.tooltip, 100, true);
		}
		
		/**
		 * After a card is placed, refresh the timeline, check for win & draw next card.
		 */
		public function cardPlaced(card:Card):void
		{
			timeline.refresh();
			
			// will trigger gfx.strongFemaleCharacter to animate on enterFrame
			animationTick = 0;
			
			SoundPlayer.playMonsterSound(Utils.pickRandom([true, false]));
			
			if (percentCardsDrawn >= 1) {
				finishGame();
			} else {
				drawNextCard();
			}
		}

		/**
		 * After a card is placed, refresh the timeline, check for win & draw next card.
		 */
		public function cardMoved():void
		{
			timeline.refresh();
			
			// will trigger gfx.strongFemaleCharacter to animation on enterFrame
			animationTick = 0;
			
			if (percentCardsDrawn >= 1) {
				finishGame();
			} else {
				//drawNextCard();
			}
		}
		
		protected function finishGame():void {
			var monster:Monster;
			if (Game.isFinished() || Config.ALWAYS_WIN_WITH_NO_DECK) {
				monster = Game.returnNextMonster();
				if (monster == null) {
					MusicPlayer.playMusic(MusicPlayer.ROCKIN);
					
					new GuiFloatText(Main.snipeLayer, "YOU got a " + Game.currentMonster.name + "!!!", new Point(100, 200));
					setEndingMonster(Game.currentMonster);
					GuiMonster.setMonsterSomewhere(gfx.winScreen.monster, Game.currentMonster);
					gfx.winScreen.info.text = "You raised a " + Game.currentMonster.name + "!";
					
					Utils.addToParent(gfx, gfx.winScreen);
					gfx.winScreen.scaleX = 1;
					gfx.winScreen.scaleY = 1;
					gfx.winScreen.y = 640;
					eaze(gfx.winScreen).to(0.6, { y:0 }, true)
						.easing(Bounce.easeOut);
				} else {
					// more monsters to go
					GuiMonster.setMonsterSomewhere(gfx.winScreen.monster, Game.currentMonster);
					gfx.winScreen.info.text = "You raised a " + Game.currentMonster.name + "!";
					Utils.addToParent(gfx, gfx.winScreen);
					gfx.winScreen.scaleX = 1;
					gfx.winScreen.scaleY = 1;
					gfx.winScreen.y = 640;
					eaze(gfx.winScreen).to(0.6, { y:0 }, true)
						.easing(Bounce.easeOut);
					
					startGame(monster);
				}
			}
		}
		
		protected function hideWinScreen():void
		{
			eaze(gfx.winScreen).to(0.3, { scaleX:0, scaleY:0 }, true)
				.onComplete(reallyHideWinScreen);
		}
		
		private function reallyHideWinScreen():void {
			Utils.removeFromParent(gfx.winScreen);
			if ( Game.currentMonster == Monster.allMonsters[Monster.allMonsters.length-1] ){
				showMainMenu();
			}
		}
		
		protected function drawNextCard():void
		{
			Utils.clearChildren(gfx.nextCard);
			
			var card:Card;
			try {
				card = Game.deck.pop();
			} catch (error:Error) {
				Utils.logError(error);
				card = new Card();
			}
			if ( card != null ) {
				var nextCard:GuiCard = new GuiCard(card);
				gfx.nextCard.addChild(nextCard);
			}
			
			//if (percentCardsDrawn < 0.20) {
				//MusicPlayer.playMusic(MusicPlayer.ORCHESTRAAAL);
			//} else if (percentCardsDrawn < 0.40) {
				//MusicPlayer.playMusic(MusicPlayer.DRUMS);
			//} else if (percentCardsDrawn < 0.60) {
				//MusicPlayer.playMusic(MusicPlayer.STAMPEDE);
			//} else if (percentCardsDrawn < 0.70) {
				//MusicPlayer.playMusic(MusicPlayer.LULLABY);
			//} else {
				//MusicPlayer.playMusic(MusicPlayer.RACIST);
			//}
			cardsDrawn++;
		}
		
		protected function get percentCardsDrawn():Number
		{
			return cardsDrawn / Game.currentMonster.deck.length;
		}
		
		public function isNextCard(card:GuiCard):Boolean
		{
			if (gfx.nextCard.numChildren == 0 ) {
				return false;
			}
			return gfx.nextCard.getChildAt(0) == card;
		}
		
		public function setEndingMonster(value:Monster):void
		{
			gfx.monsterName.text = "Trying to raise a\n" + value.name;
			monster.setMonster(value);
		}
		
		/** fills a slot; either a GuiCard or a GfxEvent */
		protected var actions:Vector.<*> = new Vector.<*>();
		
		protected var gfx:GfxGui;
		public var timeline:GuiTimeline;
		protected var cardsDrawn:int = 0;
		protected var animationTick:int = 0;
		
		protected var mainMenu:GuiMainMenu;
		protected var monster:GuiMonster;
		
		public static var instance:Gui;
	}
}