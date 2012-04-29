package com.thegiants.cyclope.game.screens 
{
	import com.thegiants.cyclope.game.screens.interfaces.IScreen;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * @author nico
	 */
	public class GameOverScreen extends Sprite implements IScreen
	{
		
		public function GameOverScreen() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
		}
		
		public function initialize():void
		{
			visible = true;
			
			// TODO add event listeners
		}
		
		public function disposeTemporarily():void 
		{
			visible = false;
			
			// TODO remove event listeners
		}
		
	}

}