package com.thegiants.cyclope.game.screens 
{
	import com.thegiants.cyclope.game.screens.interfaces.IScreen;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	
	/**
	 * @author nico
	 */
	public class LevelScreen extends Sprite implements IScreen
	{
		private var 
			_level : int = 0,
			levelTF:TextField;
		
		public function LevelScreen() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			trace("screen level init");
			
			levelTF = new TextField(400, 50, "Level " + _level, "Verdana", 24, 0xffffff);
			levelTF.hAlign = HAlign.CENTER;
			levelTF.x = 200;
			levelTF.y = 80;
			addChild(levelTF);
		}
		
		public function initialize():void
		{
			trace("screen level show");
			visible = true;
			
			// TODO add event listeners
		}
		
		public function disposeTemporarily():void 
		{
			visible = false;
			
			// TODO remove event listeners
		}
		
		public function get level():int 
		{
			return _level;
		}
		
		public function set level(value:int):void 
		{
			_level = value;
			levelTF.text = "Level " + _level;
		}
		
	}

}