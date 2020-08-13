package sessionbean;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.List;

import javax.ejb.EJBException;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import domain.Productline;

/**
 * Session Bean implementation class ProductLineSessionBean
 */
@Stateless
public class ProductLineSessionBean implements ProductLineSessionBeanLocal {

	@PersistenceContext(unitName = "OnlineOrderManagementSystem")
	EntityManager em;
	
    /**
     * Default constructor. 
     */
    public ProductLineSessionBean() {
        // TODO Auto-generated constructor stub
    }
    
    public List<Productline> getAllProductlines() throws EJBException {
		// Write some codes here…
		return em.createNamedQuery("Productline.findAll").getResultList();
	}

	public List<Productline> readProductline(int currentPage, int recordsPerPage) throws EJBException {
		// Write some codes here…
		int start = currentPage * recordsPerPage - recordsPerPage;
		Query q = em.createNativeQuery("SELECT * FROM classicmodels.productlines ORDER BY productline OFFSET ? LIMIT ?", Productline.class);
		q.setParameter(1, start);
		q.setParameter(2, recordsPerPage);
		List<Productline> results = q.getResultList();
		return results;
	}

	public int getNumberOfRows() throws EJBException {
		Query q = em.createNativeQuery("SELECT COUNT(*) FROM classicmodels.productlines");
		BigInteger results = (BigInteger) q.getSingleResult();
		int i = results.intValue();
		return i;
	}

	public Productline findProductline(String productLine) throws EJBException {
		Query q = em.createNamedQuery("Productline.findbyId");
		q.setParameter("productline", productLine);
		return (Productline) q.getSingleResult();
	}

	public void updateProductline(String[] s) throws EJBException {
		Productline p = findProductline(s[0]);
		p.setTextdescription(s[1]);
		p.setHtmldescription(s[2]);
		p.setImage(s[3]);
		em.merge(p);
	}

	public void deleteProductline(String productLine) throws EJBException {
		Productline p = findProductline(productLine);
		em.remove(p);
	}

	public void addProductline(String[] s) throws EJBException {
		Productline p = new Productline();
		p.setProductline(s[0]);
		p.setTextdescription(s[1]);
		p.setHtmldescription(s[2]);
		p.setImage(s[3]);
		em.persist(p);
	}

}
