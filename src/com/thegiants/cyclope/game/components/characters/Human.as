package com.thegiants.cyclope.game.components.characters 
{
	import aze.motion.eaze;
	import com.thegiants.cyclope.game.assets.Assets;
	import com.thegiants.cyclope.game.components.interfaces.ICharacter;
	import com.thegiants.cyclope.game.components.interfaces.IHiddable;
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
		private var _hiddableIndex : int = 0;
		
		public function Human() 
		{
			initGraphics();
		}
		
		private function initGraphics():void 
		{
			var s : Shape = new Shape();
			s.graphics.beginFill(0x666666, .1);
			s.graphics.drawCircle( 40, 40, 40);
			
			var bmp : BitmapData = new BitmapData(80, 80, true, 0xff9900);
			bmp.draw(s);
			var t2 : Texture = Texture.fromBitmapData(bmp);
			var img2 : Image = new Image(t2);
			img2.x = -40;
			img2.y = -40;
			addChild(img2);
			
			var textures : Vector.<Texture> = Assets.getAtlas().getTextures("human");
			var mc : MovieClip = new MovieClip(textures);
			mc.x = Math.ceil( -mc.width >> 1 );
			mc.y = Math.ceil( -mc.height >> 1 );
			addChild(mc);
			
		}
		
		public function move ( x:Number, y:Number, duration : Number = 0 ): void 
		{
			eaze(this).to( duration, { x : x, y : y } );
		}
		
		public function get hiddableIndex():int 
		{
			return _hiddableIndex;
		}
		
		public function set hiddableIndex(value:int):void 
		{
			_hiddableIndex = value;
		}
	}

}