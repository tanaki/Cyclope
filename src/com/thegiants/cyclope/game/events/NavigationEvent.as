package com.thegiants.cyclope.game.events 
{
	import starling.events.Event;
	
	/**
	 * @author nico
	 */
	public class NavigationEvent extends Event 
	{
		public static const CHANGE_SCREEN : String = "navigation/changeScreen";
		
		public var params : Object;
		
		public function NavigationEvent(type:String, _params : Object = null, bubbles:Boolean = false) 
		{ 
			super(type, bubbles);
			params = _params;
		} 
		
	}
	
}