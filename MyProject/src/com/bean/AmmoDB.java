package com.bean;

import java.sql.*;

import javax.naming.NamingException;

public class AmmoDB {
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private Statement stmt;
	private String tableDB = "memr";
	
	public AmmoDB() throws SQLException, NamingException {
		con = DsCon.getConnection();
	}
		
	public String getTableDB() {
		return tableDB;
	}

	public void setTableDB(String tableDB) {
		this.tableDB = tableDB;
	}

	public void createTable(String table) throws SQLException {
		String sql = "CREATE TABLE " + table + " (idx int not null auto_increment, id varchar(10), name varchar(20), pwd varchar(20), primary key(idx))";
		stmt = con.createStatement();
		stmt.executeUpdate(sql);
	}
	
	public void insertRecord(Ammo a) throws SQLException {
		String sql = "INSERT INTO " + tableDB + "(grp, name, phone, email, pos, dep, title, bday, addr, hpage, sns, memo) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
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
		pstmt.executeUpdate();		
	}
	
	public void UpdateRecord(Ammo a) throws SQLException {
		String sql = "UPDATE " + tableDB + " SET grp=?, name=?, phone=?, email=?, pos=?, dep=?, title=?, bday=?, addr=?, hpage=?, sns=?, memo=? WHERE idx=?";
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
		pstmt.setInt(13, a.getIndex());		
		pstmt.executeUpdate();	
	}

	public Ammo getRecord(int idx) throws SQLException {
		String sql = "SELECT grp, name, phone, email, pos, dep, title, bday, addr, hpage, sns, memo FROM " + tableDB + " WHERE idx=?";
		
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, idx);
		
		rs = pstmt.executeQuery();
		rs.next();
		
		Ammo a = new Ammo();
		a.setGroup(rs.getString("grp"));
		a.setName(rs.getString("name"));
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
	
	
	public void deleteRecord(int idx) throws SQLException {
		String sql = "DELETE FROM " + tableDB + " WHERE idx = ?";
		String alter = "ALTER TABLE " + tableDB + " auto_increment=1";
		Statement stmt = con.createStatement();
		
		
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, idx);
		pstmt.executeUpdate();	
		
		rs = stmt.executeQuery("SELECT * FROM " + tableDB);
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
