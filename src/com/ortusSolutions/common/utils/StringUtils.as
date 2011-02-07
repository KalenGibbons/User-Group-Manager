package com.ortusSolutions.common.utils{
	
	/**
	 * The StringUtils class provides a common set of static methods that are useful when working
	 * with Strings in Flex. The StringUtils class is an all-static class, meaning that you do not 
	 * need to create instances of StringUtils, instead call static methods such as the 
	 * <code>StringUtils.capitalize()</code> method.
	 */	
	public class StringUtils{
		
		/**
		 * Capitalizes the first letter of every word in the specified String and makes all
		 * other characters lowercase.  It also ignores certain words that are typically should
		 * not be capitalized such as ('and/the/in/at/or/etc).
		 * 
		 * @param string The String that should be capitalized.
		 * @param firstWordOnly
		 * @return A restriction flag which capitalizes only the first word in the sentence.
		 */		 
		public static function capitalize(string:String, firstWordOnly:Boolean = false):String{
			if(string == null) return "";
			
			if(!firstWordOnly){
				var allWords:Array = string.split(" ");
				var wordsToIgnore:Array = ["and","for","the","in","an","or","at","of","a"];
				var returnString:String = "";
				for each(var word:String in allWords){
					// capitalize all words except those in the wordsToIgnore Array
					// however, words at the beginning or end of a title are ALWAYS capitalized
					if(	wordsToIgnore.indexOf(word.toLowerCase()) == -1 || 
						allWords.indexOf(word) == 0 ||
						allWords.indexOf(word) == allWords.length-1){
						returnString += " " + word.substr(0, 1).toUpperCase() + word.substring(1).toLowerCase();
					}else{
						returnString += " " + word.toLowerCase();
					}
				}
				return returnString.substring(1);//remove leading space
			}else{
				return string.substr(0,1).toUpperCase() + string.substring(1);
			}
		}//end capitalize function
		
		/**
		 * Takes any String and turns it into URL-safe slug value. All letters are set to 
		 * lowercase and all special characters are removed.  Spaces are replaced with
		 * dashes (-).
		 * 
		 * @param value The String in which to slugify
		 * @return A slugified version of the original String
		 */		
		public static function slugify(value:String):String{
			if(value == null) return "";
			var slug:String = trim(value.toLowerCase());
			// convert all spaces to dashes
			slug = slug.replace(/[\s]/g, "-");
			// remove all non-standard characters
			slug = slug.replace(/[^a-z0-9-]/g, "");
			// trim any double dashes
			slug = slug.replace(/-{2,}/g, "-");
			// remove an beginning or ending dashes
			slug = slug.replace(/^-|-$/g, "");
			return slug;
		}//end slugify function
		
		
		/**
		 * Removes all whitespace characters from the beginning and end of the specified string.
		 * 
		 * @param value The String whose whitespace should be trimmed. 
		 * @return Updated String where whitespace was removed from the beginning and end. 
		 */
		public static function trim(value:String):String{
			value = (value) ? value.replace(/^\s+|\s+$/g, "") : "";
			return value;
		}//end trim function
		
		/**
		 * Removes excess line breaks (and character returns) from a String.
		 * 
		 * @param source The String in which to remove excess line breaks
		 * @param maxLineBreaksAllowable The maximum number of line breaks allowable before they
		 * are replaced.  The group of line breaks will only be replaced once, each line break
		 * will not be replaced individually.
		 * @param replaceWith The value to replace all line break groups exceeding the 
		 * allowable limit.
		 * @return The source String with the line breaks replaced with the specified value.
		 * 
		 */		
		public static function removeLineBreaks(source:String, maxLineBreaksAllowable:int=2, replaceWith:String=""):String{
			// if source is null return an empty string
			if(source == null) return "";
			// create regular expressions and run it on the source String
			var regexString:String = "[\r|\n|\r\n]{" + (maxLineBreaksAllowable+1) + ",}";
			var regex:RegExp = new RegExp(regexString, "g");
			return source.replace(regex, replaceWith);
		}//end removeLineBreaks function
		
		/**
		 * Combines a number of String elements, separating each valid element with the
		 * separator provided.  Null and empty String values will be ignored and will
		 * not be added to the returned String 
		 * 
		 * @param separator The value used to separate all valid String values
		 * @param rest A list of String values to be separated
		 * @return A list String of all valid values, separated by the value provided.
		 */		
		public static function combineText(separator:String=",", ...rest):String{
			var value:String = "";
			for each(var item:Object in rest){
				if(item is String && item.length > 0){
					value += trim(item as String) + separator;
				}
			}
			return value.substring(0, value.length-separator.length);
		} // end combineText function
		
	}//end StringUtils class
	
}//end package declaration