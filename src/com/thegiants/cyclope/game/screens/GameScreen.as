package com.thegiants.cyclope.game.screens 
{
	import aze.motion.easing.Linear;
	import aze.motion.eaze;
	import com.nicolaspigelet.utils.MathUtils;
	import com.thegiants.cyclope.game.components.characters.Cyclope;
	import com.thegiants.cyclope.game.components.characters.Human;
	import com.thegiants.cyclope.game.components.interfaces.IHiddable;
	import com.thegiants.cyclope.game.components.scenery.Ground;
	import com.thegiants.cyclope.game.components.scenery.Tree;
	import com.thegiants.cyclope.game.screens.interfaces.IScreen;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Point;
	import starling.display.BlendMode;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.deg2rad;
	import starling.utils.HAlign;
	
	/**
	 * @author nico
	 */
	public class GameScreen extends Sprite implements IScreen
	{
		
		private var 
			_score : int = 0,
			scoreTF : TextField,
			path : Shape,
			bmp : BitmapData,
			image : Image,
			texture : Texture,
			
			initPoint : Point,
			imageDangerZone:Image,
			trees : Vector.<Tree>,
			humans : Vector.<Human>;
		
		public function GameScreen() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			trace("game screen initialized");
			addEventListener(TouchEvent.TOUCH, onTouch);
			
			initGraphics();
		}
		
		private function initGraphics():void {
			
			// add cyclope
			var cyclope : Cyclope = new Cyclope();
			cyclope.x = (stage.stageWidth) >> 1;
			cyclope.y = 50 + (cyclope.height >> 1);
			this.addChild(cyclope);
			
			// add ground
			var ground : Ground = new Ground();
			ground.x = (stage.stageWidth) >> 1;
			ground.y = 314;
			this.addChild(ground);
			
			// add danger zone
			var 
				dangerZone : Shape = new Shape(),
				initDangerX : Number = cyclope.x,
				initDangerY : Number = cyclope.y;
				
			dangerZone.graphics.beginFill(0xff0099, .3);
			dangerZone.graphics.moveTo( 80, 0 );
			dangerZone.graphics.lineTo( 160, 500 );
			dangerZone.graphics.lineTo( 0, 500 );
			dangerZone.graphics.lineTo( 80, 0 );
			
			var bmpDangerZone : BitmapData = new BitmapData(dangerZone.width, dangerZone.height, true, 0xff0099);
			bmpDangerZone.draw(dangerZone);
			var textureDangerZone : Texture = Texture.fromBitmapData(bmpDangerZone);
			imageDangerZone = new Image(textureDangerZone);
			imageDangerZone.x = cyclope.x - 10;
			imageDangerZone.y = cyclope.y + 80;
			imageDangerZone.pivotX = 80;
			imageDangerZone.rotation = deg2rad(80);
			addChild(imageDangerZone);
			rotateRight();
			
			// add random trees
			trees = new Vector.<Tree>();
			for ( var i : int = 0; i < 7; i++ ) {
				var tree : Tree = new Tree();
				tree.x = i * 100 + 80;
				tree.y = MathUtils.randomRange(310, 350);
				trees.push(tree);
				this.addChild(tree);
			}
			
			// add human
			humans = new Vector.<Human>();
			for ( var j : int = 0; j < 3; j++ ) {
				var human : Human = new Human();
				var currentTree : Tree = trees[0];
				human.hiddableIndex = 0;
				human.move( currentTree.x, currentTree.y + (currentTree.height * .3) );
				humans.push(human);
				this.addChild(human);
			}
			
			scoreTF = new TextField(50, 40, "0", "Verdana", 24, 0xffffff);
			scoreTF.hAlign = HAlign.RIGHT;
			scoreTF.x = stage.stageWidth - scoreTF.width;
			addChild(scoreTF);
		}
		
		private function rotateRight():void 
		{
			eaze(imageDangerZone).to( 5, { rotation : deg2rad(-80) }).easing(Linear.easeNone).onComplete(rotateLeft);
		}
		
		private function rotateLeft():void 
		{
			eaze(imageDangerZone).to( 5, { rotation : deg2rad(80) }).easing(Linear.easeNone).onComplete(rotateRight);
		}
		
		private function onTouch(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(this);
			
			if (touch)
			{
				var localPos:Point = touch.getLocation(this);
				switch ( touch.phase ) {
					case TouchPhase.BEGAN :
						if ( touch.target.parent is Human ) {
							initPoint = localPos;
						}
						break;
					case TouchPhase.ENDED :
						if ( touch.target.parent is Human ) {
							var deltaX : Number = localPos.x - initPoint.x;
							if ( deltaX > 0 ) {
								var touchedHuman : Human = Human(touch.target.parent);
								touchedHuman.hiddableIndex += 1;
								
								if ( touchedHuman.hiddableIndex < trees.length ) {
									var closerHiddable : Tree = trees[touchedHuman.hiddableIndex];
									touchedHuman.move( closerHiddable.x, closerHiddable.y + (closerHiddable.height >> 1), 0.5 );
								} else if ( touchedHuman.hiddableIndex == trees.length ) {
									touchedHuman.move( stage.stageWidth + touchedHuman.width, touchedHuman.y, 0.5 );
									score++;
								}
							}
						}
						break;
				}
				
			}
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
		
		public function get score():int 
		{
			return _score;
		}
		
		public function set score(value:int):void 
		{
			_score = value;
			scoreTF.text = _score.toString();
		}
	}

}