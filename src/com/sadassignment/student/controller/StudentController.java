package com.sadassignment.student.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/")
public class StudentController extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {	
		if(req.getRequestURI().equals(req.getContextPath() + "/list")) {
			req.getRequestDispatcher("student.jsp").forward(req, resp);
		}else {
		req.getRequestDispatcher("studentCreate.jsp").forward(req, resp);
		}
	}

}
