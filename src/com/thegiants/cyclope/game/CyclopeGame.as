package com.thegiants.cyclope.game 
{
	import com.thegiants.cyclope.game.events.NavigationEvent;
	import com.thegiants.cyclope.game.screens.GameScreen;
	import com.thegiants.cyclope.game.screens.LevelScreen;
	import com.thegiants.cyclope.game.screens.WelcomeScreen;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	/**
	 * @author nico
	 */
	public class CyclopeGame extends Sprite 
	{
		private var 
			screenWelcome : WelcomeScreen,
			screenGame : GameScreen,
			screenLevel : LevelScreen;
		
		public function CyclopeGame() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			addEventListener(NavigationEvent.CHANGE_SCREEN, onChangeScreen);
			
			screenGame = new GameScreen();
			addChild(screenGame);
			screenGame.disposeTemporarily();
			
			screenLevel = new LevelScreen();
			addChild(screenLevel);
			screenLevel.disposeTemporarily();
			//screenLevel.initialize();
			
			screenWelcome = new WelcomeScreen();
			addChild(screenWelcome);
			//screenWelcome.disposeTemporarily();
			screenWelcome.initialize();
		}
		
		private function onChangeScreen(e:NavigationEvent):void 
		{
			switch( e.params.id ) {
				
				case "play" : 
					screenWelcome.disposeTemporarily();
					screenLevel.disposeTemporarily();
					screenGame.initialize();
					break;
				case "level" :
					screenGame.disposeTemporarily();
					screenLevel.level = int(e.params.level);
					screenLevel.initialize();
					break;
			}
		}
		
	}

}