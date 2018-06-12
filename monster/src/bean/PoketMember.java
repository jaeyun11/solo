package bean;

import java.sql.Timestamp;

public class PoketMember {
	private String id;
	private String passwd;
	private String name;
	private int age;
	private String gender;
	private String email;
	private Timestamp reg_date;
	private String tel;
	
	public PoketMember(String id, String passwd, String name, int age, String gender,  String email, String tel) {
		this.id = id;
		this.passwd = passwd;
		this.name = name;
		this.age = age;
		this.gender = gender;
		this.email = email;
		this.tel = tel;
	}
	
	public PoketMember() {
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	
	
}
