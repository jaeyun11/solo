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

import bean.Board;
import bean.PoketBoard;

public class FileBoard {
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
			sql = "select count(*) from fileboard";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				all = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return all;
	}// allPage의끝
	
	public int allPage(String search) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int count = 0;
		
		try {
			con = getConnection();
			sql = "select count(*) from fileboard where subject like ?";
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

	public List<Board> getBoard(int staNum, int enNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Board> list = new ArrayList<>();

		try {
			con = getConnection();
			StringBuilder sb = new StringBuilder();

			sb.append("select * ");
			sb.append("from (select rownum as rnum, a.* ");
			sb.append("        from (select * from fileboard order by num desc) a ");
			sb.append("       where rownum <= ? ");
			sb.append("        ) a ");
			sb.append("where rnum >= ? ");

			pstmt = con.prepareStatement(sb.toString());
			pstmt.setInt(1, enNum);
			pstmt.setInt(2, staNum);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				Board pboard = new Board();

				pboard.setNum(rs.getInt("num"));
				pboard.setSubject(rs.getString("subject"));
				pboard.setName(rs.getString("name"));
				pboard.setReadcount(rs.getInt("readcount"));

				list.add(pboard);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

		}
		return list;
	}
	
	public List<Board>getBoard(String search, int enNum, int staNum){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Board> list = new ArrayList<>();
		
		try {
			con = getConnection();
			StringBuilder sb = new StringBuilder();
			
			sb.append("select * ");
			sb.append("from (select rownum as rnum, a.* ");
			sb.append("        from (select * from fileboard where subject like ? order by num desc) a ");
			sb.append("       where rownum <= ? ");
			sb.append("        ) a ");
			sb.append("where rnum >= ? ");
			
			pstmt = con.prepareStatement(sb.toString());
			pstmt.setString(1, "%" + search + "%");
			pstmt.setInt(2, enNum);
			pstmt.setInt(3, staNum);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Board board = new Board();
				
				board.setNum(rs.getInt("num"));
				board.setSubject(rs.getString("subject"));
				board.setName(rs.getString("name"));
				board.setReadcount(rs.getInt("readcount"));
				board.setContent(rs.getString("content"));
				board.setIp(rs.getString("ip"));
				board.setPasswd(rs.getString("passwd"));
				board.setReadcount(rs.getInt("readcount"));
				board.setReg_date(rs.getTimestamp("reg_date"));
				board.setFilename(rs.getString("filename"));
				
				list.add(board);
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

	public void insert(Board board) {
		Connection con = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		String sql = "";

		try {
			con = getConnection();
			sql = "select max(num) from fileboard";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				int num = rs.getInt(1) + 1;
				board.setNum(num);
			} else {
				board.setNum(1);
			}

			sql = "insert into fileboard(num,subject,content,reg_date,name,readcount,id,filename) values(?,?,?,?,?,?,?,?)";

			pstmt2 = con.prepareStatement(sql);
			pstmt2.setInt(1, board.getNum());
			pstmt2.setString(2, board.getSubject());
			pstmt2.setString(3, board.getContent());
			pstmt2.setTimestamp(4, board.getReg_date());
			pstmt2.setString(5, board.getName());
			pstmt2.setInt(6, board.getReadcount());
			pstmt2.setString(7, board.getId());
			pstmt2.setString(8, board.getFilename());

			pstmt2.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

			if (pstmt2 != null) {
				try {
					pstmt2.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}// insert의끝

	public void upCount(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";

		try {
			con = getConnection();
			sql = "update fileboard set readcount=readcount+1 where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

	}// upcount의끝

	public Board getBoard(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		Board board = null;

		try {
			con = getConnection();
			sql = "select * from fileboard where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				board = new Board();
				board.setContent(rs.getString("content"));
				board.setName(rs.getString("name"));
				board.setNum(rs.getInt("num"));
				board.setReadcount(rs.getInt("readcount"));
				board.setSubject(rs.getString("subject"));
				board.setReg_date(rs.getTimestamp("reg_date"));
				board.setIp(rs.getString("ip"));
				board.setFilename(rs.getString("filename"));

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

		}
		return board;
	}// getBoard의끝

	public int updateCommu(Board board, String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		String sql = "";
		int check = 0;

		try {
			con = getConnection();
			sql = "select id from fileboard where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, board.getNum());
			rs = pstmt.executeQuery();

			if (rs.next()) {
				if (id.equals(rs.getString("id"))) {
					sql = "update fileboard set subject=?,content=? where num=?";
					pstmt2 = con.prepareStatement(sql);
					pstmt2.setString(1, board.getSubject());
					pstmt2.setString(2, board.getContent());
					pstmt2.setInt(3, board.getNum());
					pstmt2.executeUpdate();
					check = 1;
				} else {
					check = 0;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

			if (pstmt2 != null) {
				try {
					pstmt2.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
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
			sql = "select id from fileboard where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				if (id.equals(rs.getString("id"))) {
					sql = "delete from fileboard where num=?";
					pstmt2 = con.prepareStatement(sql);
					pstmt2.setInt(1, num);

					pstmt2.executeUpdate();

					check = 1;
				}
			} else {
				check = 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

			if (pstmt2 != null) {
				try {
					pstmt2.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return check;
	}// delCommu의끝

	public int fileup(Board bean, String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		String sql = "";
		int check = 0;

		try {
			con = getConnection();
			// sql num에 해당하는 passwd 가져오기
			sql = "select id from fileboard where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getNum());
			// 실행
			rs = pstmt.executeQuery();
			// rs 데이터있으면 패스워드비교 맞으면 수정. check=1
			// update num에 해당하는 name,subject,content 수정
			// 패스워드비교 틀리면 check=0
			if (rs.next()) {
				if (id.equals(rs.getString("id"))) {
					sql = "update fileboard set subject=?, content=?, filename=? where num=?";
					pstmt2 = con.prepareStatement(sql);
					pstmt2.setString(1, bean.getSubject());
					pstmt2.setString(2, bean.getContent());
					pstmt2.setString(3, bean.getFilename());
					pstmt2.setInt(4, bean.getNum());
					// 실행
					pstmt2.executeUpdate();
					check = 1;
				} else {
					check = 0;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
				}
			}
			if (pstmt2 != null) {
				try {
					pstmt2.close();
				} catch (SQLException e) {
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
				}
			}
		}
		return check;
	} // fileup의끝
	
	public void adminDelete(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		try {
			con = getConnection();
			sql = "delete from fileboard where num=?";
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

}// FileBoard의 끝
