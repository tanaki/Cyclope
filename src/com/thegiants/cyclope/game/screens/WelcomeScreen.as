package com.thegiants.cyclope.game.screens 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Point;
	import starling.display.BlendMode;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	/**
	 * @author nico
	 */
	public class WelcomeScreen extends Sprite 
	{
		private var 
			path : Shape,
			bmp : BitmapData,
			texture : Texture,
			image : Image;
		
		public function WelcomeScreen() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			trace("welcome screen initialized");
			addEventListener(TouchEvent.TOUCH, onTouch);
			
			bmp = new BitmapData(800, 480, true, 0x000000);
			texture = Texture.fromBitmapData(bmp);
			image = new Image(texture);
			image.blendMode = BlendMode.NONE;
			
			addChild(image);
		}
		
		private function onTouch(e:TouchEvent):void 
		{
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
		}	
	}
}