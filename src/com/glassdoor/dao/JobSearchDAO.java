package com.glassdoor.dao;

import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.NonUniqueObjectException;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.glassdoor.databean.Geocode;
import com.glassdoor.databean.HibernateUtil;
import com.glassdoor.databean.JobDetails;

public class JobSearchDAO {
	
	public static Logger logger = Logger.getLogger(JobSearchDAO.class);

	public JobDetails getJobDetailsForSearch(String jobId) {
		HibernateUtil util = HibernateUtil.getInstance();
		JobDetails details = null;
		@SuppressWarnings("static-access")
		Session session = util.getSessionFactory().openSession();
		@SuppressWarnings("unchecked")
		List<JobDetails> results = session.createQuery(
				"from JobDetails where jobId =" + jobId).list();

		if (!(results == null || results.size() == 0)) {
			details = results.get(0);
		}
		session.close();
		return details;

	}

	public List<JobDetails> getJobetailsFromDB() {
		HibernateUtil util = HibernateUtil.getInstance();
		JobDetails details = null;
		@SuppressWarnings("static-access")
		Session session = util.getSessionFactory().openSession();
		@SuppressWarnings("unchecked")
		List<JobDetails> results = session.createQuery("from JobDetails")
				.list();
		session.close();
		return results;

	}

	public void insertJobDetails(List<JobDetails> jobdetails) {

		logger.info("insertJobDetails method initiated");
		HibernateUtil util = HibernateUtil.getInstance();
		Session session = util.getSessionFactory().openSession();
		Transaction tx = session.beginTransaction();

		for (int i = 0; i < jobdetails.size(); i++) {

			try {

				JobDetails job = (JobDetails) jobdetails.get(i);
			/*	System.out.println("object no. " + i + "1 " + job.getJobId()
						+ "2 " + job.getCompanyName() + "3 " + job.getCity()
						+ " 4" + job.getZipCode() + "5 " + job.getCountry());*/

				session.saveOrUpdate(job);
				if (i % 20 == 0) { // 20, same as the JDBC batch size
					// flush a batch of inserts and release memory:
					session.flush();
					session.clear();
				}

			} catch (NonUniqueObjectException nue) {
				logger.error(nue.getMessage());
				continue;
			} catch (Exception e) {
				logger.error(e.getMessage());
				continue;
			}

		}
		tx.commit();
		session.close();
		logger.info("Object saved successfully!");

	}

	public List<JobDetails> getCBJobDetails() {
		
		HibernateUtil util = HibernateUtil.getInstance();
		List<JobDetails> details = null;
		@SuppressWarnings("static-access")
		Session session = util.getSessionFactory().openSession();
		@SuppressWarnings("unchecked")
		List<JobDetails> results = session.createQuery(
				"from JobDetails where source= 'CareerBuilder'").list();

		if (!(results == null || results.size() == 0)) {
			details = results;
		}
		session.close();
		return details;
	}

	public List<JobDetails> getJobDetailsWithNoLocation() {
		
		logger.info("getJobDetailsWithNoLocation method initiated");
		HibernateUtil util = HibernateUtil.getInstance();
		List<JobDetails> details = null;
		@SuppressWarnings("static-access")
		Session session = util.getSessionFactory().openSession();
		@SuppressWarnings("unchecked")
		List<JobDetails> results = session
				.createQuery(
						"from JobDetails where (latitude is null OR longitude is  null) and city = 'Pittsburgh'").list();
		if (!(results == null || results.size() == 0)) {
			details = results;
			logger.info("Number of records to be processed are: "+details.size());
		}
		logger.info("getJobDetailsWithNoLocation method ended");
		session.close();
		return details;

	}
	
	public List<JobDetails> getJobsForIds(String jobIds) {

		HibernateUtil util = HibernateUtil.getInstance();
		List<JobDetails> details = null;
		@SuppressWarnings("static-access")
		Session session = util.getSessionFactory().openSession();
		System.out.println("jobIds" + jobIds);
		@SuppressWarnings("unchecked")
		List<JobDetails> results = session.createQuery(
				"from JobDetails where jobId IN (" + jobIds + ")").list();
		if (!(results == null || results.size() == 0)) {
			details = results;
		}
		session.close();
		return details;

	}

	public List<JobDetails> getLatLong(List<JobDetails> details) {
		// get all the job id in details list
		StringBuffer jobIds = new StringBuffer();

		for (JobDetails i : details) {
			jobIds.append(i.getJobId() + ",");
		}
		jobIds.deleteCharAt(jobIds.length() - 1);

		// get all the lat long record from database
		HibernateUtil util = HibernateUtil.getInstance();
		List<JobDetails> latlongs = null;
		@SuppressWarnings("static-access")
		Session session = util.getSessionFactory().openSession();
		@SuppressWarnings("unchecked")
		List<JobDetails> results = session
				.createQuery(
						"from JobDetails where latitude is not null AND longitude is not null AND jobId IN ("
								+ jobIds + ")").list();
		session.close();

		return results;

	}

	public String getLatLongForCity(String city) {
		HibernateUtil util = HibernateUtil.getInstance();
		@SuppressWarnings("static-access")
		Session session = util.getSessionFactory().openSession();
		logger.info("getLatLongForCity method initiated");
		@SuppressWarnings("unchecked")
		List<Geocode> results = (List<Geocode>) session
				.createQuery(
						"from Geocode where city ='"+city+"'").list();
		session.close();
		if(results != null && results.size() != 0){
			logger.info("Lat/Long for city "+ city+" is found in database "+results.get(0).getLatlong());
			return results.get(0).getLatlong();
		}
		return "";

	}
	
	public void insertLatLongForCity(String city, String latlong) {
		logger.info("insertLatLongForCity method initiated");
		HibernateUtil util = HibernateUtil.getInstance();
		@SuppressWarnings("static-access")
		Session session = util.getSessionFactory().openSession();
		Transaction tx = session.beginTransaction();
		Geocode geo = new Geocode();
		geo.setCity(city);
		geo.setLatlong(latlong);
		session.saveOrUpdate(geo);
		tx.commit();
		session.close();
		logger.info("insertLatLongForCity method ended");
	}

	public List<JobDetails> getJobetailsInCity(String location) {
		logger.info("getJobetailsInCity method initiated");
		HibernateUtil util = HibernateUtil.getInstance();
		List<JobDetails> details = null;
		@SuppressWarnings("static-access")
		Session session = util.getSessionFactory().openSession();
		@SuppressWarnings("unchecked")
		List<JobDetails> results = session
				.createQuery(
						"from JobDetails where (latitude is not null or longitude is not null) and lower(city) = '"+location.toLowerCase()+"'").list();
		if (!(results == null || results.size() == 0)) {
			details = results;
			logger.info("Number of records to be processed are: "+details.size());
		}
		logger.info("getJobetailsInCity method ended");
		session.close();
		return details;
		
	}

}
