package com.glassdoor.databean;

public class TravelTimeListing {
	private String[] destination_addresses;
	private String[] origin_addresses;
	private TravelTimeResponse[] rows;
	private String status;
	public String[] getDestination_addresses() {
		return destination_addresses;
	}
	public void setDestination_addresses(String[] destination_addresses) {
		this.destination_addresses = destination_addresses;
	}
	public String[] getOrigin_addresses() {
		return origin_addresses;
	}
	public void setOrigin_addresses(String[] origin_addresses) {
		this.origin_addresses = origin_addresses;
	}
	public TravelTimeResponse[] getRows() {
		return rows;
	}
	public void setRows(TravelTimeResponse[] rows) {
		this.rows = rows;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	
	
}
