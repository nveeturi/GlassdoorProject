package com.glassdoor.databean;

public class Metadata {

	private String county_fips;
	private String county_name;
	private double latitude;
	private double longitude;
	
	public String getCounty_fips() {
		return county_fips;
	}
	public void setCounty_fips(String county_fips) {
		this.county_fips = county_fips;
	}
	public String getCounty_name() {
		return county_name;
	}
	public void setCounty_name(String county_name) {
		this.county_name = county_name;
	}
	public double getLatitude() {
		return latitude;
	}
	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}
	public double getLongitude() {
		return longitude;
	}
	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}
	
	
}
