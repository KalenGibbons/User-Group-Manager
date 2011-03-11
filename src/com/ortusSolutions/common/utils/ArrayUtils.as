package com.ortusSolutions.common.utils{
	
	import mx.formatters.DateFormatter;
	import mx.utils.ObjectUtil;
	
	/**
	 * The ArrayUtils class provides a common set of static methods that are useful when working
	 * with Arrays in Flex. The ArrayUtils class is an all-static class, meaning that you do not 
	 * need to create instances of ArrayUtils, instead call static methods such as the 
	 * <code>ArrayUtils.findInArray()</code> method.
	 */
	public class ArrayUtils{
		
		/**
		 * Finds an object, or a value of an object, in a specified Array. If no fieldName is specified
		 * in the arguments then each object in the array will be compared (==) to the value provided.
		 * If a fieldName is provided, then each object in the array will be inspected and the value
		 * of the field specified will be compared (==) instead.
		 * 
		 * <p>Only the index of the first match in the Array will be returned.  If no matches are found -1 is returned.</p>
		 * <p>For comparing Dates in an array, please use the <code>findDateInArray()</code> function.</p>
		 * 
		 * @param array The Array containing the object to compare.
		 * @param value  The value to look for within the Array.
		 * @param fieldName The property in each Array Object to be compared. If no value is specified,
		 * each object in the Array will be directly compared.
		 * @return The first index in the Array where a match was found, will otherwise return -1 if no matches were found.
		 * @see #findDateInArray()
		 */		
		public static function findInArray(array:Array, value:Object, fieldName:String=null):int{
			var arrayLen:int = array.length;
			for(var i:int = 0; i < arrayLen; i++){
				if(fieldName != null){
					if(array[i][fieldName] == value){ return i; }
				}else{
					if(array[i] == value){ return i; }
				}
			}
			return -1;
		}//end findInArray function
		
		/**
		 * Finds a Date value in an Array that contains the same Date value provided.  A fieldName is required 
		 * if the Array does not directly contain Date Objects, but objects that have a date property. 
		 * 
		 * <p>Only the index of the first match in the Array will be returned.  If no matches are found -1 is returned.</p>
		 * <p>For comparing all other types of data, please use the <code>findInArray()</code> function.</p>
		 * 
		 * @param array The Array container the Dates to compare
		 * @param date The Date value to look for within the Array
		 * @param fieldName The property in each Array Object to be compared. If no value is specified,
		 * each Object in the Array will be compared as a Date Object.
		 * @param dateFormat The DateTime format to be used in the comparison.  A value of "MM/DD/YY" will find an
		 * value that matches the provided Date, and the time of day will be ignored.  To compare date and time value
		 * provide a custom DateFormat.
		 * @return The first index in the Array where a match was found, will otherwise return -1 if no matches were found.
		 * @see #findInArray()
		 */		
		public static function findDateInArray(array:Array, date:Date, fieldName:String=null, dateFormat:String="MM/DD/YY"):int{
			var dateFormatter:DateFormatter = new DateFormatter();
			dateFormatter.formatString = dateFormat;
			var dateString:String = dateFormatter.format(date);
			var arrayLen:int = array.length;
			var item:Object;
			for(var i:int = 0; i < arrayLen; i++){
				item = (fieldName) ? array[i][fieldName] : array[i];
				if(dateFormatter.format(item) == dateString)
					return i;
			}
			return -1;
		}//end findInArray function
		
		
		/**
		 * Searches for a value in an Array and returns a separate property from the found object.
		 * <p>This is often useful when supplied ID values from a database and you need to do a lookup
		 * within an Array to determine the user-friendly label associated with that ID.</p>
		 * 
		 * @param array The Array containing the value to lookup and the field to return
		 * @param value The value to find in the Array based on the compareField
		 * @param compareField The property of the objects in the Array to use for value comparison
		 * @param labelField The property of objects in the Array that represent the label to return
		 * @return A String corresponding the label found, based on the value provided.  If no matching
		 * objects were found, an empty String ("") is returned.
		 */		
		public static function getLabelInArray(array:Array, value:Object, compareField:String, labelField:String):String{
			var arrayIndex:int = findInArray(array, value, compareField);
			if(arrayIndex > -1)
				return array[arrayIndex][labelField];
			else
				return "";
		}//end getLabelInArray function
		
		/**
		 * Removes duplicate items from an Array.  If a fieldName is provided, the method will return
		 * a distinct Array of those values, not the objects that they were part of.
		 * 
		 * @param array The original Array containing duplicate values
		 * @param fieldName In an Array of objects, it is the value of the object in which to return
		 * @param ignoreNulls Flag which specifies whether null values and empty strings should be excluded from the resulting array
		 * @return A new array containing only one instance of each item.
		 */		
		public static function getDistinctArray(array:Array, fieldName:String=null, ignoreNulls:Boolean=false):Array{
			var returnArray:Array = [];
			for each(var item:Object in array){
				var value:Object;
				if(fieldName)
					value = item[fieldName];
				else
					value = item;
				
				if(findInArray(returnArray, value) == -1){
					// ignore nulls and empty strings (if applicable)
					if(ignoreNulls && (value == null || (value is String && value.length==0))){
						continue;
					}else{
						returnArray.push(value);
					}
				}
			}
			return returnArray;
		}//end getDistinctArray function
		
		/**
		 * Returns the maximum numeric value found in an Array.  IF the Array contains objects,
		 * the field (property) must be provided that contains numeric values.
		 * 
		 * @param array The Array containing the values
		 * @param field In an Array of objects, it is the object property that contains the numeric value.
		 * @param returnWholeNumber If true, the maximum value will be rounded up to a integer value.
		 * @return The maximum value found in the Array.
		 */		
		public static function getMaxValue(array:Array, field:String="", returnWholeNumber:Boolean=true):Number{
			var max:Number = 0;				
			for each(var obj:Object in array){
				var value:Number = field.length ? obj[field] as Number : obj as Number;
				if(value && ObjectUtil.numericCompare(Number(value), max) > 0){
					max = value;
				}
			}
			if(returnWholeNumber)
				return Math.ceil(max);
			else
				return max;
		}//end getMaxValue function
		
		/**
		 * Provided an Array of Strings, will return the Array with each element properly capitalized.
		 * 
		 * @param array An Array of Strings
		 * @return
		 */		
		public static function capitalizeArray(array:Array):Array{
			var arrayLen:int = array.length;
			for(var i:int=0; i<arrayLen; i++){
				array[i] = StringUtils.capitalize(array[i]);
			}
			return array;
		}//end capitalizeArray function
		
		/**
		 * Trims every value in an Array.
		 * 
		 * @param array The Array of String to trim
		 * @return An Array of trimmed values
		 */	   	
		public static function trimArray(array:Array):Array{
			var tempArray:Array = [];
			for each(var value:Object in array){
				if(value is String)
					tempArray.push(value.replace(/^\s+|\s+$/g, ""));
			}
			return tempArray;
		}// end trimArray function
		
		/**
		 * Turns an Array of values into a delimited list.
		 *  
		 * @param array The Array of values to transform into a list of values
		 * @param delimiter The delimiter to separate each value
		 * @param fieldName In an Array of objects, it is the object property to add to the list
		 * @param removeBlanks If true, empty values will be ignored
		 * @return A delimited list of values from the original Array
		 */	   	
		public static function getDelimitedList(array:Array, delimiter:String=", ", fieldName:String=null, removeBlanks:Boolean=true):String{
			var list:String = "";
			for each(var item:Object in array){
				var value:String = StringUtils.trim(String((fieldName) ? item[fieldName] : item));
				if(!removeBlanks || value.length > 0)
					list += value + delimiter;
			}
			return list.substring(0, list.length-delimiter.length);
		}// end getDelimitedList function
		
	}//end ArrayUtils class
	
}//end package enclosure