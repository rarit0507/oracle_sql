<%@page import="com.mysql.cj.xdevapi.PreparableStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*, java.sql.*" %>
<%@ page import="org.kh.dto.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	request.setCharacterEncoding("utf-8");
	response.setCharacterEncoding("utf-8");
	response.setContentType("text/html; charset=utf-8");
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String userid = "system";
	String userpw = "1234";
	String sql = "";
	List<Book> bookList = new ArrayList<Book>();
	try {
		Class.forName("oracle.jdbc.OracleDriver");
		con = DriverManager.getConnection(url, userid, userpw);
		sql = "select * from book";
		pstmt = con.prepareStatement(sql);
		rs = pstmt.executeQuery();
		while(rs.next()){
			Book book = new Book(rs.getInt("bookid"), 
					rs.getString("bookkind"),
					rs.getString("booktitle"),
					rs.getInt("bookprice"),
					rs.getInt("bookcount"),
					rs.getString("author"),
					rs.getString("pubcom"),
					rs.getString("pubdate"));
			bookList.add(book);
		}
	} catch(Exception e){
		e.printStackTrace();
	} finally {
		if(rs!=null){
			try {
				rs.close();
			} catch(Exception e){
				e.printStackTrace();
			}
		}
		if(pstmt!=null){
			try {
				pstmt.close();
			} catch(Exception e){
				e.printStackTrace();
			}
		}
		if(con!=null){
			try {
				con.close();
			} catch(Exception e){
				e.printStackTrace();
			}
		}
	}
	
	pageContext.setAttribute("bList", bookList);
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>교재 상품 목록</title>
</head>
<body>
<hr>
<%@ include file="menu.jsp" %>
<hr>
<h2>교재 상품 목록</h2>
<table style="width:1200px;margin:30px auto">
	<thead>
		<tr>
			<th>도서코드</th><th>도서종류</th><th>도서제목</th>
			<th>도서단가</th><th>보유수량</th><th>저자</th>
			<th>출판사</th><th>출판일</th>
		</tr>
	</thead>
	<tbody>
	<c:forEach var="book" items="${bList }" varStatus="status">
		<tr>
			<td>${book.bookid }</td><td>${book.bookkind }</td>
			<td>${book.booktitle }</td><td>${book.bookprice }</td>
			<td>${book.bookcount }</td><td>${book.author }</td>
			<td>${book.pubcom }</td><td>${book.pubdate }</td>
		</tr>
	</c:forEach>	
	</tbody>
</table>
</body>
</html>