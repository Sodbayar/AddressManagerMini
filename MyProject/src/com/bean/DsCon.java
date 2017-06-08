package com.bean;

import java.sql.*;
import javax.sql.DataSource;
import javax.naming.*;

public class DsCon {
	public static Connection getConnection() throws SQLException, NamingException {
		Context initContext = new InitialContext();
		DataSource ds = (DataSource) initContext.lookup("java:/comp/env/jdbc/mydb");
		return ds.getConnection();
	}
}
