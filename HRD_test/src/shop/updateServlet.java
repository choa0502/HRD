package shop;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class updateServlet
 */
@WebServlet("/update.do")
public class updateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public updateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTf-8");
		
		Connection conn=null;
		PreparedStatement pstmt=null;
		
		String url="jdbc:oracle:thin:@localhost:1521:orcl";
		String uid="test";
		String pass="kosea2019a";
		String sql="update member_tbl_02 set custno=?, custname=?, phone=?, address=?, joindate=?, grade=?, city=? where custno=?";	
		
		String custno=request.getParameter("custno");
		String custname=request.getParameter("custname");
		String phone=request.getParameter("phone");
		String address=request.getParameter("address");
		String joindate=request.getParameter("joindate");
		String grade=request.getParameter("grade");
		String city=request.getParameter("city");
		
		try{
			Class.forName("oracle.jdbc.driver.OracleDriver");	// JDBC 드라이버 로드
			conn=DriverManager.getConnection(url, uid, pass);	//데이터베이스 연결 객체인 Connection 생성
			pstmt=conn.prepareStatement(sql);	// PreparedStatment 객체 생성하기
			pstmt.setInt(1, Integer.parseInt(custno));	// 바인딩 변수를 설정힌다
			pstmt.setString(2, custname);
			pstmt.setString(3, phone);
			pstmt.setString(4, address);
			pstmt.setString(5, joindate);
			pstmt.setString(6, grade);
			pstmt.setString(7, city);
			pstmt.setInt(8, Integer.parseInt(custno));
			pstmt.executeUpdate();	// SQL문을 실행하여 결과 처리
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			try{
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();		// 끝난 리소스 해제 (null != 의 의미 : 작업이 실행되서 결과가 있다)
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
		request.setAttribute("message", "회원 수정에 성공했습니다");
		
		RequestDispatcher dispatcher=request.getRequestDispatcher("update.jsp");
		dispatcher.forward(request, response);		
	}

}
