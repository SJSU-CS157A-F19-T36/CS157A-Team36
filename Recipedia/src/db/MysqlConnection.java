package db;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MysqlConnection {
	private static final String HOSTNAME = "localhost";
	private static final String PORT_NUM = "3306"; 
	public static final String DB_NAME = "cs157a";
	private static final String USERNAME = "root";
	private static final String PASSWORD = "root";
	public static final String URL = "jdbc:mysql://"
			+ HOSTNAME + ":" + PORT_NUM + "/" + DB_NAME
			+ "?user=" + USERNAME + "&password=" + PASSWORD
			+ "&autoReconnect=true&serverTimezone=UTC";
	public static List<String> get() {
		List<String> result = new ArrayList<>();
		try {
			//System.out.println("Connecting to " + URL);

			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection(URL);
			if (conn == null) {
				return null;
			}
			Statement statement = conn.createStatement();
//			String sql = "INSERT INTO emp VALUES('3333', 'Tom', '30')";
//			statement.executeUpdate(sql);
			

			String sql = "SELECT * FROM emp";
			ResultSet rs = statement.executeQuery(sql);
			while (rs.next()) {
				result.add(Integer.toString(rs.getInt(1)) + " "
						+rs.getString(2) + " "
						+Integer.toString(rs.getInt(3)));
				
			}
			conn.close();
			//System.out.println("AAA");


			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}


}
