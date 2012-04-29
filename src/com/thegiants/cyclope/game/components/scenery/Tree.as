package com.thegiants.cyclope.game.components.scenery 
{
	import com.thegiants.cyclope.game.assets.Assets;
	import com.thegiants.cyclope.game.components.interfaces.IHiddable;
	import com.thegiants.cyclope.game.components.interfaces.IScenery;
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
			addChild(image);
		}
		
	}

}