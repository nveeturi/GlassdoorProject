package com.glassdoor.databean;

public class TravelTimeWS {
	int seconds;
	String destination;
	boolean unroutable;

	public int getSeconds() {
		return seconds;
	}

	public void setSeconds(int seconds) {
		this.seconds = seconds;
	}

	public String getDestination() {
		return destination;
	}

	public void setDestination(String destination) {
		this.destination = destination;
	}

	public boolean isUnroutable() {
		return unroutable;
	}

	public void setUnroutable(boolean unroutable) {
		this.unroutable = unroutable;
	}

}
