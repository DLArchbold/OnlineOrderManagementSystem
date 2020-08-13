package sessionbean;

import java.util.List;

import javax.ejb.EJBException;
import javax.ejb.Local;

import domain.Employee;
import domain.Office;



@Local
public interface EmployeesSessionBeanLocal {
	public List<Employee> getAllEmployees() throws EJBException;

	public Employee findEmployee(String employeeNumber) throws EJBException;

	public List<Employee> readEmployee(int currentPage, int recordsPerPage) throws EJBException;

	public int getNumberOfRows() throws EJBException;

	public void updateEmployee(String[] s) throws EJBException;
	
	public List<Office> getOffices();

	public void deleteEmployee(String id) throws EJBException;

	public void addEmployee(String[] s) throws EJBException;
}
