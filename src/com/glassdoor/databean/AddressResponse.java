package com.glassdoor.databean;

public class AddressResponse {

	private Component component;
	private String delivery_line_1;
	private String last_line;
	
	public Component getComponent() {
		return component;
	}
	public void setComponent(Component component) {
		this.component = component;
	}
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
	
}
