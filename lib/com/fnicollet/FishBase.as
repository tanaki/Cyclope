package com.fnicollet {
  import starling.core.Starling;
  import starling.display.MovieClip;
  import starling.display.Sprite;
  import starling.textures.Texture;
  import starling.textures.TextureAtlas;

  public class FishBase extends Sprite {

    public static const SWIM:String = "SWIM";
    public static const EAT:String = "EAT";
    public static const TURN:String = "TURN";
    public static const DIE:String = "DIE";

    private var _currentState:String = null;

    public function get currentState():String {
      return _currentState;
    }

    public function set currentState(value:String):void {
      var textures:Vector.<Texture> = getStateTextures(value);
      if (!textures || textures.length < 1) {
        trace("Impossible state : " + value);
        return;
      }
      createMovieClip(value);
      _currentState = value;
    }

    private var _atlas:TextureAtlas = null;

    private var _prefix:String = null;

    private var _movieClip:MovieClip = null;

    public function get movieClip():MovieClip {
      return _movieClip;
    }


    public function FishBase(atlas:TextureAtlas, prefix:String) {
      _atlas = atlas;
      _prefix = prefix;
      createMovieClip(SWIM);
    }

    protected function createMovieClip(state:String):void {
      if (contains(_movieClip)) {
        removeChild(_movieClip);
      }
      _movieClip = new MovieClip(getStateTextures(state));
      addChild(_movieClip);
      Starling.juggler.add(_movieClip);
    }

    protected function getStateTextures(state:String):Vector.<Texture> {
      return _atlas.getTextures(_prefix + state);
    }

  }
}
