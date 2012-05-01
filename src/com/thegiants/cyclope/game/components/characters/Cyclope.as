package com.thegiants.cyclope.game.components.characters 
{
	import com.thegiants.cyclope.game.assets.Assets;
	import com.thegiants.cyclope.game.components.interfaces.ICharacter;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
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
			var textures : Vector.<Texture> = Assets.getAtlas().getTextures("cyclope");
			var mc : MovieClip = new MovieClip(textures);
			mc.x = Math.ceil( -mc.width >> 1 );
			mc.y = Math.ceil( -mc.height >> 1 );
			addChild(mc);
		}
		
	}

}