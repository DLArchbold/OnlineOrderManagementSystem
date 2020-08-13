package sessionbean;

import java.util.List;

import javax.ejb.EJBException;
import javax.ejb.Local;

import domain.Productline;

@Local
public interface ProductLineSessionBeanLocal {

	public List<Productline> getAllProductlines() throws EJBException;
	public Productline findProductline(String productLine) throws EJBException;
	public List<Productline> readProductline(int currentPage, int recordsPerPage) throws EJBException;
	public int getNumberOfRows() throws EJBException;
	public void updateProductline(String[] s) throws EJBException;
	public void deleteProductline(String productLine) throws EJBException;
	public void addProductline(String[] s) throws EJBException;
	
}
