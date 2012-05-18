package com.thegiants.cyclope.game.components.characters 
{
	import aze.motion.eaze;
	import com.fnicollet.BitmapDataCacher;
	import com.thegiants.cyclope.game.assets.Assets;
	import com.thegiants.cyclope.game.components.interfaces.ICharacter;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	/**
	 * @author nico
	 */
	public class Human extends Sprite implements ICharacter
	{
		
		private var 
			_hiddableIndex : int = 0,
			_vulnerable : Boolean =  false,
			_bitmapData:BitmapData;
		
		public function Human() 
		{
			initGraphics();
		}
		
		private function initGraphics():void 
		{
			var humanShape : Shape = new Shape();
			humanShape.graphics.beginFill(0x666666, .1);
			humanShape.graphics.drawCircle( 40, 40, 40);
			
			var humanBmp : BitmapData = new BitmapData(80, 80, true, 0xff9900);
			humanBmp.draw(humanShape);
			var humanTexture : Texture = Texture.fromBitmapData(humanBmp);
			var humanImage : Image = new Image(humanTexture);
			humanImage.x = -40;
			humanImage.y = -40;
			addChild(humanImage);
			
			var textures : Vector.<Texture> = Assets.getAtlas().getTextures("human");
			var mc : MovieClip = new MovieClip(textures);
			mc.x = Math.ceil( -mc.width >> 1 );
			mc.y = Math.ceil( -mc.height >> 1 );
			addChild(mc);
			
			BitmapDataCacher.cacheBitmap("human", Bitmap(new Assets.AtlasTexture()), XML(new Assets.AtlasXml()) );
		}
		
		public function move ( x:Number, y:Number, duration : Number = 0 ): void 
		{
			eaze(this)
				.to( duration, { x : x, y : y } )
				.onStart(setVulnerable, true)
				.onComplete(setVulnerable, false);
		}
		
		public function setVulnerable (value:Boolean):void 
		{
			_vulnerable = value;
		}
		
		public function get hiddableIndex():int 
		{
			return _hiddableIndex;
		}
		
		public function set hiddableIndex(value:int):void 
		{
			_hiddableIndex = value;
		}
		
		public function get vulnerable():Boolean 
		{
			return _vulnerable;
		}
		
		public function getBitmapData():BitmapData 
		{
			return _bitmapData;
		}
	}

}