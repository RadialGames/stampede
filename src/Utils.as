package
{
	import adobe.utils.CustomActions;
	import flash.display.Stage;
    import flash.utils.getDefinitionByName;
    import flash.utils.getQualifiedClassName;
	import com.gskinner.utils.Rndm;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Transform;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import gui.*;
	
	/**
	 * Static class with string and randomness utility functions used by many classes.
	 * From Rebuild 3
	 *
	 * @author Sarah Northway
	 */
	public class Utils
	{
		/**
		 * Done once when the fort is created.
		 */
		public static function pickOriginalRandomSeed():void
		{
			if (Config.NONRANDOM_SEED >= 0) {
				Rndm.originalSeed = Config.NONRANDOM_SEED;
			} else {
				// leave a 0 at the start because we will add 1000 for every day
				Rndm.originalSeed = Math.random() * 0x0FFFFF;
			}
			Utils.log("random seed set to " + Rndm.originalSeed);
		}
		
		/**
		 * One random seed per fort.
		 */
		public static function get originalRandomSeed():uint
		{
			return Rndm.originalSeed;
		}
		
		/**
		 * Set a random seed when a new fort is created or loaded.
		 */
		public static function set originalRandomSeed(value:uint):void
		{
			Rndm.originalSeed = value;
		}
		
		/**
		 * Set a random seed before performing end day calculations. Set often, never saved.
		 */
		public static function set currentRandomSeed(value:uint):void
		{
			Rndm.currentSeed = value;
		}
		
		/**
		 * Returns true numerator/denominator of the time, and false the rest of the time
		 * @param acrossDays If > 1, calculate the chance as if it were being run every day for
		 * 		  acrossDays days, with total chance equalling num/denom.
		 */
		public static function getRandChance(numerator:Number, denominator:Number, acrossDays:int = 1):Boolean
		{
			if (isNaN(numerator) || isNaN(denominator)) {
				Utils.logError("NaN in getRandChance, num: " + numerator + ", denom: " + denominator);
				if (Config.DEBUG_MODE) {
					throw new Error("NaN in getRandChance");
				}
				return false;
			}
			if (denominator <= 0) {
				Utils.logError("Denominator is zero in Utils.getRandChance");
				return false;
			}
			
			var randomNumber:Number = Rndm.random(); // between 0 and 1
			var chance:Number = numerator / denominator; // between 0 and very large
			
			// 1 - (1 - chancePerDay) ^ days = totalChance
			// 1 - (1 - totalChance) ^ (1/days) = chancePerDay
			if (acrossDays > 1) {
				chance = 1 - Math.pow(1 - chance, 1 / acrossDays);
			}
			
			return(randomNumber < chance);
		}
		
		/**
		 * Return a random element from the given vector or array
		 */
		public static function pickRandom(array:*):*
		{
			if (array is Number) {
				return array;
			}
			if (array == null || array.length == 0) {
				return null;
			}
			if (array.length == 1) {
				return array[0];
			}
			var index:int = Math.floor(Rndm.random() * array.length);
			return array[index];
		}
		
		/**
		 * Return a random element from the given vector or array, removing it from the array.
		 */
		public static function removeRandom(array:*):*
		{
			if (array == null || array.length == 0) {
				return null;
			}
			if (array.length == 1) {
				return array.pop();
			}
			var index:int = Math.floor(Rndm.random() * array.length);
			var object:* = array[index];
			removeFromVector(array, object);
			return object;
		}
		
		/**
		 * Return a random integer between min and max inclusive
		 */
		public static function getRandomNumber(min:Number, max:Number):Number
		{
			if (max < min) {
				Utils.logError("GetRandom Max(" + max + ") less than Min(" + min + ").");
				return min;
			}
			var multiplier:Number = (max - min);
			var value:Number = Rndm.random() * multiplier + min;
			//Utils.log("Random number between " + min + " and " + max + " is " + value + " mult is " + multiplier);
			return value;
		}
		
		/**
		 * Return a random integer between min and max inclusive
		 */
		public static function getRandomInt(min:int, max:int):int
		{
			if (max < min) {
				Utils.logError("GetRandom Max(" + max + ") less than Min(" + min + ").");
				return min;
			}
			var multiplier:int = (max - min) + 1;
			var value:int = Math.floor(Rndm.random() * multiplier) + min;
			return value;
		}
		
		/**
		 * Round the given number to some number of decimal places. 3.12345 becomes 3.12.
		 * 4 becomes 4.00
		 */
		public static function roundNumber(value:Number, decimals:int = 0):String
		{
			if (decimals == 0) {
				return Math.round(value) + "";
			}
			
			value = value * Math.pow(10, decimals);
			value = Math.round(value);
			value = value / Math.pow(10, decimals);
			
			var string:String = value + "";
			var periodIndex:int = string.indexOf(".");
			if (periodIndex == -1) {
				string += ".";
				periodIndex = string.indexOf(".");
			}
			var numDecimals:int = string.length - periodIndex - 1;
			var decimalsNeeded:int = decimals - numDecimals;
			for (var i:int = 0; i < decimalsNeeded; i++) {
				string += "0";
			}
			
			return string;
		}
		
		/**
		 * From http://keith-hair.net/blog/2008/08/04/find-intersection-point-of-two-lines-in-as3/
		 * Checks for intersection of Segment if as_seg is true.
		 * Checks for intersection of Line if as_seg is false.
		 * Return intersection of Segment AB and Segment EF as a Point
		 * Return null if there is no intersection
		 */
		public static function lineIntersectLine(A:Point, B:Point, E:Point, F:Point):Point
		{
			var ip:Point;
			var a1:Number;
			var a2:Number;
			var b1:Number;
			var b2:Number;
			var c1:Number;
			var c2:Number;
		
			a1 = B.y - A.y;
			b1 = A.x - B.x;
			c1 = B.x * A.y - A.x * B.y;
			a2 = F.y - E.y;
			b2 = E.x - F.x;
			c2 = F.x * E.y - E.x * F.y;
		
			var denom:Number = a1 * b2 - a2 * b1;
			if (denom == 0) {
				Utils.logError("Can't intersect two parallel lines ", a1, b2, a2, b1);
				return null;
			}
			ip = new Point();
			ip.x = (b1 * c2 - b2 * c1) / denom;
			ip.y = (a2 * c1 - a1 * c2) / denom;
			return ip;
		}
		
		public static function distanceTwoPoints(point1:Point, point2:Point):Number
		{
			var dx:Number = point1.x - point2.x;
			var dy:Number = point1.y - point2.y;
			return Math.sqrt(dx * dx + dy * dy);
		}
		
		/**
		 * From http://www.baconandgames.com/2010/03/04/calculating-the-distance-from-a-point-to-a-line-in-as3/
		 */
		public static function distanceFromLine(a:Point, b:Point, point:Point):Number
		{
			var m:Number = (a.y-b.y)/ (a.x-b.x);
			var B:Number = (1/m)*point.x - point.y;
			var d:Point = new Point(b.x,b.x* (-1/m)+B);
			var e:Point = new Point(a.x,a.x* (-1/m)+B);
			var intersectPoint:Point = lineIntersectLine(a, b, d, e);
			if (intersectPoint == null) {
				Utils.logError("Couldn't find distance from line", a, b, point);
				return -1;
			}
			var dx:Number = point.x - point.x, dy:Number = point.y + point.y;
			var distance:Number = Math.floor(Math.pow(dx * dx + dy * dy, .5));
			
			return distance;
		}
		
		/**
		 * Return true if the given point is within the given rectangle.
		 */
		public static function isPointWithin (point:Point, rectangle:Rectangle):Boolean
		{
			if (point.x < rectangle.x || point.y < rectangle.y) {
				return false;
			}
			if (point.x > rectangle.x + rectangle.width || point.y > rectangle.y + rectangle.height) {
				return false;
			}
			return true;
		}
		
		public static function scaleRectangle (rectangle:Rectangle, scale:Number):void
		{
			rectangle.x *= scale;
			rectangle.y *= scale;
			rectangle.width *= scale;
			rectangle.height *= scale;
		}
		
		/**
		 * Turn the given display object into a bitmap and return it inside a sprite container.
		 * Return sprite will have the same position as the original object.
		 * @param gutter Extra space on top-right-bottom-left for glow effects, etc
		
		public static function bitmapize(object:DisplayObject, gutter:Number = 0,
			bounds:Rectangle = null, transparent:Boolean = true,
			bgColor:uint = 0x00000000):Bitmap
		{
			var bitmap:SarahBitmap = new SarahBitmap(object, gutter, bounds, transparent, bgColor);
			return bitmap.makeBitmap();
		}*/
		
		/**
		 * Replace the given object in the scene with a Bitmap that can't be clicked.
		
		public static function replaceWithBitmap(object:DisplayObject,
			existingSarahBitmap:SarahBitmap = null):Sprite
		{
			var bitmap:Bitmap;
			if (existingSarahBitmap == null) {
				bitmap = Utils.bitmapize(object);
			} else {
				bitmap = existingSarahBitmap.makeBitmap();
			}
			
			// must wrap in a container to replace original object in parent
			var container:Sprite;
			if (object is MovieClip) {
				container = new MovieClip();
			} else if (object is Sprite) {
				container = new Sprite();
			} else {
				Utils.logError("Unexpected object type in replace with bitmap.", object);
				return new Sprite();
			}
			container.mouseEnabled = false;
			container.mouseChildren = false;
			container.addChild(bitmap);
			
			object.parent.addChildAt(container, object.parent.getChildIndex(object));
			
			if (object.parent[object.name] != object) {
				Utils.logError("Not replacing bitmapized gfx in scene because name differs.");
			} else {
				object.parent[object.name] = container;
			}
			
			Utils.removeFromParent(object);
			container.name = object.name;
			
			return container;
		}*/
		
		/**
		 * Run replaceWithBitmap on all children of the given object.
		
		public static function replaceChildrenWithBitmaps(parent:DisplayObjectContainer):void
		{
			for (var i:int = 0; i < parent.numChildren; i++) {
				var child:DisplayObject = parent.getChildAt(i);
				replaceWithBitmap(child);
			}
		}*/
		
		/**
		 * Given a list of items and a list of weights,
		 * pick a random item by weight. The higher the weight, the more likely it is to be
		 * picked. So if one thing has a weight of 1 and another of 5, the second is five times
		 * as likely to be chosen. A weight of 0 means it will never be chosen.
		 */
		public static function weightedRandomList(list:*, weightList:*):*
		{
			if (list.length != weightList.length) {
				Utils.logError("list is different length from weights in weightedRandomList", list, weightList);
			}
			return weightedRandom(list,
				function(item:*):Number {
					var index:int = list.indexOf(item);
					if (index == -1 || index > weightList.length - 1) {
						Utils.logError("item " + item + " not in weight list " + weightList);
						return 0;
					}
					return weightList[index];
				}
			);
		}
		
		/**
		 * Given a list of items and a function which takes an item and returns its weight,
		 * pick a random item by weight. The higher the weight, the more likely it is to be
		 * picked. So if one thing has a weight of 1 and another of 5, the second is five times
		 * as likely to be chosen. A weight of 0 means it will never be chosen.
		 */
		public static function weightedRandom(list:*, getWeight:Function):*
		{
			if (list.length == 0) {
				return null;
			}
			
			var totalWeight:Number = 0;
			var item:*;
			for each (item in list) {
				try {
					totalWeight += getWeight(item);
				} catch(error:Error) {
					Utils.logError("Couldn't get weight for " + item + " in weightedRandom");
				}
			}
			
			if (totalWeight == 0) {
				Utils.log("Total weight is 0 in weighted random.");
				return null;
			}
			
			var runningWeight:Number = 0;
			var randomNum:Number = Utils.getRandomNumber(0, totalWeight);
			for each (item in list) {
				var weight:Number;
				try {
					weight = getWeight(item);
				} catch(error:Error) {
					Utils.logError("Couldn't get weight for " + item + " in weightedRandom");
					weight = 0;
				}
				runningWeight += weight;
				
				if (weight > 0 && runningWeight >= randomNum) {
					return item;
				}
			}

			Utils.logError("could not find a random item by weight", totalWeight, randomNum,
				runningWeight, list,(new Error()).getStackTrace());
			return null;
		}
		
		/**
		 * Same as vector.join(", ") but with more checks.
		 */
		public static function vectorToString(vector:*):String
		{
			if (vector == null || vector.length == 0) {
				return "";
			}
			var string:String = "";
			for each (var object:* in vector) {
				if (!object.hasOwnProperty("toString")) {
					//Utils.log("object doesn't have toString: " + object);
					string += object + ", ";
					continue;
				}
				try {
					string += object.toString() + ", ";
				} catch (error:Error) {
					Utils.log("failed to call toString on object: " + object + " in Utils.vectorToString");
					string += object + ", ";
				}
			}
			string = removeLastCharacter(string, 2);
			return string;
		}
		
		/**
		 * Return true if the given vector contains at least one of the listed objects.
		 */
		public static function vectorContains(vector:*, ... objects:*):Boolean
		{
			for each (var object:* in objects) {
				var indexOf:int = vector.indexOf(object);
				if (indexOf != -1) {
					return true;
				}
			}
			return false;
		}
		
		/**
		 * Return true if the given string contains at least one of the given strings.
		 */
		public static function stringContains(string:String, ... objects:*):Boolean
		{
			for each (var object:* in objects) {
				if (object is String) {
					if ((string.indexOf(object as String) != -1)) {
						return true;
					}
				}
			}
			return false;
		}
		
		/**
		 * If the button has a single text field(and something else on each frame),
		 * set the text in that field.
		 */
		public static function setButtonText(button:SimpleButton, text:String,
			classesToIgnore:Array = null):void
		{
			if (button is GuiButton) {
				//Utils.log("switching to GuiButton.originalButton for Utils.setButtonText");
				button = (button as GuiButton).originalButton;
			}

			var textFields:Array = buttonClasses(button, TextField, classesToIgnore);
			for each (var textField:TextField in textFields) {
				// only DYNAMIC or INPUT text fields will be found
				textField.text = text;
			}
		}
		
		/**
		 * Return an array of the object matching the given class in every state of the button.
		 * For example an array of three TextFields if one exists in the up/over/down states.
		 */
		public static function buttonClasses(button:SimpleButton, classToFind:Class,
			classesToIgnore:Array = null, stopAfterFirst:Boolean = true):Array
		{
			if (button is GuiButton) {
				button = (button as GuiButton).originalButton;
			}

			var foundClasses:Array = [];
			for each (var state:DisplayObject in [button.upState, button.overState, button.downState]) {
				var stateFound:Array = findClasses(state, classToFind, classesToIgnore, false, stopAfterFirst);
				if (stateFound.length == 0) {
					// try again with a more thorough class comparaison
					// required for loading external SWFs
					stateFound = findClasses(state, classToFind, classesToIgnore, true, stopAfterFirst);
				}
				for each (var found:* in stateFound) {
					foundClasses.push(found);
				}
			}
			return foundClasses;
		}
		
		public static function findAncestor(child:DisplayObject, classToFind:Class):*
		{
			if (child is classToFind) {
				return child;
			}
			if (child.parent == null || child.parent is Stage) {
				return null;
			}
			try {
				return findAncestor(child.parent, classToFind);
			} catch (error:Error) {
				Utils.log("reached the end of findAncestor I guess.");
				return null;
			}
		}
		
		/**
		 * Find a single class, similar to findClasses.
		 */
		public static function findClass(parent:DisplayObject, classToFind:Class,
			classesToIgnore:Array = null, deepCompare:Boolean = false):*
		{
			var foundClasses:Array = findClasses(parent, classToFind,
				classesToIgnore, deepCompare, true);
			if (foundClasses.length == 0) {
				return null;
			}
			return foundClasses[0];
		}
		
		/**
		 * Find every instance of a class inside the given parent.
		 * Given an object with a single something eg a TextField, find and return
		 * the TextField. If the object itself is a TextField(which happens if you have a
		 * buttons that contains only a textfield) it is cast and returned. Return null
		 * if the class is not found. Recurse through children, but not inside ignoreClazz.
		 * Used for SimpleButton states because identifiers get nuked during button creation.
		 */
		public static function findClasses(parent:DisplayObject, classToFind:Class,
			classesToIgnore:Array = null, deepCompare:Boolean = false,
			stopAfterFirst:Boolean = false):Array
		{
			var foundClasses:Array = [];
			
			var findIn:Function = function(object:DisplayObject):void {
				if (stopAfterFirst && foundClasses.length > 0) {
					return;
				}
				
				// don't return or look inside certain classes
				if (classesToIgnore != null) {
					for each (var classToIgnore:Class in classesToIgnore) {
						if (object is classToIgnore) {
							return;
						}
					}
				}
				
				//if (classToFind == GfxGui && Utils.classNameFromInstance(object) == "GfxGui") {
					//Utils.log("is object classtofind? " + (object is classToFind));
					//Utils.log("classNameFromInstance is " + Utils.classNameFromInstance(object));
					//Utils.log("classNameFromClass is " + Utils.classNameFromClass(classToFind));
					//Utils.log("classFromInstance is " + Utils.classFromInstance(object));
					//Utils.log("class is " + classToFind);
					//Utils.log("compare: " + (Utils.classFromInstance(object) == classToFind));
					//var blah:GfxGui = object as GfxGui;
					//Utils.log("blah: " + blah);
					//var gah:GfxGui = new (Utils.classFromInstance(classToFind))();
					//Utils.log("gah: " + gah);
				//}
				
				// the droid we are looking for, don't look no further inside
				if (object is classToFind) {
					foundClasses.push(object as classToFind);
					return;
				}
				
				// compare classes in a different way for SWF/SWC compares
				if (deepCompare && Utils.classFromInstance(object) == classToFind) {
					foundClasses.push(object);
					return;
				}
				
				// buttons are a 4-frame special case
				if (object is SimpleButton) {
					foundClasses = foundClasses.concat(buttonClasses(object as SimpleButton,
						classToFind, classesToIgnore));
					return;
				}
				
				// some stub we don't care about
				if (!(object is DisplayObjectContainer)) {
					return;
				}
				
				// Causes trouble when the mc is gotoandplay(1) - it doesn't play(air bug?)
				// could get around air bug by adding mc to the stage first
				// recurse through frames in a MovieClip
				//if (object is MovieClip) {
					//var movieClip:MovieClip = object as MovieClip;
					//for (var frameNum:int = 1; frameNum <= movieClip.totalFrames; frameNum++) {
						//movieClip.gotoAndStop(frameNum);
						//var children:Array = Utils.getChildren(movieClip);
						//for each (var child:DisplayObject in children) {
							//findIn(child);
						//}
					//}
					//movieClip.gotoAndStop(1);
					//return;
				//}
				
				// recurse through children in a Sprite etc
				var children:Array = Utils.getChildren(object);
				for each (var child:DisplayObject in children) {
					findIn(child);
				}
				
				return;
			}
			
			findIn(parent);
			
			return foundClasses;
		}
		
		public static function getChildren(parent:DisplayObject):Array
		{
			if (!(parent is DisplayObjectContainer)) {
				Utils.log("No children because not a container: " + parent.name);
				return [];
			}
			
			var children:Array = [];
			for (var i:int = 0; i <(parent as DisplayObjectContainer).numChildren; i++) {
				var child:DisplayObject = (parent as DisplayObjectContainer).getChildAt(i);
				children.push(child);
			}
			return children;
		}
		
		/**
		 * Return any child with the given name, OR any child of any child with the given name, etc
		 * recursively going all the way down. That's what it's supposed to do anyway...
		 *
		 * May be horribly broken.
		 */
		public static function getChildByName(parentClip:DisplayObjectContainer, name:String):DisplayObject
		{
			var innerFunction:Function = function(parent:DisplayObjectContainer):DisplayObject {
				if (parent == null) {
					return null;
				}
				
				if (parent.hasOwnProperty(name) && parent[name] != null && parent[name] is DisplayObject) {
					return parent[name] as DisplayObject;
				}
				
				for each (var child:DisplayObject in getChildren(parent)) {
					if (child is DisplayObjectContainer) {
						return getChildByName(child as DisplayObjectContainer, name);
					}
				}
				return null;
			}
			return innerFunction(parentClip);
		}
		
		/**
		 * Return min if value is under it, max if value is over it, or value if it is between.
		 */
		public static function minMax(value:Number, min:Number, max:Number = int.MAX_VALUE):Number
		{
			if (isNaN(value)) {
				Utils.logError("Got NaN in Utils.minMax, using zero");
				value = 0;
			}
			if (max != int.MIN_VALUE && max < min) {
				Utils.logError("MinMaxInt Max(" + max + ") less than Min(" + min + ").");
				return value;
			}
			return(value < min) ? min :(value > max) ? max : value;
		}
		
		/**
		 * Replace all instances of one string with another. If capitals is true also find and
		 * replace with the first letter capitalized.
		 */
		public static function replaceAll(text:String, find:String, replace:String,
			capitals:Boolean = false):String
		{
			if (text == null) {
				return null;
			}
			
			// replace all instances of one string with another(him -> her)
			text = text.split(find).join(replace);
			
			// capitalize both Find and Replace strings(Him -> Her)
			if (capitals) {
				if (find.substring(0, 1) == "[") {
					find = find.substring(0, 2).toUpperCase() + find.substring(2);
				} else {
					find = find.substring(0, 1).toUpperCase() + find.substring(1);
				}
				if (replace.length > 0) {
					replace = replace.substring(0, 1).toUpperCase() + replace.substring(1);
				}
				text = text.split(find).join(replace);
			}
			return text;
		}
		
		/**
		 * Remove all spaces from the beginning and the end of the string.
		 */
		public static function trimSpaces(text:String):String
		{
			if (text == null || text.length == 0) {
				return text;
			}
			
			return text.replace(/^\s+|\s+$/g, "");
		}
		
		/**
		 * Return true if the given text begins with the given value.
		 */
		public static function startsWith (text :String, stringToFind :String) :Boolean
		{
			if (text == null) {
				return false;
			}
			if (stringToFind == null) {
				return true;
			}
			if (text.length < stringToFind.length) {
				return false;
			}
			return (text.substring(0, stringToFind.length) == stringToFind);
		}
		
		/**
		 * Return true if the given text ends with the given textToFind.
		 */
		public static function endsWith(text:String, textToFind:String):Boolean
		{
			var index:int = text.lastIndexOf(textToFind);
			if (index == -1) {
				return false;
			}
			return index == (text.length - textToFind.length);
		}
		
		public static function isEmpty(text:String):Boolean
		{
			return(text == null || trimSpaces(text).length == 0);
		}
		
		public static function deNull(text:String):String
		{
			return(text == null) ? "" : text;
		}
		
		/**
		 * Replace blank strings or the string "null" with actual null. Useful after retrieving
		 * data from storage where it may have been changed.
		 */
		public static function reNull(text:String):String
		{
			return(isEmpty(text) || text.toLowerCase() == "null") ? null : text;
		}
		
		public static function removeLastCharacter(text:String, numCharacters:int = 1):String
		{
			if (numCharacters < 0 || numCharacters > text.length) {
				return "";
			}
			return text.substring(0, text.length - numCharacters);
		}
		
		/**
		 * Capitalize all words in the text, or just the first word if allWords is set to false.
		 */
		public static function capitalize(text:String, allWords:Boolean = true):String
		{
			if (text == null || text.length == 0) {
				return "";
			}
			var words:Array;
			if (allWords) {
				words = text.split([" "]);
			} else {
				words = [text];
			}
			var capitalizedText:String = "";
			for each (var word:String in words) {
				var firstChar:String = word.substr(0, 1);
				var restOfString:String = word.substr(1, word.length);
				capitalizedText += firstChar.toUpperCase() + restOfString.toLowerCase()  + " ";
			}
			capitalizedText = removeLastCharacter(capitalizedText);
			return capitalizedText;
		}
		
		/**
		 * Ignores all characters except digits and periods. Turn it into a Number, or 0.
		 */
		public static function parseNumber(text:String):Number
		{
			if (isEmpty(text)) {
				return 0;
			}
			var parsedText:String = text.replace(new RegExp(/[^0-9.]+/g), "");
			// keep only the first period if there's more than one
			parsedText = parsedText.replace(new RegExp(/\./), "p");
			parsedText = parsedText.replace(new RegExp(/\./g), "");
			parsedText = parsedText.replace(new RegExp(/p/), ".");
			var num:Number = Number(parsedText);
			if (isNaN(num)) {
				Utils.logError("Failed to parse number: " + text + "(parsed: " + parsedText + ")");
				return 0;
			}
			return num;
		}
		
		/**
		 * Move the child x and y coords from the fromParent, to the stage, then back to the
		 * toParent. Does not change the parent of the child, only the x and y.
		 */
		public static function localToLocal(child:DisplayObject,
			fromParent:DisplayObjectContainer, toParent:DisplayObjectContainer):void
		{
			var coords:Point = new Point(child.x, child.y);
			coords = fromParent.localToGlobal(coords);
			coords = toParent.globalToLocal(coords);
			child.x = coords.x;
			child.y = coords.y;
		}
		
		public static function cloneVector(original:*):*
		{
			return original.concat();
		}
		
		/**
		 * Add the given element to the given vector or array if it's not null and not already
		 * in the vector.
		 * @param toFront set to true to add to slot 0 of the array, better than buggy unshift.
		 */
		public static function addToVector(vector:*, element:*, toFront:Boolean = false):void
		{
			if (element == null) {
				return;
			}
			if (vectorContains(vector, element)) {
				return;
			}
			if (toFront) {
				vector.splice(0, 0, element);
			} else {
				vector.push(element);
			}
		}
		
		/**
		 * Splices the given object out of the given vector and returns it. If the object
		 * was not found, return null.
		 * @param vector some Vector.<Object>
		 */
		public static function removeFromVector(vector:*, object:Object, removeAll:Boolean = false):Object
		{
			if (!(vector is Array) && !(vector is Vector) && (object is Array || object is Vector)) {
				Utils.logError("May have removeFromVector argument order wrong!");
			}
			var indexOf:int = vector.indexOf(object);
			if (indexOf == -1) {
				return null;
			}
			vector.splice(indexOf, 1);
			
			if (removeAll) {
				removeFromVector(vector, object, true);
			}
			
			return object;
		}
		
		/**
		 * Carefully add or remove a child displayobject from the parent if appropriate.
		 */
		public static function addRemoveChild(parent:DisplayObjectContainer,
			child:DisplayObject, adding:Boolean, index:int = -1):void
		{
			if (parent == null) {
				Utils.logError("parent is null during addRemoveChild");
				return;
			}
			if (child == null) {
				if (Config.DEBUG_MODE) {
					throw new Error("Child is null during addRemoveChild");
				}
				Utils.logError("child is null during addRemoveChild");
				return;
			}
			if (!(parent is DisplayObjectContainer)) {
				Utils.logError("parent is not a container", parent);
				return;
			}
			if (!adding && parent.contains(child)) {
				parent.removeChild(child);
			} else if (adding && !parent.contains(child)) {
				if (index == -1) {
					parent.addChild(child);
				} else {
					parent.addChildAt(child, index);
				}
			} else if (adding) {
				// parent already contained child but we probably still want it at the front
				if (index == -1) {
					moveChildToTop(child);
				} else {
					parent.setChildIndex(child, index);
				}
			}
		}
		
		/**
		 * Carefully add or remove a child displayobject from the parent if appropriate.
		 */
		public static function addToParent(parentClip:DisplayObjectContainer,
			childClip:DisplayObject, index:int = -1):void
		{
			addRemoveChild(parentClip, childClip, true, index);
		}
		
		/**
		 * Move the given child over its siblings.
		 */
		public static function moveChildToTop(child:DisplayObject):void
		{
			if (child.parent != null) {
				child.parent.setChildIndex(child, child.parent.numChildren - 1);
			}
		}
		
		/**
		 * Carefully remove a clip from whatever parent has it on the stage.
		 */
		public static function removeFromParent(childClip:DisplayObject):void
		{
			if (childClip == null) {
				Utils.logError("couldn't remove null clip from parent.");
				return;
			}
			if (childClip.parent != null && childClip.parent.contains(childClip)) {
				childClip.parent.removeChild(childClip);
			}
		}
		
		/**
		 * Set the alpha to 1(visible) or 0.
		 */
		public static function toggleVisible(object:DisplayObject, visible:Boolean = true):void
		{
			if (object == null) {
				Utils.logError("Couldn't toggleAlpha on null object.",(new Error()).getStackTrace());
				return;
			}
			object.visible = visible;
		}
		
		/**
		 * Show a single child and hide the others. If childName is null, hide everything.
		 */
		public static function toggleChildVisibility(parent:DisplayObjectContainer,
			childName:String):void
		{
			var foundChild:Boolean = false;
			for (var i:int = 0; i < parent.numChildren; i++) {
				var child:DisplayObject = parent.getChildAt(i);
				if (child.name != null && child.name == childName) {
					child.visible = true;
					foundChild = true;
				} else {
					child.visible = false;
				}
			}
			if (!foundChild && childName != null) {
				Utils.log("Couldn't find child for toggleVisibility", childName);
			}
		}
		
		/**
		 * Set the alpha of the given object (either a Flash or Starling DisplayObject) at every
		 * frame, starting at 0 and ending at 1 after durationMillis. FadeIn will complete
		 * immediately if the object is removed from the stage.
		 */
		public static function fadeIn (object :*, durationMillis :int = 1000, setToZero:Boolean = false) :void
		{
			var startTime :Number = (new Date()).getTime();
			if (setToZero) {
				object.alpha = 0;
			}
			var prevAlpha:Number = object.alpha;
			var fading :Function = function(...ig):void {
				if (prevAlpha != object.alpha) {
					Utils.log("detected doublefade.");
					Main.removeStageEventListener(Event.ENTER_FRAME, fading);
					return;
				}
				var percent:Number = ((new Date()).getTime() - startTime) / durationMillis;
				if (percent >= 1 || object.stage == null) {
					Main.removeStageEventListener(Event.ENTER_FRAME, fading);
					object.alpha = 1;
				} else {
					object.alpha = percent;
				}
				prevAlpha = object.alpha;
			}
			Main.addStageEventListener(Event.ENTER_FRAME, fading);
		}
		
		/**
		 * Set the alpha of the given object (either a Flash or Starling DisplayObject) at every
		 * frame, starting at 1 and ending at 0 after durationMillis. FadeOut will complete
		 * immediately if the object is removed from the stage.
		 */
		public static function fadeOut (object :*, durationMillis :int = 1000,
			removeWhenComplete:Boolean = false) :void
		{
			var startTime :Number = (new Date()).getTime();
			//object.alpha = 1;
			var prevAlpha:Number = object.alpha;
			var fading :Function = function(...ig):void {
				if (prevAlpha != object.alpha) {
					Utils.log("detected doublefade.");
					Main.removeStageEventListener(Event.ENTER_FRAME, fading);
					return;
				}
				var percent:Number = ((new Date()).getTime() - startTime) / durationMillis;
				if (percent >= 1 || object.stage == null) {
					Main.removeStageEventListener(Event.ENTER_FRAME, fading);
					object.alpha = 0;
					if (removeWhenComplete && object.parent != null) {
						object.parent.removeChild(object);
					}
				} else {
					object.alpha = 1 - percent;
				}
				prevAlpha = object.alpha;
			}
			Main.addStageEventListener(Event.ENTER_FRAME, fading);
		}
		
		/**
		 * Moves an object across the screen over durationMillis, from where it started to
		 * a destination point.
		 * Utils.slide(messageGfx.finger, 1000, new Point(Main.dog.x, messageGfx.fingerDesination.y));
		 */
		public static function slide (object :*, durationMillis :int, destination:Point) :void
		{
			var startTime :Number = (new Date()).getTime();
			var startLocation :Point = new Point(object.x, object.y);
			//var difference:Point = new Point(destination.x - object.x, destination.y - object.y);
			var sliding :Function = function(...ig):void {
				var percent:Number = ((new Date()).getTime() - startTime) / durationMillis;
				if (percent >= 1 || object.stage == null) {
					Main.removeStageEventListener(Event.ENTER_FRAME, sliding);
					object.x = destination.x;
					object.y = destination.y;
				} else {
					object.x = startLocation.x + (destination.x - startLocation.x) * percent;
					object.y = startLocation.y + (destination.y - startLocation.y) * percent;
				}
			}
			Main.addStageEventListener(Event.ENTER_FRAME, sliding);
		}
		
		/**
		 * Set the rotation of a flash or starling DisplayObject so that it spins clockwise
		 * in a circle over durationMillis.
		 */
		public static function spin (object :*, durationMillis :int = 1000) :void
		{
			var startTime :Number = (new Date()).getTime();
			object.rotation = 0;
			var spinning :Function = function(...ig):void {
				var percent:Number = ((new Date()).getTime() - startTime) / durationMillis;
				if (percent >= 1 || object.stage == null) {
					Main.removeStageEventListener(Event.ENTER_FRAME, spinning);
					object.rotation = 0;
				} else {
					//var rotationPercent:Number = -percent * (percent - 2);
					var rotationPercent:Number = -Math.pow(2, -10 * percent) + 1;
					if (object is DisplayObject) {
						object.rotation = 360 * rotationPercent;
					} else {
						// starling DisplayObjects use radians instead of degrees
						object.rotation = (360 * rotationPercent) * Math.PI / 180;
					}
				}
			}
			Main.addStageEventListener(Event.ENTER_FRAME, spinning);
		}
		
		/**
		 * Remove all children from a parent container.
		 */
		public static function clearChildren(parent:DisplayObjectContainer):void
		{
			if (parent == null) {
				Utils.logError("Null parent in Utils.clearChildren");
				return;
			}
			while (parent.numChildren > 0) {
				parent.removeChildAt(0);
			}
		}
		
		/**
		 * Remove all elements from a vector or array
		 */
		public static function clearVector(vector:*):void
		{
			while (vector.length > 0) {
				vector.pop();
			}
		}
		
		/**
		 * Return a new vector(or array) of the same type as the first, with all elements
		 * that appear in either vector, at most once.
		 */
		public static function unionVectors(first:*, second:*):*
		{
			var newVector:* = cloneVector(first);
			for each (var element:* in second) {
				if (newVector.indexOf(element) == -1) {
					newVector.push(element);
				}
			}
			return newVector;
		}
		
		/**
		 * Shuffle the order of elements in a vector or array. Affects the original vector,
		 * but also returns it.
		 */
		public static function randomizeVector(vector:*):*
		{
			// do the Fisher–Yates shuffle (10x faster than sort by random)
			var maxIndex:int = vector.length;
			var randomIndex:int;
			var temp:*;
			
			while (maxIndex > 1) {
				maxIndex--;
				randomIndex = Utils.getRandomInt(0, maxIndex);
				temp = vector[maxIndex];
				vector[maxIndex] = vector[randomIndex];
				vector[randomIndex] = temp;
			}
			return vector;
			//vector.sort(function(...ig):Number {
				//return Utils.pickRandom([1, -1]);
			//});
			//return vector;
		}
		
		/**
		 * Return an array of(non-empty) values that appear in both firstVector and secondVector.
		 * Params may be vectors or arrays and return type is the same as firstVector.
		 */
		public static function intersection(firstVector:*, secondVector:*):*
		{
			var vector:* = cloneVector(firstVector);
			Utils.clearVector(vector);
			for each (var value:* in firstVector) {
				if (value == null) {
					continue;
				}
				if (value is String && isEmpty(value as String)) {
					continue;
				}
				if (!vectorContains(secondVector, value)) {
					continue;
				}
				vector.push(value);
			}
			return vector;
		}
		
		/**
		 * Return the number of days between two dates, exclusive.
		 */
		public static function dateDifference(startDate:Date, endDate:Date):int
		{
			if (startDate == null) { return 0; }
			if (endDate   == null) { return 0; }
			var timediff:Number = Math.floor(endDate.valueOf() - startDate.valueOf());
			return int(timediff / (24 * 60 * + 60 * 1000));
			//return "Time taken:  "
				//+ String( int(timediff/ (24*60*+60*1000))     ) + " days, "
				//+ String( int(timediff/ (    60*60*1000)) %24 ) + " hours, "
				//+ String( int(timediff/ (       60*1000)) %60 ) + " minutes, "
				//+ String( int(timediff/ (        1*1000)) %60 ) + " seconds.";
		}
		
		/**
		 * Return the given date in this format: January 1st 2011 3:45 pm
		 */
		public static function getDateString(fromDate:Date, daysSince:int = 0,
			includeTime:Boolean = false, includeYear:Boolean = true):String
		{
			var currentGameDate:Date = new Date(fromDate);
			currentGameDate.setDate(currentGameDate.getDate() + daysSince);
			
			var months:Array = ["January", "February", "March", "April", "May", "June", "July",
				"August", "September", "October", "November", "December"];
				
			var date:int = currentGameDate.getDate();
			var postfix:String = "th";
			if (date == 1 || date == 21 || date == 31) {
				postfix = "st";
			} else if (date == 2 || date == 22) {
				postfix = "nd";
			} else if (date == 3 || date == 23) {
				postfix = "rd";
			}
			
			var year:String = (includeYear) ?(" " + currentGameDate.getFullYear()) : "";
			var time:String = (includeTime) ?(" " + formatTime(currentGameDate, true, false)) : "";
				
			var dateString:String = months[currentGameDate.getMonth()] + " " + date + postfix
				+ year + time;
				
			return dateString;
		}
		
		/**
		 * Return a string in hh:mm:ss format, possibly with no hour. Eg 5:04:59 or 3:28 or 0:21.
		 * Includes leading zeroes for right alignment.
		 */
		public static function formatTime(date:Date, includeHour:Boolean = true,
			includeSeconds:Boolean = true, ampm:Boolean = true):String
		{
			var seconds:int = date.seconds;
			var minutes:int = date.minutes;
			var hours:int = date.hours;
			
			//Utils.log("formatTime",hours, minutes, seconds);
			
			var value:String = "";
			
			if (includeHour) {
				if (ampm && hours > 12) {
					value += (hours - 12);
				} else {
					value += hours;
				}
				value += ":";
			}
			
			value += ((minutes < 10) ? "0" : "") + minutes;
			
			if (includeSeconds) {
				value += ":" + ((seconds < 10) ? "0" : "") + seconds;
			}
			
			if (ampm) {
				value += (hours < 12) ? "am" : "pm";
			}
			
			return value;
			//return(includeHour) ? hours + ":" : ""
				//+ ((minutes < 10) ? "0" : "") + minutes + ":"
				//+ (includeSeconds) ?(((seconds < 10) ? "0" : "") + seconds) : "";
		}
		
		public static function getNumberTextCapitalized(number:int):String
		{
			return Utils.capitalize(getNumberText(number));
		}
		
		public static function smallerOf(first:Number, second:Number):Number
		{
			return(first < second) ? first : second
		}
		
		/**
		 * Return "two" for 2, "four" for 4 etc.
		 */
		public static function getNumberText(number:int):String
		{
			switch(number) {
				case 0: return "zero";
				case 1: return "one";
				case 2: return "two";
				case 3: return "three";
				case 4: return "four";
				case 5: return "five";
				case 6: return "six";
				case 7: return "seven";
				case 8: return "eight";
				case 9: return "nine";
				case 10: return "ten";
				case 11: return "eleven";
				case 12: return "twelve";
				case 13: return "thirteen";
				case 14: return "fourteen";
				case 15: return "fifteen";
				case 16: return "sixteen";
				case 17: return "seventeen";
				case 18: return "eighteen";
				case 19: return "nineteen";
				case 20: return "twenty";
				case 21: return "twenty-one";
				case 22: return "twenty-two";
				case 23: return "twenty-three";
				case 24: return "twenty-four";
				case 25: return "twenty-five";
				case 26: return "twenty-six";
				case 27: return "twenty-seven";
				case 28: return "twenty-eight";
				case 29: return "twenty-nine";
				case 30: return "thirty";
				case 31: return "thirty-one";
				case 32: return "thirty-two";
				case 33: return "thirty-three";
				case 34: return "thirty-four";
				case 35: return "thirty-five";
				case 36: return "thirty-six";
				case 37: return "thirty-seven";
				case 38: return "thirty-eight";
				case 39: return "thirty-nine";
				case 40: return "forty";
				case 41: return "forty-one";
				case 42: return "forty-two";
				case 43: return "forty-three";
				case 44: return "forty-four";
				case 45: return "forty-five";
				case 46: return "forty-six";
				case 47: return "forty-seven";
				case 48: return "forty-eight";
				case 49: return "forty-nine";
				case 50: return "fifty";
			}
			return number + "";
		}
		
		/**
		 * Insert commas into the number and return the string.
		 * http://stackoverflow.com/questions/721304/insert-commas-into-number-string
		 */
		public static function formatNumber(number:Number):String
		{
			//Utils.log("formatting " + number + " to " + String(number).replace(/ (\d)(?= (\d\d\d)+$)/g, "$1,"));
			return String(number).replace(/ (\d)(?= (\d\d\d)+$)/g, "$1,");
		}
		
		public static function classFromClassName(className:String):Class
		{
			if (Utils.isEmpty(className)) {
				return null;
			}
			try {
				return getDefinitionByName(className) as Class;
			} catch (error :Error) {
				logError("Failed to find class from className: " + className);
			}
			return Object;
		}
		
		public static function classNameFromInstance(object:Object):String
		{
			if (object == null) {
				return null;
			}
			// there's also getQualifiedSuperclassName or getBaseClassName too
			return getQualifiedClassName(object);
		}
		
		public static function classFromInstance (object :Object) :Class
		{
			if (object == null) {
				return null;
			}
			return classFromClassName(classNameFromInstance(object));
		}
		
		public static function classNameFromClass (clazz :Class) :String
		{
			if (clazz == null) {
				return null;
			}
			return getQualifiedClassName(clazz.prototype.constructor);
		}
			
		public static function createColorTransform(color:uint,
			darker:Boolean = true, multiplier:Number = 0.3):ColorTransform
		{
			var redMultiplier:Number;
			var greenMultiplier:Number;
			var blueMultiplier:Number;
			redMultiplier = greenMultiplier = blueMultiplier = 1 - multiplier;
			var red:uint = (color >> 16) & 0xFF;
			var green:uint = (color >>  8) & 0xFF;
			var blue:uint =  color & 0xFF;
			var redOffset:Number = Math.round(red * multiplier);
			var greenOffset:Number = Math.round(green * multiplier);
			var blueOffset:Number = Math.round(blue * multiplier);
			
			var transform:ColorTransform = new ColorTransform(redMultiplier, greenMultiplier,
				blueMultiplier, 1, redOffset, greenOffset, blueOffset, 0);
			
			if (darker) {
				transform.concat(DARKEN_TRANSFORM);
			}
			
			return transform;
		}
		
		/**
		 * Invoke the given function in delay milliseconds.
		 */
		public static function startTimer(delayMillis:int, func:Function, numFires:int = 1):void
		{
			var timer:Timer = new Timer(delayMillis, numFires);
			timer.addEventListener(TimerEvent.TIMER, function(...ig): void {
				func();
			});
			timer.start();
		}
		
		/**
		 * @param	url
		 * @param	target _self, _blank, _parent, _top, defaults to _blank
		 */
		public static function openUrl(url:String, urlName:String = null, urlGroup:String = null,
			target:String = "_blank"):void
		{
			if (Utils.isEmpty(url)) {
				Utils.logError("Can't open a null url");
				return;
			}

			try {
				navigateToURL(new URLRequest(url), target);
			} catch(e:Error) {
				Utils.logError("Couldn't open url: " + url, e);
			}
		}
		
		/**
		 * Only log regular statements in debug mode.
		 */
		public static function log(param:*, ... params:*):void
		{
			// also log the error to a string and/or a visible textfield
			var text:String = param + params + "\n";
			logToDebugText(text);
			
			if (Config.DEBUG_MODE) {
				trace(param, params);
			}
		}
		
		/**
		 * Log these strings always.
		 */
		public static function logAlways(param:*, ... params:*):void
		{
			var text:String = param + params + "\n";
			logToDebugText(text);
			trace(param, params);
		}
		
		protected static function logToDebugText(value:String):void
		{
			//Config.debugTextString = value + Config.debugTextString;
			//if (Config.debugTextString.length > 10000) {
				//Config.debugTextString = Config.debugTextString.substring(0, 5000);
			//}
			//if (Config.debugTextField != null) {
				//Config.debugTextField.text = Config.debugTextString;
			//}
			//
			//if (Config.AUTOSEND_ERROR_REPORTS || Config.LOG_TO_COOKIES) {
				//SaveManagerCookies.saveLog(Config.debugTextString);
			//}
		}
		
		/**
		 * Trace the given params, plus a stack trace either from a new Error or from any
		 * error provided in the params. Always log even in production mode.
		 */
		public static function logError(param:*, ... params:*):void
		{
			trace("ERROR - " + param, params);
			
			try {
				var stackTrace:String = null;
				if (param is Error) {
					stackTrace = (param as Error).getStackTrace();
				} else if (params is Error) {
					stackTrace = (params as Error).getStackTrace();
				} else {
					for each (var p:* in params) {
						if (p is Error) {
							stackTrace = (p as Error).getStackTrace();
							break;
						}
					}
				}
				if (stackTrace == null) {
					stackTrace = (new Error()).getStackTrace();
				}
				if (stackTrace != null) {
					trace(stackTrace);
				}
			} catch(error:Error) {
				trace("Couldn't log stack track", error);
			}
			
			// also record error in a string and/or text field
			var text:String = param + params + "\n";
			if (stackTrace != null) {
				text += stackTrace + "\n";
			}
			logToDebugText(text);
			
			try {
				// "errorV101" etc differentiates version
				//var version:String = Utils.replaceAll(Config.VERSION, ".", "");
				//var message:String = Utils.replaceAll((param + params), "'", "");
				//LogManager.CustomMetric(message, "errorV" + version);
			} catch(error:Error) {
				// nada
			}
		}
		
		/**
		 * Call the given function on the next frame.
		 */
		public static function onNextFrame(func:Function, numFramesToWait:int = 1):void
		{
			if (func == null) {
				Utils.logError("Null func in onNextFrame");
				return;
			}
			
			var framesSkipped:int = 0;
			
			var enterFrame:Function = function(...ig):void {
				framesSkipped++;
				// we actually wait 2 frames minimum, but this is what it takes..?
				if (framesSkipped > numFramesToWait) {
					Main.removeStageEventListener(Event.ENTER_FRAME, enterFrame);
					func();
				}
			};
			
			Main.addStageEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		/**
		 * Display the current memory usage.
		 */
		public static function logMemory(message:String = "Current memory"):void
		{
			try {
				var privateMem:String = Number(System.privateMemory / 1024 / 1024).toFixed(2) + "mb";
				var totalMem:String = "" + int(System.totalMemory / 1024 / 1024);
				var wrapperMem:String = "" + int((System.privateMemory - System.totalMemory) / 1024 / 1024);
				var differenceMem:String = Number((System.privateMemory - lastMemory) / 1024 / 1024).toFixed(2) + "mb";
				differenceMem = (differenceMem.charAt(0) == "-") ? differenceMem : "+" + differenceMem;
				Utils.log(differenceMem + " " + message + " " + privateMem + "(" + totalMem + " + " + wrapperMem + ")");
				lastMemory = System.privateMemory;
			} catch(error:Error) {
				Utils.log("Failed to log memory.");
			}
		}

		/**
		 * Force garbage collection. Sometimes this crashes ADL unless it's done on the
		 * next frame. GC runs at the end of the frame, then output totals on the next frame.
		 */
		public static function garbageCollect():void
		{
			// System.gc does nothing in production and may cause instability
			if (!Config.DEBUG_MODE) {
				return;
			}
			onNextFrame(startGarbageCollect);
		}
		
		protected static function startGarbageCollect(...ig):void
		{
			Utils.log("Forcing garbage collection(debug only)");
			logMemory("\tOld mem");
			System.gc();
			onNextFrame(function():void {
				logMemory("\tNew mem");
			});
		}
		
		/**
		 * For debugging, output the number of milliseconds since the last time this function
		 * was called.
		 */
		public static function logTimeMark(markName:String = "default",
			forceStart:Boolean = false):void
		{
			var date:Date = new Date();
			var oldTime:int = markTimes[markName];
			if (oldTime == 0 || forceStart) {
				markTimes[markName] = date.getTime();
				log("Mark " + markName + " - start.");
				return;
			}
			
			// clear the mark start
			markTimes[markName] = null;
			var millisSince:int = date.getTime() - oldTime;
			log("Mark " + markName + " - end after " + millisSince + " ms.");
		}
		
		public static function addCommasToNumber(number:Number):String {
			var negNum:String = "";
			if (number < 0) {
				negNum = "-";
				number = Math.abs(number);
			}
			var num:String = String(number);
			var results:Array = num.split(/\./);
			num = results[0];
			if (num.length > 3) {
				var mod:Number = num.length%3;
				var output:String = num.substr(0, mod);
				for (var i:Number = mod; i<num.length; i += 3) {
					output += ((mod == 0 && i == 0) ? "" : ",")+num.substr(i, 3);
				}
				if (results.length>1) {
					if(results[1].length == 1) {
						return negNum+output+"."+results[1]+"0";
					}else{
						return negNum+output+"."+results[1];
					}
				}else{
					return negNum+output;
				}
			}

			if(results.length>1){
				if(results[1].length == 1){
					return negNum+num+"."+results[1]+"0";
				}else{
					return negNum+num+"."+results[1];
				}
			}else{
				return negNum + num;
			}
		}
		

		/** For outputting changes in system mem */
		protected static var lastMemory:Number = 0;
		
		/** Collection of timestamps for calculating time passed */
		protected static var markTimes:Dictionary = new Dictionary // of int by String
		
		public static const NO_TRANSFORM:ColorTransform = new ColorTransform();
		public static const GREY_TRANSFORM:ColorTransform = new ColorTransform(.5, .5, .5, 1, 100, 100, 100, 0);
		public static const DARKEN_TRANSFORM:ColorTransform = new ColorTransform(0.5, 0.5, 0.5, 1, 0, 0, 0, 0);
		public static const BRIGHTEN_TRANSFORM:ColorTransform = new ColorTransform(1.15, 1.15, 1.15, 1, 0, 0, 0, 0);
	}
}