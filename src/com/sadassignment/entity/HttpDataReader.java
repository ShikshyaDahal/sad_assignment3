package com.sadassignment.entity;

import java.io.BufferedReader;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;

public class HttpDataReader {
	// HttpDataReader
	
		// readRawInput - should return String
		// readRawInputAsJson - should return JsonObject
		public static JSONObject readRawInputAsJson(HttpServletRequest req){
			return convertStringToJsonObject(readRawInput(req));
			
		}
		
		public static String readRawInput(HttpServletRequest req){
			StringBuffer jb = new StringBuffer();
			String line = null;
			BufferedReader reader = null;
			try {
				reader = req.getReader();
				while ((line = reader.readLine()) != null)
					jb.append(line);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			return jb.toString();
		}
		
		public static JSONObject convertStringToJsonObject(String s){
			JSONObject jsonObj = null;
			try {
				jsonObj = new JSONObject(s);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return jsonObj;
		}

}
