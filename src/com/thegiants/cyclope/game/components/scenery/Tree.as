package com.thegiants.cyclope.game.components.scenery 
{
	import com.thegiants.cyclope.game.assets.Assets;
	import com.thegiants.cyclope.game.components.interfaces.IHiddable;
	import com.thegiants.cyclope.game.components.interfaces.IScenery;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	/**
	 * @author nico
	 */
	public class Tree extends Sprite implements IScenery, IHiddable 
	{
		
		public function Tree() 
		{
			initGraphics();
		}
		
		private function initGraphics():void 
		{
			
			var texture : Texture = Assets.getAtlas().getTexture("tree");
			var image : Image = new Image(texture);
			image.x = Math.ceil( -image.width >> 1 );
			image.y = Math.ceil( -image.height >> 1 );
			
			var hideArea : Shape = new Shape();
			hideArea.graphics.beginFill(0x000000);
			hideArea.graphics.drawRoundRect(0, 0, image.width, image.height * 1.5, 40, 40);
			
			var bmpHideArea : BitmapData = new BitmapData(hideArea.width, hideArea.height, true, 0xff9900);
			bmpHideArea.draw(hideArea);
			var textureHideArea : Texture = Texture.fromBitmapData(bmpHideArea);
			var imageHideArea : Image = new Image(textureHideArea);
			imageHideArea.x = image.x;
			imageHideArea.y = image.y;
			
			addChild(imageHideArea);
			addChild(image);
		}
		
	}

}