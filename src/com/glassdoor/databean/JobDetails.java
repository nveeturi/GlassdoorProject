package com.glassdoor.databean;

public class JobDetails {
	
	private Long jobId;
	private String jobRefID;
	private String companyName;
	private String jobTitle;
	private String city;
	private String streetName1;
	private String streetName2;
	private String state;
	private String country;
	private String zipCode;
	private Double latitude;
	private Double longitude;
	private String jobLink;
	private String source;
	private String jobSourceLink;
	private String jobDescription;
	private double distance;
	private int driveTime;
	private int walkTime;
	private int busTime;
	private int bikeTime;
	private int minCommuteTime;
	
	
	public int getBusTime() {
		return busTime;
	}

	public void setBusTime(int busTime) {
		this.busTime = busTime;
	}



	public int getMinCommuteTime() {
		return minCommuteTime;
	}

	public void setMinCommuteTime(int minCommuteTime) {
		this.minCommuteTime = minCommuteTime;
	}

	public int getDriveTime() {
		return driveTime;
	}

	public void setDriveTime(int driveTime) {
		this.driveTime = driveTime;
	}


	public double getDistance() {
		return distance;
	}

	public void setDistance(double distance) {
		this.distance = distance;
	}

	public int getWalkTime() {
		return walkTime;
	}

	public void setWalkTime(int walkTime) {
		this.walkTime = walkTime;
	}

	public int getTransitTime() {
		return busTime;
	}

	public void setTransitTime(int transitTime) {
		this.busTime = transitTime;
	}

	public int getBikeTime() {
		return bikeTime;
	}

	public void setBikeTime(int bikeTime) {
		this.bikeTime = bikeTime;
	}
	//private String pageNumber;
	private Integer totalPages;
	
	public Long getJobId() {
		return jobId;
	}
	public void setJobId(Long jobId) {
		this.jobId = jobId;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getJobTitle() {
		return jobTitle;
	}
	public void setJobTitle(String jobTitle) {
		this.jobTitle = jobTitle;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getStreetName1() {
		return streetName1;
	}
	public void setStreetName1(String streetName1) {
		this.streetName1 = streetName1;
	}
	public String getStreetName2() {
		return streetName2;
	}
	public void setStreetName2(String streetName2) {
		this.streetName2 = streetName2;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getZipCode() {
		return zipCode;
	}
	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}
	public Double getLatitude() {
		return latitude;
	}
	public void setLatitude(Double latitude) {
		this.latitude = latitude;
	}
	public Double getLongitude() {
		return longitude;
	}
	public void setLongitude(Double longitude) {
		this.longitude = longitude;
	}
	public String getJobLink() {
		return jobLink;
	}
	public void setJobLink(String jobLink) {
		this.jobLink = jobLink;
	}
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	public String getJobRefID() {
		return jobRefID;
	}
	public void setJobRefID(String jobRefID) {
		this.jobRefID = jobRefID;
	}
	public String getJobSourceLink() {
		return jobSourceLink;
	}
	public void setJobSourceLink(String jobSourceLink) {
		this.jobSourceLink = jobSourceLink;
	}
	public String getJobDescription() {
		return jobDescription;
	}
	public void setJobDescription(String jobDescription) {
		this.jobDescription = jobDescription;
	}
	public Integer getTotalPages() {
		return totalPages;
	}
	public void setTotalPages(Integer pages) {
		this.totalPages = pages;
	}
	

}
