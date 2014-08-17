package com.glassdoor.databean;

public class AddressResponse {

	private String delivery_line_1;
	private String last_line;
	private Component components;
	private Metadata metadata;
	
	public String getDelivery_line_1() {
		return delivery_line_1;
	}
	public void setDelivery_line_1(String delivery_line_1) {
		this.delivery_line_1 = delivery_line_1;
	}
	public String getLast_line() {
		return last_line;
	}
	public void setLast_line(String last_line) {
		this.last_line = last_line;
	}
	public Component getComponents() {
		return components;
	}
	public void setComponents(Component components) {
		this.components = components;
	}
	public Metadata getMetadata() {
		return metadata;
	}
	public void setMetadata(Metadata metadata) {
		this.metadata = metadata;
	}
	
	
}
