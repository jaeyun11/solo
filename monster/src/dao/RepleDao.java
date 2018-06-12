package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import bean.PoketBoard;
import bean.Re;

public class RepleDao {
	private Connection getConnection() throws Exception {
		Context initContext = new InitialContext();
		DataSource ds = (DataSource) initContext.lookup("java:/comp/env/jdbc/oracle");
		return ds.getConnection();
	} // getConnection() 끝
	
	public void insert(Re re) {
		Connection con = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		String sql = "";
		int replenum = 0;
		
		try {
			con = getConnection();
			sql = "select max(replenum) from reple";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				replenum = rs.getInt("max(replenum)")+1;
				re.setReplenum(replenum);
			}else {
				re.setReplenum(1);
			}
			
			sql = "insert into reple(content,reg_date,count,id,num,replenum,passwd) values(?,?,?,?,?,?,?)";
			
			pstmt2 = con.prepareStatement(sql);
			pstmt2.setString(1, re.getContent());
			pstmt2.setTimestamp(2, re.getReg_date());
			pstmt2.setInt(3, re.getCount());
			pstmt2.setString(4, re.getId());
			pstmt2.setInt(5, re.getNum());
			pstmt2.setInt(6, re.getReplenum());
			pstmt2.setString(7, re.getPasswd());
			
			pstmt2.executeUpdate();
			 
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {e.printStackTrace();}}
			
			if (pstmt2 != null) {
			try {
				pstmt2.close();
			} catch (SQLException e) {e.printStackTrace();}}
			
			if(pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {e.printStackTrace();}}
			
			if(con != null) {
			try {
				con.close();
			} catch (SQLException e) {e.printStackTrace();}}
		}
	}// insert의끝
	
	public Re getReple(int num) {
		Connection con = null; 
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		Re re = null;
		
		try {
			con = getConnection();
			sql = "select * from reple where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				re = new Re();
				re.setContent(rs.getString("content"));
				re.setNum(rs.getInt("num"));
				re.setCount(rs.getInt("count"));
				re.setReg_date(rs.getTimestamp("reg_date"));
				re.setReplenum(rs.getInt("replenum"));
				re.setId(rs.getString("id"));
				re.setPasswd(rs.getString("passwd"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {e.printStackTrace();}}
				
			if(pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {e.printStackTrace();}}
				
			if(con != null) {
			try {
				con.close();
			} catch (SQLException e) {e.printStackTrace();}}
		}
		return re;
	}// getBoard의끝
	
	public List<Re> getRe(int num){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		List<Re> list = new ArrayList<>();
		
		try {
			con = getConnection();
			sql = "select * from reple where num=? order by replenum";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Re re = new Re();
				re.setContent(rs.getString("content"));
				re.setCount(rs.getInt("count"));
				re.setId(rs.getString("id"));
				re.setNum(rs.getInt("num"));
				re.setPasswd(rs.getString("passwd"));
				re.setReg_date(rs.getTimestamp("reg_date"));
				re.setReplenum(rs.getInt("replenum"));
				
				list.add(re);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {e.printStackTrace();}}
				
			if(pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {e.printStackTrace();}}
				
			if(con != null) {
			try {
				con.close();
			} catch (SQLException e) {e.printStackTrace();}}
		}
		return list;
	}// getre의끝
	
	public int reup(Re re, String passwd) {
		Connection con = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		String sql = "";
		int check = 0;
		
		try {
			con = getConnection();
			sql = "select passwd from reple where replenum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, re.getReplenum());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(passwd.equals(rs.getString("passwd"))) {
					sql = "update reple set content=? where replenum=?";
					pstmt2 = con.prepareStatement(sql);
					pstmt2.setString(1, re.getContent());
					pstmt2.setInt(2, re.getReplenum());
					pstmt2.executeUpdate();
					check = 1;
				}else {
					check = 0;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {e.printStackTrace();}}
			
			if (pstmt2 != null) {
			try {
				pstmt2.close();
			} catch (SQLException e) {e.printStackTrace();}}
			
			if(pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {e.printStackTrace();}}
			
			if(con != null) {
			try {
				con.close();
			} catch (SQLException e) {e.printStackTrace();}}
		}
		return check;
	}// reup의끝

	public int redel(int replenum, String passwd) {
		Connection con = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		String sql = "";
		int check = 0;
		
		try {
			con = getConnection();
			sql = "select passwd from reple where replenum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, replenum);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(passwd.equals(rs.getString("passwd"))) {
					sql = "delete from reple where replenum=?";
					pstmt2 = con.prepareStatement(sql);
					pstmt2.setInt(1, replenum);
					
					pstmt2.executeUpdate();
					
					check = 1;
				}
			}else {
				check = 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {e.printStackTrace();}}
			
			if (pstmt2 != null) {
			try {
				pstmt2.close();
			} catch (SQLException e) {e.printStackTrace();}}
			
			if(pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {e.printStackTrace();}}
			
			if(con != null) {
			try {
				con.close();
			} catch (SQLException e) {e.printStackTrace();}}
		}
		return check;
	}// delCommu의끝
	
	public void adUp(Re re) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		
		try {	
					con = getConnection();
					sql = "update reple set content=? where replenum=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, re.getContent());
					pstmt.setInt(2, re.getReplenum());
					pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {e.printStackTrace();}}
			
			if(con != null) {
			try {
				con.close();
			} catch (SQLException e) {e.printStackTrace();}}
		}
	}// reup의끝
	
	public void adDel(int replenum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		
		try {
			con = getConnection();
			sql = "delete from reple where replenum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, replenum);
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {e.printStackTrace();}}
			
			if(con != null) {
			try {
				con.close();
			} catch (SQLException e) {e.printStackTrace();}}
		}
	}// adDel의끝
 }
