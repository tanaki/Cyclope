package com.thegiants.cyclope.game.screens 
{
	import com.nicolaspigelet.utils.MathUtils;
	import com.thegiants.cyclope.game.components.characters.Cyclope;
	import com.thegiants.cyclope.game.components.characters.Human;
	import com.thegiants.cyclope.game.components.scenery.Ground;
	import com.thegiants.cyclope.game.components.scenery.Tree;
	import com.thegiants.cyclope.game.screens.interfaces.IScreen;
	import flash.display.BitmapData;
	import starling.display.BlendMode;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.textures.Texture;
	
	/**
	 * @author nico
	 */
	public class GameScreen extends Sprite implements IScreen
	{
		
		private var 
			trees : Vector.<Tree>,
			bmp : BitmapData,
			image : Image,
			texture : Texture;
		
		public function GameScreen() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			trace("game screen initialized");
			// addEventListener(TouchEvent.TOUCH, onTouch);
			
			initGraphics();
		}
		
		private function initGraphics():void {
			
			// add cyclope
			var cyclope : Cyclope = new Cyclope();
			cyclope.x = (stage.stageWidth) >> 1;
			cyclope.y = 50 + (cyclope.height >> 1);
			addChild(cyclope);
			
			// add ground
			var ground : Ground = new Ground();
			ground.x = (stage.stageWidth) >> 1;
			ground.y = 314;
			addChild(ground);
			
			// add random trees
			trees = new Vector.<Tree>();
			for ( var i : int = 0; i < 8; i++ ) {
				var tree : Tree = new Tree();
				tree.x = i * 100 + 50;
				tree.y = MathUtils.randomRange(310, 350);
				trees.push(tree);
				addChild(tree);
			}
			
			// add human
			for ( var j : int = 0; j < 3; j++ ) {
				var human : Human = new Human();
				var currentTree : Tree = trees[j*2];
				human.x = currentTree.x;
				human.y = currentTree.y + (currentTree.height - human.height >> 1 );
				addChild(human);
			}
			
			bmp = new BitmapData(800, 480, true, 0x000000);
			texture = Texture.fromBitmapData(bmp);
			image = new Image(texture);
			// image.blendMode = BlendMode.NONE;
			
			addChild(image);
		}
		
		private function onTouch(e:TouchEvent):void 
		{
			/*
			var touch:Touch = e.getTouch(this, TouchPhase.MOVED);
			if (touch)
			{
				var localPos:Point = touch.getLocation(this);
				
				if ( path ) {
					path.graphics.lineTo( localPos.x, localPos.y );
				} else {					
					path = new Shape();
					path.graphics.lineStyle(2, 0xffffff);
					path.graphics.moveTo( localPos.x, localPos.y );
				}
				
				bmp.draw(path);
				texture = Texture.fromBitmapData(bmp);
				image.texture = texture;
			}
			*/
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