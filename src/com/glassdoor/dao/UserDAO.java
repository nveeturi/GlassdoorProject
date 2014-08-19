/**
 * 
 */
package com.glassdoor.dao;

import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.glassdoor.databean.HibernateUtil;
import com.glassdoor.databean.User;

/**
 * @author jes2ica
 *
 */
public class UserDAO {
	
	public static Logger logger = Logger.getLogger(UserDAO.class);
	
	public void addUser(String userName, String password) {
		logger.info("addUser method initiated");
		HibernateUtil util = HibernateUtil.getInstance();
		@SuppressWarnings("static-access")
		Session session = util.getSessionFactory().openSession();
		Transaction tr = session.beginTransaction();
		User user = new User();
		user.setUserName(userName);
		user.setPassword(password);
		session.save(user);
		tr.commit();
		session.close();
		logger.info("addUser method ended");
	}

}
