package sessionbean;

import java.math.BigInteger;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.ejb.EJBException;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import domain.Office;

/**
 * Session Bean implementation class OfficeSessionBean
 */
@Stateless
public class OfficeSessionBean implements OfficeSessionBeanLocal {

	/**
	 * Default constructor.
	 */
	public OfficeSessionBean() {
		// TODO Auto-generated constructor stub
	}

	@PersistenceContext(unitName = "OnlineOrderManagementSystem")
	EntityManager em;

	public List<Office> getAllOffices() throws EJBException {
		// Write some codes here…
		return em.createNamedQuery("Office.findAll").getResultList();
	}

	public List<Office> readOffice(int currentPage, int recordsPerPage) throws EJBException {
		// Write some codes here…
		int start = currentPage * recordsPerPage - recordsPerPage;
		Query q = em.createNativeQuery("SELECT * FROM classicmodels.office ORDER BY id OFFSET ? LIMIT ?", Office.class);
		q.setParameter(1, start);
		q.setParameter(2, recordsPerPage);
		List<Office> results = q.getResultList();
		return results;
	}

	public int getNumberOfRows() throws EJBException {
		// Write some codes here…
		Query q = em.createNativeQuery("SELECT COUNT(*) FROM classicmodels.offices");
		BigInteger results = (BigInteger) q.getSingleResult();
		int i = results.intValue();
		return i;
	}

	public Office findOffice(String officeCode) throws EJBException {
		// Write some codes here…
		
		Query q = em.createNamedQuery("Office.findbyId");
		q.setParameter("officecode", Integer.valueOf(officeCode));
		return (Office) q.getSingleResult();
	}
	

	public void updateOffice(String[] s) throws EJBException {
		// Write some codes here…

		Office e = findOffice(s[0]);
		e.setCity(s[1]);
		e.setPhone(s[2]);
		e.setAddressline1(s[3]);
		e.setAddressline2(s[4]);
		e.setState(s[5]);
		e.setCountry(s[6]);
		e.setPostalcode(s[7]);
		e.setTerritory(s[8]);
		em.merge(e);

	}

	public void deleteOffice(String officeCode) throws EJBException {
		// Write some codes here…
		Office e = findOffice(officeCode);
		em.remove(e);
	}

	public void addOffice(String[] s) throws EJBException {
		// Write some codes here…
		Office e = new Office();
		e.setOfficecode(getNumberOfRows() + 1);
		e.setCity(s[1]);
		e.setPhone(s[2]);
		e.setAddressline1(s[3]);
		e.setAddressline2(s[4]);
		e.setState(s[5]);
		e.setCountry(s[6]);
		e.setPostalcode(s[7]);
		e.setTerritory(s[8]);
		em.persist(e);
	}

}

