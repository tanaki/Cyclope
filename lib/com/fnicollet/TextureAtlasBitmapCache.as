package com.fnicollet
{
  import starling.textures.Texture;
  import starling.textures.TextureAtlas;
  
  public class TextureAtlasBitmapCache extends TextureAtlas
  {
    public function TextureAtlasBitmapCache(texture:Texture, atlasXml:XML=null)
    {
      super(texture, atlasXml);
    }
  }
}