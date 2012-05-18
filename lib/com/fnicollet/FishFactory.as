package com.fnicollet {
  import flash.display.Bitmap;

  import starling.display.Sprite;
  import starling.textures.Texture;
  import starling.textures.TextureAtlas;

  public class FishFactory {

    [Embed(source = "/assets/spritesheet/mediumguppy.png")]
    private static const mediumguppy_imageSpriteSheet:Class;
    [Embed(source = "/assets/atlas/mediumguppy.xml", mimeType = "application/octet-stream")]
    private static const mediumguppy_atlas:Class;
    private static var mediumguppy_bitmap:Bitmap = Bitmap(new mediumguppy_imageSpriteSheet());

    private static var mediumguppy_textureAtlas:TextureAtlas = null;

    public static const CACHE_ID:String = "FISH";

    public function FishFactory() {
    }

    private static function init():void {
      if (!mediumguppy_textureAtlas) {
        mediumguppy_textureAtlas = new TextureAtlas(Texture.fromBitmap(mediumguppy_bitmap), XML(new mediumguppy_atlas()));
        BitmapDataCacher.cacheBitmap(CACHE_ID, mediumguppy_bitmap, XML(new mediumguppy_atlas()));
      }
    }

    public static function getFish(id:String):Sprite {
      init();
      var ret:Sprite = new FishBase(mediumguppy_textureAtlas, id);
      ret.name = id;
      return ret;
    }

  }
}
