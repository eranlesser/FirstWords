package com
{
	import flash.geom.Point;
	import com.IDestroyable;

	public interface ILocalalbe extends IDestroyable
	{
		function get location():Point;
		function set location(loc:Point):void;
	}
}