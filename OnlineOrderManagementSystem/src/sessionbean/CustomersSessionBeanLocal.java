package sessionbean;

import java.util.List;

import javax.ejb.EJBException;
import javax.ejb.Local;

import domain.Customer;
import domain.Employee;
import domain.Office;

@Local
public interface CustomersSessionBeanLocal {
	public List<Customer> getAllCustomers() throws EJBException;

	public Customer findCustomer(String employeeNumber) throws EJBException;

	public List<Customer> readCustomer(int currentPage, int recordsPerPage) throws EJBException;

	public int getNumberOfRows() throws EJBException;

	public void updateCustomer(String[] s) throws EJBException;

	public List<Employee> getEmployees();

	public void deleteCustomer(String id) throws EJBException;

	public void addCustomer(String[] s) throws EJBException;
}
