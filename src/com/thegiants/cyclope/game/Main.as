package com.thegiants.cyclope.game
{
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.text.TextField;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import starling.core.Starling;
	
	/**
	 * @author nico
	 */
	public class Main extends Sprite 
	{
		private var _starling:Starling;
		
		public function Main():void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			// touch or gesture?
			Starling.multitouchEnabled = true;
			Starling.handleLostContext = true;
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			// init Starling
			_starling = new Starling(CyclopeGame, stage);
			_starling.simulateMultitouch = true;
			_starling.showStats = true;
			_starling.antiAliasing = 1;
			_starling.start();
			
		}
		
		private function deactivate(e:Event):void 
		{
			// auto-close
			NativeApplication.nativeApplication.exit();
		}
		
	}
	
}