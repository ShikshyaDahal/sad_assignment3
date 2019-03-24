package com.sadassignment.student.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.sadassignment.entity.HttpDataReader;

@WebServlet("/api/student/*")
public class StudentWS extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		JSONObject jsonObject = HttpDataReader.readRawInputAsJson(req);
		try {
			String code = jsonObject.get("firstName").toString().trim();
			String name = jsonObject.get("lastName").toString().trim();
			String category = jsonObject.get("email").toString().trim();

			String json = "{\r\n" + "\"firstName\":\"" + code + "\",\r\n" + "\"lastName\":\"" + name + "\",\r\n"
					+ "\"email\":\"" + category + "\"\r\n" + "}";

			String query_url = "https://sad3-e5b09.firebaseapp.com/api/v1/contacts";

			System.out.println(json);

			URL url = new URL(query_url);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			conn.setInstanceFollowRedirects(false);
			conn.setConnectTimeout(5000);
			conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
			conn.setDoOutput(true);
			conn.setDoInput(true);
			conn.setRequestMethod("POST");

			OutputStream os = conn.getOutputStream();
			os.write(json.getBytes("UTF-8"));
			os.close();

			int responseCode = conn.getResponseCode();

			System.out.println("POST Response Code :  " + responseCode);

			System.out.println("POST Response Message : " + conn.getResponseMessage());

			if (responseCode == HttpURLConnection.HTTP_OK) { // success

				BufferedReader in = new BufferedReader(new InputStreamReader(

						conn.getInputStream()));

				String inputLine;

				StringBuffer response = new StringBuffer();

				while ((inputLine = in.readLine()) != null) {

					response.append(inputLine);

				}
				in.close();

				System.out.println(response.toString());

			} else {

				System.out.println("POST NOT WORKED");

			}

		} catch (Exception e) {
			// TODO: handle exception
		}

	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
	         URL url = new URL( "https://sad3-e5b09.firebaseapp.com/api/v1/contacts" );
	         HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	         conn.setRequestMethod( "GET" );
	         conn.setRequestProperty( "Accept", "application/json" );

	         conn.connect();

	         BufferedReader br = new BufferedReader( new InputStreamReader(
	                 conn.getInputStream(), "UTF-8" ) );

	         StringBuilder sb = new StringBuilder( 2048 );
	         for( String line; (line = br.readLine()) != null; ) {
	            sb.append( line );
	         }
	         conn.disconnect();

	         System.out.println(sb);

	      } catch( IOException ex ) {
	         
	      }

	}
}
