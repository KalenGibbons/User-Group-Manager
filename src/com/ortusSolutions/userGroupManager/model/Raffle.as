package com.ortusSolutions.userGroupManager.model{
	
	import com.ortusSolutions.userGroupManager.config.Settings;
	import com.ortusSolutions.userGroupManager.vo.RaffleType;
	
	import mx.formatters.DateFormatter;
	
	[Bindable]
	[RemoteClass(alias="model.beans.Raffle")]
	[Entity]
	[Table(name="raffles")]
	public class Raffle extends BaseVO{
		
		// database fields
		[Id]
		[GeneratedValue(strategy="INCREMENT")]
		public var id:int;
		public var date:Date;
		public var raffleType:int = RaffleType.MEETING_RAFFLE;
		
		[ManyToOne(targetEntity="com.ortusSolutions.userGroupManager.model.Person")]
		[JoinColumn(name="winner")]
		public var winner:Person;
		
		// custom fields
		[Transient]
		public var eligibleMembers:Array;
		[Transient]
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
		
		[Transient]
		public function get formattedDate():String{
			return dateFormatter.format(this.date);
		}// end formattedDate getter
		
	}// end Raffle class
	
}// end package enclosure