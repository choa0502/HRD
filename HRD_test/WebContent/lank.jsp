<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>    
<%
Connection conn=null;
Statement stmt=null;
ResultSet rs=null;

String url="jdbc:oracle:thin:@localhost:1521:orcl";
String user="test";
String password="kosea2019a";
String sql="select me.custno, custname, grade, sum(price) sale from member_tbl_02 me,money_tbl_02 mo where me.custno=mo.custno group by me.custno, custname, grade order by sale desc";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="header.jsp"/>
<jsp:include page="nav.jsp"/>
<h4 align="center">회원매출조회</h4>
<hr>
<table align="center">
<tr>
<th width="100">회원번호</th>
<th width="100">회원성명</th>
<th width="100">고객등급</th>
<th width="100">매출</th>
</tr>
<%
try{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, password);
	stmt = conn.createStatement();
	rs = stmt.executeQuery(sql);
	while(rs.next()){
		out.print("<tr align='center'>");
		out.print("<td>"+rs.getInt("custno")+"</td>");
		out.print("<td>"+rs.getString("custname")+"</td>");
		if(rs.getString("grade").equals("A")){
			out.print("<td>VIP</td>");
		} else if(rs.getString("grade").equals("B")){
			out.print("<td>일반</td>");
		} else if(rs.getString("grade").equals("C")) {
			out.print("<td>직원</td>");
		}		
		out.print("<td>"+rs.getInt("sale")+"</td>");
		out.print("</tr>");
	}
} catch(Exception e){
	e.printStackTrace();
} finally {
	try{
		if(rs!=null) rs.close();
		if(stmt!=null) stmt.close();
		if(conn!=null) conn.close();
	} catch(Exception e){
		e.printStackTrace();
	}
}
%>
</table>
<jsp:include page="footer.jsp"/>
</body>
</html>