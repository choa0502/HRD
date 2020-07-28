<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%> 
<%@page import="java.text.SimpleDateFormat"%>
<%
SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
Connection conn=null;
Statement stmt=null;
ResultSet rs=null;
int custno=Integer.parseInt(request.getParameter("custno"));
String custname=null;
String phone=null;
String address=null;
Date joindate=null;
String grade=null;
String city=null;

String url="jdbc:oracle:thin:@localhost:1521:orcl";
String user="test";
String password="kosea2019a";
String sql="select * from member_tbl_02";
sql = sql+" where custno="+custno;
try{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn=DriverManager.getConnection(url, user, password);
	stmt=conn.createStatement();
	rs=stmt.executeQuery(sql);
	while(rs.next()){
		custno=rs.getInt("custno");
		custname=rs.getString("custname");
		phone=rs.getString("phone");
		address=rs.getString("address");
		joindate=rs.getDate("joindate");
		grade=rs.getString("grade");
		city=rs.getString("city");
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
<h4 align="center">홈쇼핑 회원 정보 수정</h4>
<hr>
<form method="post" name="frm" action="update.do">
<table align="center">
<tr>
<td>회원번호</td>
<td><input type="text" name="custno" value="<%=custno%>"></td>
</tr>
<tr>
<td>회원성명</td>
<td><input type="text" name="custname" value="<%=custname%>"></td>
</tr>
<tr>
<td>회원전화</td>
<td><input type="text" name="phone" value="<%=phone%>"></td>
</tr>
<tr>
<td>회원주소</td>
<td><input type="text" name="address" value="<%=address%>"></td>
</tr>
<tr>
<td>가입일자</td>
<td><input type="text" name="joindate" value="<%=sdf.format(joindate)%>"></td>
</tr>
<tr>
<td>고객등급(A:VIP, B:일반, C:직원)</td>
<td><input type="text" name="grade" value="<%=grade%>"></td>
</tr>
<tr>
<td>도시코드</td>
<td><input type="text" name="city" value="<%=city%>"></td>
</tr>
<tr>
<td colspan="2" align="center">
<input type="submit" value="수정" onclick="return joincheck()">
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