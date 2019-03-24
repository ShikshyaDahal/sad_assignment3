package com.sadassignment.student.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.sadassignment.entity.HttpDataReader;
import com.sadassignment.student.entity.Student;

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
			String firstName = jsonObject.get("firstName").toString().trim();
			String lastName = jsonObject.get("lastName").toString().trim();
			String email = jsonObject.get("email").toString().trim();
			String phoneNumber = jsonObject.get("phoneNumber").toString().trim();
			String address = jsonObject.get("address").toString().trim();
			String province = jsonObject.get("province").toString().trim();
			String postalCode = jsonObject.get("postalCode").toString().trim();

			String json = "{\r\n" + "\"firstName\":\"" + firstName + "\",\r\n" + "\"lastName\":\"" + lastName
					+ "\",\r\n" + "\"email\":\"" + email + "\",\r\n" + "\"phoneNumber\":\"" + phoneNumber + "\",\r\n"
					+ "\"address\":\"" + address + "\",\r\n" + "\"province\":\"" + province + "\",\r\n"
					+ "\"postalCode\":\"" + postalCode + "\"\r\n" + "}";

			String query_url = "https://sad3-e5b09.firebaseapp.com/api/v1/contacts";

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
				resp.setStatus(HttpServletResponse.SC_CREATED);

			} else {

				System.out.println("POST DOES NOT WORKS");

			}

		} catch (Exception e) {
			// TODO: handle exception
		}

	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			URL url = new URL("https://sad3-e5b09.firebaseapp.com/api/v1/contacts");
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Accept", "application/json");

			conn.connect();

			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));

			StringBuilder sb = new StringBuilder(2048);
			for (String line; (line = br.readLine()) != null;) {
				System.out.println(line);
				sb.append(line);
			}

			JSONObject o = new JSONObject(sb.toString());
			JSONObject obj = o.getJSONObject("contacts");
			System.out.println(obj);
			
			List<Student> studentList=new ArrayList<>();
			

			JsonObject jobj = new Gson().fromJson(sb.toString(), JsonObject.class);
			JsonObject jo = jobj.getAsJsonObject().get("contacts").getAsJsonObject();
			
			
			jo.entrySet().stream().forEach(qm -> {
				Student student=new Student();
				String key = qm.getKey();
				JsonElement je = qm.getValue();
				
				System.out.println("key: " + key);
				
				
				JsonObject on = je.getAsJsonObject();
				
				
				on.entrySet().stream().forEach(prop -> {
					
					
					System.out.println("\tname: " + prop.getKey() + " (value: " + prop.getValue().getAsString() + ")");
					
					if(prop.getKey().equals("province")) {
						student.setProvince(prop.getValue().getAsString());
					}if(prop.getKey().equals("firstName")) {
						student.setFirstName(prop.getValue().getAsString());
					}if(prop.getKey().equals("lastName")) {
						student.setLastName(prop.getValue().getAsString());
					}if(prop.getKey().equals("email")) {
						student.setEmail(prop.getValue().getAsString());
					}if(prop.getKey().equals("address")) {
						student.setAddress(prop.getValue().getAsString());
					}if(prop.getKey().equals("phoneNumber")) {
						student.setPhoneNumber(prop.getValue().getAsString());
					}if(prop.getKey().equals("postalCode")) {
						student.setPostalCode(prop.getValue().getAsString());
					}

				});
				studentList.add(student);
			});

			ObjectMapper jsonObject = new ObjectMapper();
			String jsonString = jsonObject.writeValueAsString(studentList);
			resp.getWriter().write(jsonString);
		//	resp.getWriter().write(obj.toString());

			conn.disconnect();

		} catch (IOException ex) {

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
}
