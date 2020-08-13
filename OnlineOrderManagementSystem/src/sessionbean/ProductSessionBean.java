package sessionbean;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.List;

import javax.ejb.EJBException;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import domain.Product;
import domain.Productline;
//import sessionbean.ProductLineSessionBean;
//import sessionbean.ProductLineSessionBeanLocal;

/**
 * Session Bean implementation class ProductSessionBean
 */
@Stateless
public class ProductSessionBean implements ProductSessionBeanLocal {
	@PersistenceContext(unitName = "OnlineOrderManagementSystem")
	EntityManager em;
	private static final Class Productline = null;

	/**
	 * Default constructor.
	 */
	public ProductSessionBean() {
		// TODO Auto-generated constructor stub
	}

	public List<Product> getAllProducts() throws EJBException {
		return em.createNamedQuery("Product.findAll").getResultList();
	}

	public List<Productline> getProductlines() throws EJBException{
		return em.createNamedQuery("Productline.findAll").getResultList();
	}
	
	public List<Product> readProduct(int currentPage, int recordsPerPage) throws EJBException {
		// Write some codes here…
		int start = currentPage * recordsPerPage - recordsPerPage;
		Query q = em.createNativeQuery("SELECT * FROM classicmodels.products ORDER BY productcode OFFSET ? LIMIT ?",
				Product.class);
		q.setParameter(1, start);
		q.setParameter(2, recordsPerPage);
		List<Product> results = q.getResultList();
		return results;
	}

	public int getNumberOfRows() throws EJBException {
		Query q = em.createNativeQuery("SELECT COUNT(*) FROM classicmodels.products");
		BigInteger results = (BigInteger) q.getSingleResult();
		int i = results.intValue();
		return i;
	}

	public Product findProduct(String productCode) throws EJBException {
		Query q = em.createNamedQuery("Product.findbyId");
		q.setParameter("productcode", productCode);
		return (Product) q.getSingleResult();
	}

	public void updateProduct(String[] s) throws EJBException {
		Product p = findProduct(s[0]);
		p.setProductname(s[1]);
		p.setProductscale(s[3]);
		p.setProductvendor(s[4]);
		p.setProductdescription(s[5]);
		p.setQuantityinstock(Integer.valueOf(s[6]));
		p.setBuyprice(BigDecimal.valueOf(Double.valueOf(s[7])));
		p.setMsrp(BigDecimal.valueOf(Double.valueOf(s[8])));
		
		Query q = em.createNamedQuery("Productline.findbyId");
		q.setParameter("productline", s[2]);
		Productline pl = (Productline) q.getSingleResult();
		p.setProductlineBean(pl);
		em.merge(p);
	}

	public void deleteProduct(String productCode) throws EJBException {
		Product p = findProduct(productCode);
		em.remove(p);
	}

	public void addProduct(String[] s) throws EJBException {
		Product p = new Product();
		p.setProductcode(s[0]);
		p.setProductname(s[1]);
		p.setProductscale(s[3]);
		p.setProductvendor(s[4]);
		p.setProductdescription(s[5]);
		p.setQuantityinstock(Integer.valueOf(s[6]));
		p.setBuyprice(BigDecimal.valueOf(Double.valueOf(s[7])));
		p.setMsrp(BigDecimal.valueOf(Double.valueOf(s[8])));
		Query q = em.createNamedQuery("Productline.findbyId");
		q.setParameter("productline", s[2].trim());
		Productline pl = (Productline) q.getSingleResult();
		p.setProductlineBean(pl);
		em.persist(p);
	}

}
