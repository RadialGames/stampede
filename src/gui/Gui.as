package gui
{
	import actions.Action;
	import actions.cards.Card;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
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
			
			GuiButton.replaceButton(gfx.edgeScrollerLeft);
			gfx.edgeScrollerLeft.addEventListener(MouseEvent.MOUSE_OVER, scrollerOver);
			gfx.edgeScrollerLeft.useHandCursor = false;
			
			GuiButton.replaceButton(gfx.edgeScrollerRight);
			gfx.edgeScrollerRight.addEventListener(MouseEvent.MOUSE_OVER, scrollerOver);
			gfx.edgeScrollerRight.useHandCursor = false;
			
			addEventListener(Event.ENTER_FRAME, enterFrame);
			
			addChild(mainMenu = new GuiMainMenu(gfx.mainMenu));
			GuiButton.replaceButton(gfx.mainMenuButton, showMainMenu);
			
			gfx.strongFemaleProtagonist.gotoAndStop(1);
			animationTick = 1000 * 10;
			
			MusicPlayer.playMusic(MusicPlayer.MAINMENU);
		}
		
		protected function showMainMenu():void
		{
			MusicPlayer.playMusic(MusicPlayer.MAINMENU);
			Utils.addToParent(this, mainMenu);
		}
		
		/**
		 * Called by mainMenu startButton.
		 */
		public function startGame():void
		{
			Utils.removeFromParent(mainMenu);
			cardsDrawn = 0;
			drawNextCard();
			Game.init();
			timeline.reset();
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
		}
		
		protected function scrollerOver(event:MouseEvent):void
		{
			event.target.addEventListener(MouseEvent.MOUSE_OUT, scrollerOut);
			event.target.addEventListener(Event.ENTER_FRAME, scrollerEnterFrame);
		}
		
		protected function scrollerEnterFrame(event:Event):void
		{
			var left:Boolean = (event.target == gfx.edgeScrollerLeft);
			
			// from 0 (inside) to 1 (outside)
			var scrollXPercent:Number = event.target.mouseX / event.target.width;
			var diffX:Number = 20 * scrollXPercent;
			if (event.target != gfx.edgeScrollerLeft) {
				diffX *= -1;
			}
			gfx.timeline.x += diffX;
			
			// stop from scrolling off the edge
			if (gfx.timeline.x > gfx.timelineMask.x) {
				gfx.timeline.x = gfx.timelineMask.x;
			} else if (gfx.timeline.x + gfx.timeline.width < gfx.timelineMask.x + gfx.timelineMask.width) {
				gfx.timeline.x = gfx.timelineMask.width + gfx.timelineMask.x - gfx.timeline.width;
			}
		}
		
		protected function scrollerOut(event:MouseEvent):void
		{
			event.target.removeEventListener(MouseEvent.MOUSE_OUT, scrollerOut);
			event.target.removeEventListener(Event.ENTER_FRAME, scrollerEnterFrame);
		}
		
		protected function showTooltip(guiAction:GuiAction):void
		{
			if (Utils.isEmpty(guiAction.action.outcomeDescription)) {
				gfx.tooltip.info.text = "Blah blahblahblah blah";
			} else {
				gfx.tooltip.info.text = guiAction.action.outcomeDescription;
			}
			gfx.tooltip.x = guiAction.localToGlobal(new Point(0, 0)).x + (guiAction.width / 2);
			
			if (gfx.tooltip.parent != null && gfx.tooltip.alpha == 1) {
				return;
			}
			Utils.addToParent(gfx, gfx.tooltip);
			Utils.fadeIn(gfx.tooltip, 100, false);
		}
		
		public function hideTooltip(...ig):void
		{
			if (gfx.tooltip.parent == null) {
				return;
			}
			Utils.fadeOut(gfx.tooltip, 100, true);
		}
		
		/**
		 * After a card is placed, refresh the timeline, check for win & draw next card.
		 */
		public function cardPlaced():void
		{
			timeline.refresh();
			
			// will trigger gfx.strongFemaleCharacter to animation on enterFrame
			animationTick = 0;
			
			if (percentCardsDrawn >= 1) {
				MusicPlayer.playMusic(MusicPlayer.ROCKIN);
				var monster:Monster = Utils.pickRandom(Monster.allMonsters);
				new GuiFloatText(this, "YOU got a " + monster.name + "!!!", new Point(100, 200));
				SaveManager.collectMonster(monster);
				gfx.monster.text = monster.name;
			} else {
				drawNextCard();
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
			var nextCard:GuiCard = new GuiCard(card);
			gfx.nextCard.addChild(nextCard);
			
			if (percentCardsDrawn < 0.20) {
				MusicPlayer.playMusic(MusicPlayer.ORCHESTRAAAL);
			} else if (percentCardsDrawn < 0.40) {
				MusicPlayer.playMusic(MusicPlayer.DRUMS);
			} else if (percentCardsDrawn < 0.60) {
				MusicPlayer.playMusic(MusicPlayer.STAMPEDE);
			} else if (percentCardsDrawn < 0.70) {
				MusicPlayer.playMusic(MusicPlayer.LULLABY);
			} else {
				MusicPlayer.playMusic(MusicPlayer.RACIST);
			}
			cardsDrawn++;
		}
		
		protected function get percentCardsDrawn():Number
		{
			return cardsDrawn / (Config.NUM_SLOTS - Config.NUM_PLOTPOINTS);
		}
		
		public function isNextCard(card:GuiCard):Boolean
		{
			if (gfx.nextCard.numChildren == 0) {
				return false;
			}
			return gfx.nextCard.getChildAt(0) == card;
		}
		
		public function setEndingMonsterName(value:String):void
		{
			gfx.monster.text = value;
		}
		
		/** fills a slot; either a GuiCard or a GfxEvent */
		protected var actions:Vector.<*> = new Vector.<*>();
		
		protected var stats:Vector.<GfxStat> = new Vector.<GfxStat>();
		
		protected var gfx:GfxGui;
		public var timeline:GuiTimeline;
		protected var cardsDrawn:int = 0;
		protected var animationTick:int = 0;
		
		protected var mainMenu:GuiMainMenu;
		
		public static var instance:Gui;
	}
}