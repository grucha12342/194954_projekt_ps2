package ps2;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.Reader;
import java.io.StringWriter;
import java.net.URL;
import java.nio.charset.Charset;
import java.util.Enumeration;
import java.util.zip.GZIPInputStream;

import javax.net.ssl.HttpsURLConnection;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import org.json.JSONException;
import org.json.JSONObject;
import org.apache.commons.io.IOUtils;
import org.apache.commons.io.output.WriterOutputStream;
import org.json.JSONArray;

public class JSONHandler {	
	public static String getUserData(HttpServletRequest request) throws IOException, JSONException{
		URL url = new URL("https://194954projekt.azurewebsites.net/.auth/me");
		
		Cookie cookie = null;
		Cookie[] cookies = request.getCookies();

		HttpsURLConnection connection = (HttpsURLConnection)url.openConnection();
		for(int i=0; i < cookies.length; i++) {
		   cookie = cookies[i];
		   connection.addRequestProperty(cookie.getName(), cookie.getValue());
		}
		Enumeration<String> headNames = request.getHeaderNames();
		while(headNames.hasMoreElements()) {
		    String headerName = headNames.nextElement();
		    String headerVal = request.getHeader(headerName);
		    connection.addRequestProperty(headerName, headerVal);
		}

		connection.connect();
		InputStream is = connection.getInputStream();
		GZIPInputStream gis = new GZIPInputStream(is);
		BufferedReader br = new BufferedReader(new InputStreamReader(gis, "UTF-8"));
		StringBuilder sb = new StringBuilder();
		String line;
		while((line = br.readLine()) != null) {
			sb.append(line);
		}
		br.close();
		gis.close();
		is.close();
		JSONArray jsonAr = new JSONArray(sb.toString());
		JSONObject jsonOb = jsonAr.getJSONObject(0);
		line = jsonOb.getString("user_id");
		return line;
	}
}
