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

import bean.PoketMember;

public class PoketMemberDao {
	// DB연결 메소드
		private Connection getConnection() throws Exception {
			Connection con = null;
			
			// DB 연결에 필요한 정보
			// String url = "jdbc:oracle:thin:@127.0.0.1:1521:testDB";
			// String user = "scott";
			// String password = "1234";
			// 드라이버 로딩
			// Class.forName("oracle.jdbc.driver.OracleDriver");
			// 연결
			// con = DriverManager.getConnection(url, user, password);
			
			
			Context initContext = new InitialContext();
			DataSource ds = (DataSource) initContext.lookup("java:/comp/env/jdbc/oracle");
			con = ds.getConnection();
			return con;
		} // getConnection() 끝
		
		public void inserMember(PoketMember pmem) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = "";
			
			try {
				con = getConnection();
				sql = "insert into poketmember(id,name,age,passwd,reg_date,gender,email,tel) values(?,?,?,?,?,?,?,?)";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, pmem.getId());
				pstmt.setString(2, pmem.getName());
				pstmt.setInt(3, pmem.getAge());
				pstmt.setString(4, pmem.getPasswd());
				pstmt.setTimestamp(5, pmem.getReg_date());
				pstmt.setString(6, pmem.getGender());
				pstmt.setString(7, pmem.getEmail());
				pstmt.setString(8, pmem.getTel());
				
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
		}// inserMember 의끝
		
		public int idCheck(String id) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = "";
			int ck = 0;
			
			try {
				con = getConnection();
				sql = "select count(*) from poketmember where id=?";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					ck = rs.getInt(1);
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
			return ck;
		} // idCheck의끝
		
		public int userCheck(String id, String passwd) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = "";
			int check = 0;
			
			sql = "select passwd from poketmember where id=?";
			try {
				con = getConnection();
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					if(passwd.equals(rs.getString("passwd"))) {
						check = 1;
					}else {
						check = 0;
					}
				}else {
					check = -1;
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
			return check;
		}// userCheck의 끝
		
		public String getName(String id) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = "";
			String name = "";
			try {
				con = getConnection();
				sql = "select name from poketmember where id=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					name = rs.getString("name");
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
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
			
			return name;
		}
		
		public List<PoketMember>getMem(){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = "";
			List<PoketMember> list = new ArrayList<>();
			
			try {
				con = getConnection();
				sql = "select * from poketmember";
				pstmt = con.prepareStatement(sql);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					PoketMember bean = new PoketMember();
					
					bean.setId(rs.getString("id"));
					bean.setAge(rs.getInt("age"));
					bean.setPasswd(rs.getString("passwd"));
					bean.setEmail(rs.getString("email"));
					bean.setName(rs.getString("name"));
					bean.setGender(rs.getString("gender"));
					bean.setReg_date(rs.getTimestamp("reg_date"));
					bean.setTel(rs.getString("tel"));
					
					list.add(bean);
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
		}// getmem 의끝
		
		public void memdelete(String id) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = "";
			
			try {
				con = getConnection();
				sql = "delete from poketmember where id=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
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
		}// memdel의끝
		
		public void memupdate(PoketMember bean) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = "";
			
			try {
				con = getConnection();
				
				sql = "update poketmember set name=?, age=?, email=?, gender=?, tel=?, passwd=? where id=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, bean.getName());
				pstmt.setInt(2, bean.getAge());
				pstmt.setString(3, bean.getEmail());
				pstmt.setString(4, bean.getGender());
				pstmt.setString(5, bean.getTel());
				pstmt.setString(6, bean.getPasswd());
				pstmt.setString(7, bean.getId());
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
		}// memupdate의끝
		
		public PoketMember getmember(String id) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			PoketMember bean = null;
			String sql = "";
			
			try {
				con = getConnection();
				sql = "select * from poketmember where id=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					bean = new PoketMember();
					bean.setId(rs.getString("id"));
					bean.setAge(rs.getInt("age"));
					bean.setEmail(rs.getString("email"));
					bean.setGender(rs.getString("gender"));
					bean.setName(rs.getString("name"));
					bean.setPasswd(rs.getString("passwd"));
					bean.setReg_date(rs.getTimestamp("reg_date"));
					bean.setTel(rs.getString("tel"));
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
			return bean;
		}// getmember의끝
		
		public void deleteAll() {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = "";
			
			try {
				con = getConnection();
				sql = "delete from pokettest";
				
				pstmt = con.prepareStatement(sql);
				
				rs = pstmt.executeQuery();
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
		}// deleteAll의끝
		
		public int upChart(int Minage, int Maxage, String gender) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = "";
			int count = 0;
			
			try {
				con = getConnection();
				sql = "select count(*) from poketmember where gender=? and age>=? and age<?";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, gender);
				pstmt.setInt(2, Minage);
				pstmt.setInt(3, Maxage);
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
		}
		
}// PoketMemberDao의끝
