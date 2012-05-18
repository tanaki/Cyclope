package com.fnicollet {
  import flash.display.BitmapData;
  import flash.geom.Point;
  import flash.ui.Keyboard;

  import starling.animation.Transitions;
  import starling.animation.Tween;
  import starling.core.Starling;
  import starling.display.DisplayObject;
  import starling.display.Image;
  import starling.display.MovieClip;
  import starling.display.Sprite;
  import starling.events.Event;
  import starling.events.KeyboardEvent;
  import starling.events.Touch;
  import starling.events.TouchEvent;
  import starling.events.TouchPhase;
  import starling.textures.Texture;

  import ws.tink.display.HitTest;

  public class AquariumScreen extends Sprite {

    public function AquariumScreen() {
      super();
      addEventListener(Event.ADDED_TO_STAGE, init);
    }

    private var isRight:Boolean = false;
    private var isLeft:Boolean = false;
    private var isUp:Boolean = false;
    private var isDown:Boolean = false;
    private var _xSpeed:Number = 0;
    private var _ySpeed:Number = 0;
    private var _power:Number = 0.3;
    private var _maxSpeed:Number = 4;
    private var _inertia:Number = 0.95;

    private var _fish:Sprite;

    private var _powerUps:Array = [];

    private var _detectCollisions:Boolean = true;

    private function init(event:Event):void {
      removeEventListener(Event.ADDED_TO_STAGE, init);

      _fish = FishFactory.getFish("GUPPY_O_");
      addChild(_fish);
      _fish.x = 400;
      _fish.y = 0;
      /*
      moveFish(movieClip);
      addEventListener(TouchEvent.TOUCH, onTouchEvent);
      var movieClip:MovieClip = PowerUpFactory.getRandom();
      Starling.juggler.add(movieClip);
      addChild(movieClip);
      */
      stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
      stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
      stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
    }

    private function onKeyDown(event:KeyboardEvent):void {
      switchKey(event, true);
    }

    private function onKeyUp(event:KeyboardEvent):void {
      switchKey(event, false);
    }

    private function switchKey(event:KeyboardEvent, value:Boolean):void {
      var keyCode:uint = event.keyCode;
      switch (keyCode) {
        case Keyboard.RIGHT:
          isRight = value;
          break;
        case Keyboard.LEFT:
          isLeft = value;
          break;
        case Keyboard.UP:
          isUp = value;
          break;
        case Keyboard.DOWN:
          isDown = value;
          break;
        default:
          break;
      }
    }

    private function onEnterFrame(event:Event):void {
      if (isRight) {
        _xSpeed += _power;
      }
      if (isLeft) {
        _xSpeed -= _power;
      }
      if (isUp) {
        _ySpeed -= _power;
      }
      if (isDown) {
        _ySpeed += _power;
      }
      if (_xSpeed > _maxSpeed) {
        _xSpeed = _maxSpeed;
      } else if (_xSpeed < -_maxSpeed) {
        _xSpeed = -_maxSpeed;
      }
      if (_ySpeed > _maxSpeed) {
        _ySpeed = _maxSpeed;
      } else if (_ySpeed < -_maxSpeed) {
        _ySpeed = -_maxSpeed;
      }

      _xSpeed *= _inertia;
      _ySpeed *= _inertia;

      _fish.x += _xSpeed;
      _fish.y += _ySpeed;

      // managing the walls
      if (_fish.x < 0 && _xSpeed < 0) {
        _fish.x = 0
      }
      var xLimit:Number = stage.stageWidth - _fish.width;
      var yLimit:Number = stage.stageHeight - _fish.height;
      if (_fish.x > xLimit && _xSpeed > 0) {
        _fish.x = xLimit;
      }
      if (_fish.y < 0 && _ySpeed < 0) {
        _fish.y = 0
      }
      if (_fish.y > yLimit && _ySpeed > 0) {
        _fish.y = yLimit;
      }
      // collisions
      if (_detectCollisions) {
        var powerUpsLength:int = _powerUps.length;
        for (var i:int = powerUpsLength - 1; i >= 0; i--) {
          var powerUp:MovieClip = MovieClip(_powerUps[i]);
          var collide:Boolean = _fish.getBounds(_fish.parent).intersects(powerUp.getBounds(powerUp.parent));
          if (collide) {
            var target1BitmapData:BitmapData = BitmapDataCacher.getBitmapData(FishFactory.CACHE_ID, _fish.name, FishBase(_fish).movieClip.currentFrame);
            var target2BitmapData:BitmapData = BitmapDataCacher.getBitmapData(PowerUpFactory.CACHE_ID, powerUp.name, powerUp.currentFrame);
            var reallyCollide:Boolean = HitTest.complexHitTestObject(_fish, target1BitmapData, powerUp, target2BitmapData);
            if (reallyCollide) {
              removePowerUp(powerUp);
            }
          }
        }
      }
      // power-ups
      if (Math.random() < 0.03) {
        // 40 = marge à droite
        var positionX:Number = Math.random() * (stage.stageWidth - 60);
        var movieClip:MovieClip = PowerUpFactory.getRandom();
        movieClip.x = positionX;
        // démarrer off-screen
        movieClip.y = -100;
        Starling.juggler.add(movieClip);
        addChild(movieClip);
        _powerUps.push(movieClip);
        // tween
        const MINIMUM_DURATION:Number = 1.5;
        var duration:Number = Math.max(Math.random() * 6, MINIMUM_DURATION);
        var t:Tween = new Tween(movieClip, duration);
        t.onComplete = onPowerUpMoveComplete;
        t.onCompleteArgs = [movieClip];
        t.animate("y", stage.stageHeight + 100);
        Starling.juggler.add(t);
      }
    }

    private function onPowerUpMoveComplete(movieClip:MovieClip):void {
      removePowerUp(movieClip);
    }

    private function removePowerUp(p:DisplayObject):void {
      var idx:int = _powerUps.indexOf(p);
      if (idx > -1) {
        _powerUps.splice(idx, 1);
      }
      p.removeFromParent();
    }

    private function onTouchEvent(event:TouchEvent):void {
      var touch:Touch = event.getTouch(stage);
      var pos:Point = touch.getLocation(stage);
      if (touch.phase == TouchPhase.ENDED) {
        var target:MovieClip = touch.target as MovieClip;
        if (target && target.parent is FishBase) {
          var states:Array = [FishBase.DIE, FishBase.EAT, FishBase.SWIM, FishBase.TURN];
          var idx:int = Math.floor(Math.random() * states.length);
          FishBase(target.parent).currentState = states[idx];
        }
      }
    }

    private function moveFish(movieClip:Sprite, direction:String = "left"):void {
      var t:Tween = new Tween(movieClip, 4, Transitions.EASE_IN_OUT);
      t.onComplete = moveFish;
      var nextPosition:Number = 0;
      var nextDirection:String = "left";
      if (direction == "left") {
        nextDirection = "right";
        movieClip.scaleX = -1;
        movieClip.x = movieClip.width;
        nextPosition = 400;
      } else {
        nextDirection = "left";
        movieClip.x = 400 - movieClip.width;
        movieClip.scaleX = 1;
        nextPosition = 0;
      }
      t.moveTo(nextPosition, movieClip.y);
      t.onCompleteArgs = [movieClip, nextDirection];
      Starling.juggler.add(t);
    }

  }
}
