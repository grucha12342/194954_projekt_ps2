package ps2;
import java.sql.*;
import com.microsoft.sqlserver.*;

public class DatabaseHandler {
	public static void connectToDb() throws ClassNotFoundException
	{
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		String url = "jdbc:sqlserver://194954ps3db.database.windows.net:1433;database=194954_projekt_ps2;user=ps3db@194954ps3db;password=tatib@w5ese;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;";
		Connection connection = null;
		try {
			connection = DriverManager.getConnection(url);
			String schema = connection.getSchema();

			// Create and execute a SELECT SQL statement.
			String selectSql = "SELECT * FROM Albums;";

			try (Statement statement = connection.createStatement();
					ResultSet resultSet = statement.executeQuery(selectSql)) {

				// Print results from select statement
				System.out.println("Select all");
				while (resultSet.next())
				{
					System.out.println(resultSet.getString(1) + " "
							+ resultSet.getString(2));
                }
				connection.close();
			}                   
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	public static void closeConnDb()
	{
		
	}
}
