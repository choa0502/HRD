<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%> 
<%@page import="java.util.Date" %> 
<%@page import="java.text.SimpleDateFormat"%>
<%
SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
Date d = new Date();
String now = d.toString();
Connection conn=null;
Statement stmt=null;
ResultSet rs=null;
int custno=0;
String joindate=null;

String url="jdbc:oracle:thin:@localhost:1521:orcl";
String user="test";
String password="kosea2019a";
String sql="select * from member_tbl_02";
try{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn=DriverManager.getConnection(url, user, password);
	stmt=conn.createStatement();
	rs=stmt.executeQuery(sql);
	while(rs.next()){
		custno=rs.getInt("custno");
	}
} catch(Exception e){
	e.printStackTrace();
} finally{
	try{
		if(rs!=null) rs.close();
		if(stmt!=null) stmt.close();
		if(conn!=null) conn.close();	
	} catch(Exception e) {
		e.printStackTrace();
	}
}
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="jasc.js"></script>
</head>
<body>
<jsp:include page="header.jsp"/>
<jsp:include page="nav.jsp"/>
<h4 align="center">홈쇼핑 회원 등록</h4>
<hr>
<form method="post" name="frm" action="join.do">
<table align="center">
<tr>
<td>회원번호(자동생성)</td>
<td><input type="text" name="custno" value="<%=custno+1%>" readonly></td>
</tr>
<tr>
<td>회원성명</td>
<td><input type="text" name="custname"></td>
</tr>
<tr>
<td>회원전화</td>
<td><input type="text" name="phone"></td>
</tr>
<tr>
<td>회원주소</td>
<td><input type="text" name="address"></td>
</tr>
<tr>
<td>가입일자</td>
<td><input type="text" name="joindate" value="<%=sdf.format(d)%>" readonly></td>
</tr>
<tr>
<td>고객등급(A:VIP, B:일반, C:직원)</td>
<td><input type="text" name="grade"></td>
</tr>
<tr>
<td>도시코드</td>
<td><input type="text" name="city"></td>
</tr>
<tr>
<td colspan="2" align="center">
<input type="submit" value="등록" onclick="return joincheck()">
<input type="button" value="조회" onclick="location.href='member.jsp'">
</td>
</tr>
</table>
</form>
<jsp:include page="footer.jsp"/>
<script>
if('${message}'!=''){
	alert('${message}');
}
</script>
</body>
</html>