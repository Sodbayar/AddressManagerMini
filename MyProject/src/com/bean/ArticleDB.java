package com.bean;

import java.sql.*;

import javax.naming.NamingException;

public class ArticleDB {
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private Statement stmt;
	private String tableDB = "memr";
	
	public ArticleDB() throws SQLException, NamingException {
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
	
	public void insertRecord(Article art) throws SQLException {
		String sql = "INSERT INTO " + tableDB + "(id, name, pwd) VALUES(?, ?, ?)";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1,  art.getId());
		pstmt.setString(2,  art.getName());
		pstmt.setString(3,  art.getPwd());
		
		pstmt.executeUpdate();		
	}
	
	public void UpdateRecord(Article art) throws SQLException {
		String sql = "UPDATE " + tableDB + " SET id=?, name=?, pwd=? WHERE idx=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, art.getId());	
		pstmt.setString(2,  art.getName());
		pstmt.setString(3,  art.getPwd());
		pstmt.setInt(4,  art.getIdx());	
		pstmt.executeUpdate();
	}

	public Article getRecord(int idx) throws SQLException {
		String sql = "SELECT id, name, pwd FROM " + tableDB + " WHERE idx=?";
		
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, idx);
		
		rs = pstmt.executeQuery();
		rs.next();
		
		Article art = new Article();
		art.setId(rs.getString("id"));
		art.setName(rs.getString("name"));
		art.setPwd("pwd");
		art.setIdx(idx);
		return art;
	}	
	
	
	public void deleteRecord(int idx) throws SQLException {
		String sql = "DELETE FROM " + tableDB + " WHERE idx = ?";
		String alter = "ALTER TABLE " + tableDB + " auto_increment=1";
		//rs = pstmt.executeQuery();
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
