package com.thegiants.cyclope.game.screens 
{
	import com.thegiants.cyclope.game.events.NavigationEvent;
	import com.thegiants.cyclope.game.screens.interfaces.IScreen;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	/**
	 * @author nico
	 */
	public class WelcomeScreen extends Sprite implements IScreen
	{
		private var playButton:Button;
		
		public function WelcomeScreen() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			trace("welcome screen initialized");
			
			playButton = new Button(Texture.empty());
			playButton.x = (stage.stageWidth - playButton.width) >> 1;
			playButton.y = (stage.stageHeight - playButton.height) >> 1;
			addChild(playButton);
			
			addEventListener(Event.TRIGGERED, onMenuClick);
		}
		
		private function onMenuClick(e:Event):void 
		{
			var buttonClicked : Button = (e.target as Button);
			if ( buttonClicked == playButton ) 
			{
				dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, { id : "play" }, true) );
			}
		}
		
		public function initialize():void
		{
			visible = true;
		}
		
		public function disposeTemporarily():void 
		{
			visible = false;
			
			// TODO remove event listeners
		}
	}
}