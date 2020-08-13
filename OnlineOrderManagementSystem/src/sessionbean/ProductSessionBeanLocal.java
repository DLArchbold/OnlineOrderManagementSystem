package sessionbean;

import java.util.List;

import javax.ejb.EJBException;
import javax.ejb.Local;

import domain.Product;
import domain.Productline;

@Local
public interface ProductSessionBeanLocal {
		
	public List<Product> getAllProducts() throws EJBException;
	public List<Productline> getProductlines() throws EJBException;
	public Product findProduct(String productCode) throws EJBException;
	public List<Product> readProduct(int currentPage, int recordsPerPage) throws EJBException;
	public int getNumberOfRows() throws EJBException;
	public void updateProduct(String[] s) throws EJBException;
	public void deleteProduct(String productCode) throws EJBException;
	public void addProduct(String[] s) throws EJBException;
}
