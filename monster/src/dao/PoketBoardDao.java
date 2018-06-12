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

public class PoketBoardDao {
	private Connection getConnection() throws Exception {
		Context initContext = new InitialContext();
		DataSource ds = (DataSource) initContext.lookup("java:/comp/env/jdbc/oracle");
		return ds.getConnection();
	} // getConnection() 끝
	
	public int allPage() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int all = 0;
		
		try {
			con = getConnection();
			sql = "select count(*) from poketboard";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				all = rs.getInt(1);
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
		return all;
	}// allPage의끝
	
	public List<PoketBoard>getBoard(int staNum, int enNum){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<PoketBoard> list = new ArrayList<>();
		
		try {
			con = getConnection();
			StringBuilder sb = new StringBuilder();
			
			sb.append("select * ");
			sb.append("from (select rownum as rnum, a.* ");
			sb.append("        from (select * from poketboard order by num desc) a ");
			sb.append("       where rownum <= ? ");
			sb.append("        ) a ");
			sb.append("where rnum >= ? ");
			
			pstmt = con.prepareStatement(sb.toString());
			pstmt.setInt(1, enNum);
			pstmt.setInt(2, staNum);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				PoketBoard pboard = new PoketBoard();
				
				pboard.setNum(rs.getInt("num"));
				pboard.setSubject(rs.getString("subject"));
				pboard.setName(rs.getString("name"));
				pboard.setReadcount(rs.getInt("readcount"));
				
				list.add(pboard);
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
	}
	
	public List<PoketBoard>getBoard(String search, int enNum, int staNum){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<PoketBoard> list = new ArrayList<>();
		
		try {
			con = getConnection();
			StringBuilder sb = new StringBuilder();
			
			sb.append("select * ");
			sb.append("from (select rownum as rnum, a.* ");
			sb.append("        from (select * from poketboard where subject like ? order by num desc) a ");
			sb.append("       where rownum <= ? ");
			sb.append("        ) a ");
			sb.append("where rnum >= ? ");
			
			pstmt = con.prepareStatement(sb.toString());
			pstmt.setString(1, "%" + search + "%");
			pstmt.setInt(2, enNum);
			pstmt.setInt(3, staNum);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				PoketBoard pboard = new PoketBoard();
				
				pboard.setNum(rs.getInt("num"));
				pboard.setSubject(rs.getString("subject"));
				pboard.setName(rs.getString("name"));
				pboard.setReadcount(rs.getInt("readcount"));
				pboard.setContent(rs.getString("content"));
				pboard.setIp(rs.getString("ip"));
				pboard.setPasswd(rs.getString("passwd"));
				pboard.setReadcount(rs.getInt("readcount"));
				pboard.setReg_date(rs.getTimestamp("reg_date"));
				
				list.add(pboard);
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
	}
	
	public void insert(PoketBoard pboard) {
		Connection con = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = getConnection();
			sql = "select max(num) from poketboard";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				int num = rs.getInt(1)+1;
				pboard.setNum(num);
			}else {
				pboard.setNum(1);
			}
			
			sql = "insert into poketboard(num,subject,content,reg_date,name,readcount,id) values(?,?,?,?,?,?,?)";
			
			pstmt2 = con.prepareStatement(sql);
			pstmt2.setInt(1, pboard.getNum());
			pstmt2.setString(2, pboard.getSubject());
			pstmt2.setString(3, pboard.getContent());
			pstmt2.setTimestamp(4, pboard.getReg_date());
			pstmt2.setString(5, pboard.getName());
			pstmt2.setInt(6, pboard.getReadcount());
			pstmt2.setString(7, pboard.getId());
			
			pstmt2.executeUpdate();
			
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
	}// insert의끝
	
	public void upCount(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		
		try {
			con = getConnection();
			sql = "update poketboard set readcount=readcount+1 where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
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
				
	}// upcount의끝
	
	public PoketBoard getBoard(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		PoketBoard pboard = null;
		
		try {
			con = getConnection();
			sql = "select * from poketboard where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				pboard = new PoketBoard();
				pboard.setContent(rs.getString("content"));
				pboard.setName(rs.getString("name"));
				pboard.setNum(rs.getInt("num"));
				pboard.setReadcount(rs.getInt("readcount"));
				pboard.setSubject(rs.getString("subject"));
				pboard.setReg_date(rs.getTimestamp("reg_date"));
				pboard.setIp(rs.getString("ip"));
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
		return pboard;
	}// getBoard의끝
	
	public int allPage(String search) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int count = 0;
		
		try {
			con = getConnection();
			sql = "select count(*) from poketboard where subject like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + search + "%");
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
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
		return count;
	}// getboard의 끝
	
	public int updateCommu(PoketBoard board, String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		String sql = "";
		int check = 0;
		
		try {
			con = getConnection();
			sql = "select id from poketboard where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, board.getNum());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(id.equals(rs.getString("id"))) {
					sql = "update poketboard set subject=?,content=? where num=?";
					pstmt2 = con.prepareStatement(sql);
					pstmt2.setString(1, board.getSubject());
					pstmt2.setString(2, board.getContent());
					pstmt2.setInt(3, board.getNum());
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
	}// updateCommu의끝
	
	public int delCommu(int num, String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		String sql = "";
		int check = 0;
		
		try {
			con = getConnection();
			sql = "select id from poketboard where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(id.equals(rs.getString("id"))) {
					sql = "delete from poketboard where num=?";
					pstmt2 = con.prepareStatement(sql);
					pstmt2.setInt(1, num);
					
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
	
	public void adminDelete(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		try {
			con = getConnection();
			sql = "delete from poketboard where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
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
	}// admindelte의끝
	
	public void adUp(PoketBoard board, int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		try {
			con = getConnection();
			sql = "update poketboard set subject=?,content=? where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, board.getSubject());
			pstmt.setString(2, board.getContent());
			pstmt.setInt(3, board.getNum());
			pstmt.executeUpdate();
			
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
	}
	
}// getBoard의 끝
