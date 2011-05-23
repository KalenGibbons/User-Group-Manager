package com.ortusSolutions.userGroupManager.model{
	
	import com.ortusSolutions.userGroupManager.config.Settings;
	import com.ortusSolutions.userGroupManager.vo.RaffleType;
	
	import mx.formatters.DateFormatter;
	
	[Bindable]
	[RemoteClass(alias="model.beans.Raffle")]
	[Entity]
	public class Raffle extends BaseVO{
		
		// database fields
		[Id]
		public var id:int;
		public var date:Date;
		public var raffleType:int = RaffleType.MEETING_RAFFLE;
		public var winner:Person;
		// custom fields
		public var eligibleMembers:Array;
		public var pendingSave:Boolean = false;

		private var dateFormatter:DateFormatter;
		private var _prize:String = "";
		
		public function Raffle(){
			super();
			dateFormatter = new DateFormatter();
			dateFormatter.formatString = Settings.DATE_FORMAT_LONG;
		}// end constructor
		
		public function get prize():String{
			return (this.raffleType == RaffleType.QUICK_RAFFLE) ? "Quick Raffle" : this._prize;
		}// end prize getter
		
		public function set prize(value:String):void{
			this._prize = value;
		}// end prize setter
		
		public function get formattedDate():String{
			return dateFormatter.format(this.date);
		}// end formattedDate getter
		
	}// end Raffle class
	
}// end package enclosure