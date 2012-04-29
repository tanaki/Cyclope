package com.thegiants.cyclope.game.components.characters 
{
	import com.thegiants.cyclope.game.assets.Assets;
	import com.thegiants.cyclope.game.components.interfaces.ICharacter;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	/**
	 * @author nico
	 */
	public class Cyclope extends Sprite implements ICharacter 
	{
		
		public function Cyclope() 
		{
			initGraphics();
		}
		
		private function initGraphics():void 
		{
			var texture : Texture = Assets.getAtlas().getTexture("cyclope");
			var image : Image = new Image(texture);
			image.x = Math.ceil( -image.width >> 1 );
			image.y = Math.ceil( -image.height >> 1 );
			addChild(image);
		}
		
	}

}