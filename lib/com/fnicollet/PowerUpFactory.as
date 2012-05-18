package com.fnicollet {
  import flash.display.Bitmap;

  import starling.display.MovieClip;
  import starling.textures.Texture;
  import starling.textures.TextureAtlas;

  public class PowerUpFactory {

    [Embed(source = "/assets/spritesheet/moneyfoodshells.png")]
    private static const moneyfoodshells_imageSpriteSheet:Class;
    [Embed(source = "/assets/atlas/moneyfoodshells.xml", mimeType = "application/octet-stream")]
    private static const moneyfoodshells_atlas:Class;
    private static var moneyfoodshells_bitmap:Bitmap = Bitmap(new moneyfoodshells_imageSpriteSheet());

    private static var moneyfoodshells_textureAtlas:TextureAtlas = null;

    public static const COIN_IRON:String = "COIN_IRON";
    public static const COIN_GOLD:String = "COIN_GOLD";
    public static const STAR_GOLD:String = "STAR_GOLD";
    public static const SCARAB_GOLD:String = "SCARAB_GOLD";
    public static const POTION:String = "POTION";
    public static const POTATO:String = "POTATO";
    public static const PILL:String = "PILL";
    public static const GREEN_PILL:String = "GREEN_PILL";
    public static const ROCK:String = "ROCK";
    public static const SHELL_GREY:String = "SHELL_GREY";
    public static const SHELL_GOLD:String = "SHELL_GOLD";
    public static const SHELL_ROCK:String = "SHELL_ROCK";

    public static const CACHE_ID:String = "POWERUPS";

    public function PowerUpFactory() {
    }

    private static function init():void {
      if (!moneyfoodshells_textureAtlas) {
        moneyfoodshells_textureAtlas = new TextureAtlas(Texture.fromBitmap(moneyfoodshells_bitmap), XML(new moneyfoodshells_atlas()));
        BitmapDataCacher.cacheBitmap(CACHE_ID, moneyfoodshells_bitmap, XML(new moneyfoodshells_atlas()));
      }
    }

    public static function get(id:String):MovieClip {
      init();
      var ret:MovieClip = new MovieClip(moneyfoodshells_textureAtlas.getTextures(id));
      ret.name = id;
      return ret;
    }

    public static function getRandom():MovieClip {
      var ids:Array = [COIN_IRON, COIN_GOLD, STAR_GOLD, SCARAB_GOLD, POTION, POTATO, PILL, GREEN_PILL, ROCK, SHELL_GREY, SHELL_GOLD, SHELL_ROCK];
      var randomId:String = ids[Math.floor(Math.random() * ids.length)];
      return get(randomId);
    }

  }
}
