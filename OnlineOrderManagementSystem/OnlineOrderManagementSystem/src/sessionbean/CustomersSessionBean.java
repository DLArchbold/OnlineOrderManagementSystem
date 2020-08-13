package sessionbean;

import java.math.BigInteger;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.math.BigDecimal;

import javax.ejb.EJBException;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import domain.Customer;
import domain.Employee;
import domain.Office;

/**
 * Session Bean implementation class CustomersSessionBean
 */
@Stateless
public class CustomersSessionBean implements CustomersSessionBeanLocal {

	/**
	 * Default constructor.
	 */
	public CustomersSessionBean() {
		// TODO Auto-generated constructor stub
	}

	@PersistenceContext(unitName = "OnlineOrderManagementSystem")
	EntityManager em;

	public List<Customer> getAllCustomers() throws EJBException {
		// Write some codes here…
		System.out.println("-------------------" + em.hashCode());
		return em.createNamedQuery("Customer.findAll").getResultList();

	}

	public List<Customer> readCustomer(int currentPage, int recordsPerPage) throws EJBException {
		// Write some codes here…
		int start = currentPage * recordsPerPage - recordsPerPage;
		Query q = em.createNativeQuery("SELECT * FROM classicmodels.customers ORDER BY cutsomernumber OFFSET ? LIMIT ?",
				Customer.class);
		q.setParameter(1, start);
		q.setParameter(2, recordsPerPage);
		List<Customer> results = q.getResultList();
		return results;
	}

	public int getNumberOfRows() throws EJBException {
		// Write some codes here…
		Query q = em.createNativeQuery("SELECT COUNT(*) FROM classicmodels.customers");
		BigInteger results = (BigInteger) q.getSingleResult();
		int i = results.intValue();
		return i;
	}

	public Customer findCustomer(String customerNumber) throws EJBException {
		// Write some codes here…
		Query q = em.createNamedQuery("Customer.findbyId");
		q.setParameter("customernumber", Integer.valueOf(customerNumber));
		return (Customer) q.getSingleResult();
	}

	public void updateCustomer(String[] s) throws EJBException {
		// Write some codes here…

		Customer e = findCustomer(s[0]);
		e.setCustomername(s[1]);
		e.setContactfirstname(s[2]);
		e.setContactlastname(s[3]);
		e.setPhone(s[4]);
		e.setAddressline1(s[5]);
		e.setAddressline2(s[6]);
		e.setCity(s[7]);
		e.setState(s[8]);
		e.setPostalcode(s[9]);
		e.setCountry(s[10]);

		// The relevant employee is fetched with no problems
		Query q = em.createNamedQuery("Employee.findbyId");
		System.out.println(s[11]);
		q.setParameter("employeenumber", Integer.valueOf(s[11]));
		Employee ex = (Employee) q.getSingleResult();
		// must set updateable in Entity class to True
		e.setEmployee(ex);
		// Credit limit takes BigDecimal
		e.setCreditlimit(BigDecimal.valueOf(Double.valueOf(s[12])));
		em.merge(e);
	}

	public List<Employee> getEmployees() {
		Query q = em.createNamedQuery("Employee.findAll");
		return q.getResultList();

	}

	public void deleteCustomer(String customerNumber) throws EJBException {
		// Write some codes here
		Customer e = findCustomer(customerNumber);
		em.remove(e);
	}

	public void addCustomer(String[] s) throws EJBException {
		// Write some codes here…
		int lastID = getLastID(getAllCustomers());
		
		Customer e = new Customer();
		e.setCustomernumber(lastID+1);
		e.setCustomername(s[1]);
		e.setContactfirstname(s[2]);
		e.setContactlastname(s[3]);
		e.setPhone(s[4]);
		e.setAddressline1(s[5]);
		e.setAddressline2(s[6]);
		e.setCity(s[7]);
		e.setState(s[8]);
		e.setPostalcode(s[9]);
		e.setCountry(s[10]);
		// The relevant employee is fetched with no problems
		Query q = em.createNamedQuery("Employee.findbyId");
		System.out.println(s[11]);
		q.setParameter("employeenumber", Integer.valueOf(s[11]));
		Employee ex = (Employee) q.getSingleResult();
		// must set updateable in Entity class to True
		e.setEmployee(ex);
		// Credit limit takes BigDecimal
		e.setCreditlimit(BigDecimal.valueOf(Double.valueOf(s[12])));
		em.persist(e);
	}
	
	public int getLastID(List<Customer> allCust) {
		Collections.sort(allCust, new Comparator<Customer>() {
			
	 		@Override
	 		public int compare(Customer a, Customer b) {
	 			return Integer.compare(a.getCustomernumber(), b.getCustomernumber());
	 		}
	
	 	});
		return allCust.get(allCust.size()-1).getCustomernumber();
		
	}
}
