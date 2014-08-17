package com.glassdoor.databean;

public class ResultsWS {
String origin;
String mode;
TravelTimeWS[] travel_times;
public String getOrigin() {
	return origin;
}
public void setOrigin(String origin) {
	this.origin = origin;
}
public String getMode() {
	return mode;
}
public void setMode(String mode) {
	this.mode = mode;
}
public TravelTimeWS[] getTravel_times() {
	return travel_times;
}
public void setTravel_times(TravelTimeWS[] travel_times) {
	this.travel_times = travel_times;
}

}
