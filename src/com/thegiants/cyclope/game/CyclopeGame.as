package com.thegiants.cyclope.game 
{
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
		private var screenWelcome : WelcomeScreen;
		
		public function CyclopeGame() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			screenWelcome = new WelcomeScreen();
			addChild(screenWelcome);
		}
		
	}

}