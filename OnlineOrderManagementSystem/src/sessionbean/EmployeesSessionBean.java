package sessionbean;

import java.math.BigInteger;
import java.util.List;

import javax.ejb.EJBException;
import javax.ejb.Stateless;
import javax.inject.Inject;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import domain.Employee;
import domain.Office;
import sessionbean.OfficeSessionBean;
import sessionbean.OfficeSessionBeanLocal;

/**
 * Session Bean implementation class EmployeesSessionBean
 */
@Stateless
public class EmployeesSessionBean implements EmployeesSessionBeanLocal {

	private static final Class Office = null;

	/**
	 * Default constructor.
	 */
	public EmployeesSessionBean() {
		// TODO Auto-generated constructor stub
	}

	@PersistenceContext(unitName = "OnlineOrderManagementSystem")
	EntityManager em;

	public List<Employee> getAllEmployees() throws EJBException {
		// Write some codes here…
		System.out.println("-------------------" + em.hashCode());
		return em.createNamedQuery("Employee.findAll").getResultList();

	}

	public List<Employee> readEmployee(int currentPage, int recordsPerPage) throws EJBException {
		// Write some codes here…
		int start = currentPage * recordsPerPage - recordsPerPage;
		Query q = em.createNativeQuery("SELECT * FROM classicmodels.employees ORDER BY id OFFSET ? LIMIT ?",
				Employee.class);
		q.setParameter(1, start);
		q.setParameter(2, recordsPerPage);
		List<Employee> results = q.getResultList();
		return results;
	}

	public int getNumberOfRows() throws EJBException {
		// Write some codes here…
		Query q = em.createNativeQuery("SELECT COUNT(*) FROM classicmodels.employees");
		BigInteger results = (BigInteger) q.getSingleResult();
		int i = results.intValue();
		return i;
	}

	public Employee findEmployee(String employeeNumber) throws EJBException {
		// Write some codes here…
		Query q = em.createNamedQuery("Employee.findbyId");
		q.setParameter("employeenumber", Integer.valueOf(employeeNumber));
		return (Employee) q.getSingleResult();
	}

	public void updateEmployee(String[] s) throws EJBException {
		// Write some codes here…

		Employee e = findEmployee(s[0]);
		e.setLastname(s[1]);
		e.setFirstname(s[2]);
		e.setExtension(s[3]);
		e.setEmail(s[4]);
		// The relevant office is fetched with no problems
		Query q = em.createNamedQuery("Office.findbyId");
		System.out.println(s[5]);
		q.setParameter("officecode", Integer.valueOf(s[5]));
		Office ex = (Office) q.getSingleResult();
		
		// must set updateable in Entity class to True
		e.setOffice(ex);
		e.setReportsto(s[6]);
		e.setJobtitle(s[7]);
		em.merge(e);
	}

	public List<Office> getOffices() {
		Query q = em.createNamedQuery("Office.findAll");
		return q.getResultList();

	}

	public void deleteEmployee(String employeeNumber) throws EJBException {
		// Write some codes here
		Employee e = findEmployee(employeeNumber);
		em.remove(e);
	}

	public void addEmployee(String[] s) throws EJBException {
		// Write some codes here…
		Employee e = new Employee();
		e.setEmployeenumber(getNumberOfRows() + 1);
		e.setLastname(s[1]);
		e.setFirstname(s[2]);
		e.setExtension(s[3]);
		e.setEmail(s[4]);
		// The relevant office is fetched with no problems
		Query q = em.createNamedQuery("Office.findbyId");
		System.out.println(s[5]);
		q.setParameter("officecode", Integer.valueOf(s[5]));
		Office ex = (Office) q.getSingleResult();
		System.out.println("---------THIS IS My OFFICE: " + e.getEmployeenumber() + " " + ex.getOfficecode() + " " + ex.getCity() + " " + ex.getAddressline1());
		// must set updateable in Entity class to True
		
		e.setOffice(ex);
		e.setReportsto(s[6]);
		e.setJobtitle(s[7]);
		em.persist(e);
	}
}
