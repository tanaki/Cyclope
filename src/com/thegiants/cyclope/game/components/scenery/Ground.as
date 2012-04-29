package com.thegiants.cyclope.game.components.scenery 
{
	import com.thegiants.cyclope.game.assets.Assets;
	import com.thegiants.cyclope.game.components.interfaces.IScenery;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	/**
	 * @author nico
	 */
	public class Ground extends Sprite implements IScenery 
	{
		
		public function Ground() 
		{
			initGraphics();
		}
		
		private function initGraphics():void 
		{
			var texture : Texture = Assets.getAtlas().getTexture("ground");
			var image : Image = new Image(texture);
			image.x = Math.ceil( -image.width >> 1 );
			image.y = Math.ceil( -image.height >> 1 );
			addChild(image);
		}
		
	}

}