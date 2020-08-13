package sessionbean;

import java.util.List;

import javax.ejb.EJBException;
import javax.ejb.Local;

import domain.Office;

@Local
public interface OfficeSessionBeanLocal {
	public List<Office> getAllOffices() throws EJBException;

	public Office findOffice(String officeCode) throws EJBException;

	public List<Office> readOffice(int currentPage, int recordsPerPage) throws EJBException;

	public int getNumberOfRows() throws EJBException;

	public void updateOffice(String[] s) throws EJBException;

	public void deleteOffice(String id) throws EJBException;

	public void addOffice(String[] s) throws EJBException;
}
