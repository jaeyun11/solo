package bean;

import java.sql.Timestamp;

public class Re {
	private String id;
	private String passwd;
	private String content;
	private int count;
	private Timestamp reg_date;
	private int num;
	private int replenum;
	
	
	public int getReplenum() {
		return replenum;
	}
	public void setReplenum(int replenum) {
		this.replenum = replenum;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	
	
}
