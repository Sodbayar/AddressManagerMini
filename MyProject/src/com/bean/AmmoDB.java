package com.bean;

import java.sql.*;

import javax.naming.NamingException;

public class AmmoDB {
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private Statement stmt;
	private String groupDB = "My Contacts";
	
	public AmmoDB() throws SQLException, NamingException {
		con = DsCon.getConnection();
	}
		
	public String getGroupDB() {
		return groupDB;
	}

	public void setGroupDB(String groupDB) {
		this.groupDB = groupDB;
	}

	public void createGroup(String group) throws SQLException {
		String sql = "INSERT INTO groups (grp) values('" + group + "')";
		stmt = con.createStatement();
		stmt.executeUpdate(sql);
	}
	
	public void editGroup(String newName, String oldName) throws SQLException {
		String sql = "update memr set grp='" + newName + "' where grp='" + oldName + "'";
		String sql2 = "update groups set grp='" + newName + "' where grp='" + oldName + "'";
		stmt = con.createStatement();
		stmt.executeUpdate(sql);
		stmt.executeUpdate(sql2);
	}
	
	public void deleteGroup(String group) throws SQLException {
		String sql = "DELETE FROM memr where grp='" + group + "'";
		String sql2 = "DELETE FROM groups where grp='" + group + "'";
		stmt = con.createStatement();
		stmt.executeUpdate(sql);
		stmt.executeUpdate(sql2);
	}
	
	public void insertRecord(Ammo a, boolean isTrash) throws SQLException {
		String table = "memr";
		if (isTrash) table = "trash";
		String sql = "INSERT INTO " + table +" (grp, name, phone, email, pos, dep, title, bday, addr, hpage, sns, memo, fileName)  VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, a.getGroup());
		pstmt.setString(2, a.getName());
		pstmt.setString(3, a.getPhone());
		pstmt.setString(4, a.getEmail());
		pstmt.setString(5, a.getPosition());
		pstmt.setString(6, a.getDepartment());
		pstmt.setString(7, a.getTitle());
		pstmt.setString(8, a.getBday());
		pstmt.setString(9, a.getAddress());
		pstmt.setString(10, a.getHomepage());
		pstmt.setString(11, a.getSns());
		pstmt.setString(12, a.getMemo());
		pstmt.setString(13, a.getPhoto());
		pstmt.executeUpdate();		
	}
	
	public void UpdateRecord(Ammo a) throws SQLException {
		String sql = "UPDATE memr SET grp=?, name=?, phone=?, email=?, pos=?, dep=?, title=?, bday=?, addr=?, hpage=?, sns=?, memo=?, fileName=? WHERE idx=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, a.getGroup());
		pstmt.setString(2, a.getName());
		pstmt.setString(3, a.getPhone());
		pstmt.setString(4, a.getEmail());
		pstmt.setString(5, a.getPosition());
		pstmt.setString(6, a.getDepartment());
		pstmt.setString(7, a.getTitle());
		pstmt.setString(8, a.getBday());
		pstmt.setString(9, a.getAddress());
		pstmt.setString(10, a.getHomepage());
		pstmt.setString(11, a.getSns());
		pstmt.setString(12, a.getMemo());	
		pstmt.setString(13, a.getPhoto());	
		pstmt.setInt(14, a.getIndex());		
		pstmt.executeUpdate();	
	}

	public Ammo getRecord(int idx, String table) throws SQLException {
		String sql = "SELECT grp, name, phone, email, pos, dep, title, bday, addr, hpage, sns, memo, fileName FROM " + table + " WHERE idx=?";
		
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, idx);
		
		rs = pstmt.executeQuery();
		rs.next();
		
		Ammo a = new Ammo();
		a.setGroup(rs.getString("grp"));
		a.setName(rs.getString("name"));
		a.setPhoto(rs.getString("fileName"));
		a.setPhone(rs.getString("phone"));
		a.setEmail(rs.getString("email"));
		a.setPosition(rs.getString("pos"));
		a.setDepartment(rs.getString("dep"));
		a.setTitle(rs.getString("title"));
		a.setBday(rs.getString("bday"));
		a.setAddress(rs.getString("addr"));
		a.setHomepage(rs.getString("hpage"));
		a.setSns(rs.getString("sns"));
		a.setMemo(rs.getString("memo"));
		a.setIndex(idx);
		return a;
	}	
	

	
	public void moveTrash(int idx) throws SQLException {
		String sql = "DELETE FROM memr WHERE idx=?";
		String alter = "ALTER TABLE memr auto_increment=2";
		Statement stmt = con.createStatement();
		
		
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, idx);
		pstmt.executeUpdate();	
		
		rs = stmt.executeQuery("SELECT * FROM memr");
		rs.next(); // 무조건 1번 index에 빈간값 있어야 함.
		if (!rs.next()) {
			stmt.executeUpdate(alter);			
		}
		stmt.close();
	}

	
	public void deleteRecord(int idx, String table) throws SQLException {
		String sql = "DELETE FROM " + table + " WHERE idx=?";
		String alter = "ALTER TABLE " + table + " auto_increment=2";
		Statement stmt = con.createStatement();
		
		
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, idx);
		pstmt.executeUpdate();	
		
		rs = stmt.executeQuery("SELECT * FROM " + table);
		rs.next(); // 무조건 memr table의 1번 index에 빈간값 있어야 함.
		if (!rs.next()) {
			stmt.executeUpdate(alter);			
		}
		stmt.close();
	}
	
	public void close() throws SQLException {
		if (rs != null) rs.close();
		if (pstmt != null) pstmt.close();
		if (con != null) con.close();
	}	
	
}
