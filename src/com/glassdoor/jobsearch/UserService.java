/**
 * 
 */
package com.glassdoor.jobsearch;

import org.apache.log4j.Logger;

import com.glassdoor.dao.UserDAO;

/**
 * @author jes2ica
 *
 */
public class UserService {
	
	private UserDAO userDao;
	public static Logger logger = Logger.getLogger(JobSearchService.class);
	
	public void addUser(String username, String password) {
		userDao.addUser(username, password);
	}
	public void setUserDao(UserDAO userDao) {
		this.userDao = userDao;
	}
}
