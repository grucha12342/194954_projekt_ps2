package ps2;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import com.microsoft.sqlserver.jdbc.SQLServerDriver;

public class DatabaseHandler {
	public static ArrayList<String> fetchTables() throws ClassNotFoundException
	{
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		String url = "jdbc:sqlserver://194954ps3db.database.windows.net:1433;database=194954_projekt_ps2;user=ps3db@194954ps3db;password=tatib@w5ese;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;";
		Connection connection = null;
		ArrayList<String> list = new ArrayList<String>();
		try {
			connection = DriverManager.getConnection(url);
			String schema = connection.getSchema();

			// Create and execute a SELECT SQL statement.
			String selectSql = "SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE';";

			try (Statement statement = connection.createStatement();
					ResultSet resultSet = statement.executeQuery(selectSql)) {

				// Print results from select statement
				System.out.println("Select all");
				while (resultSet.next())
				{
					System.out.println(resultSet.getString(1) + " "
							+ resultSet.getString(2));
					list.add(resultSet.getString(3));
                }
				connection.close();
				return list;
			}                   
		}
		catch (Exception e) {
			e.printStackTrace();
			return list;
		}
	}
	
	public static ArrayList fetchDataFromTable(String table) throws ClassNotFoundException
	{
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		String url = "jdbc:sqlserver://194954ps3db.database.windows.net:1433;database=194954_projekt_ps2;user=ps3db@194954ps3db;password=tatib@w5ese;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;";
		Connection connection = null;
		ArrayList columns = new ArrayList();
		try {
			connection = DriverManager.getConnection(url);
			String schema = connection.getSchema();

			// Create and execute a SELECT SQL statement.
			String selectSql = "SELECT * FROM "+table+";";

			try (Statement statement = connection.createStatement();
					ResultSet resultSet = statement.executeQuery(selectSql)) {
				
				while (resultSet.next())
				{
					for(int i = 1; i <= 6; i++) {
						//list.add(resultSet.getString(3));
						columns.add(resultSet.getString(i));
					}
                }
				connection.close();
				return columns;
			}                   
		}
		catch (Exception e) {
			e.printStackTrace();
			return columns;
		}
	}
}
