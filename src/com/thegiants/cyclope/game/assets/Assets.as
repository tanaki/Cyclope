package com.thegiants.cyclope.game.assets 
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	/**
	 * @author nico
	 */
	public class Assets 
	{
		// TODO Define Assets here
		
		
		private static var gameTextures : Dictionary = new Dictionary();
		private static var gameTextureAtlas : TextureAtlas;
		
		// TODO Define TextureAtlas here
		
		public static function getAtlas () : TextureAtlas
		{
			
		}
		
		public static function getTexture ( name : String ) : Texture
		{
			if ( gameTextures[name] == undefined )
			{
				var bitmap : Bitmap = new Assets[name]();
				gameTextures[name] = Texture.fromBitmap(bitmap);
			}
			return gameTextures[name];
		}
		
	}

}