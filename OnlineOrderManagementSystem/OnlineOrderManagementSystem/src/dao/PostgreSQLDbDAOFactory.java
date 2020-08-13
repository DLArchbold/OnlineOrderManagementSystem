package dao;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class PostgreSQLDbDAOFactory {
	private static InitialContext ctx;
	private static DataSource ds;

	public static Connection createConnection() throws SQLException {
		Connection conn = null;
		try {
			ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:/MyPostGresclassicmodels");
		} catch (NamingException e) {
			// throw new ServletException(e);
		}
		conn = ds.getConnection();
		return conn;
		// Use DRIVER and DBURL to create a connection
		// Recommend connection pool implementation/usage
	}
}
