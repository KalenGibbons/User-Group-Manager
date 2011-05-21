package com.ortusSolutions.userGroupManager.model{
	
	import com.ortusSolutions.userGroupManager.config.Settings;
	
	import mx.collections.ArrayCollection;
	import mx.formatters.DateFormatter;
	
	[Bindable]
	[RemoteClass(alias="model.beans.Meeting")]
	[Entity]
	public class Meeting extends BaseVO{
		
		// database fields
		[Id]
		public var id:int;
		public var topic:String;
		public var date:Date;
		
		[ManyToMany(targetEntity="Person")]
		[JoinTable(name="meetingPresenters")]
		[JoinColumn(name="meeting",referencedColumnName="id")]
		[InverseJoinColumn(name="presenter",referencedColumnName="id")]
		public var presenters:ArrayCollection;
		
		[ManyToMany(targetEntity="Person")]
		[JoinTable(name="meetingAttendees")]
		[JoinColumn(name="meeting",referencedColumnName="id")]
		[InverseJoinColumn(name="attendee",referencedColumnName="id")]
		public var attendees:ArrayCollection;
		
		[OneToMany(targetEntity="Raffle", mappedBy="raffle")]
		public var raffles:ArrayCollection;
		
		// custom properties
		private var dateFormatter:DateFormatter;
		
		public function Meeting(){
			super();
			date = new Date();
			dateFormatter = new DateFormatter();
			dateFormatter.formatString = Settings.DATE_FORMAT_LONG;
		}// end constructor
		
		public function get formattedDate():String{
			return dateFormatter.format(this.date);
		}// end formattedDate getter
		
	}// end Person class
	
}// end package enclosure