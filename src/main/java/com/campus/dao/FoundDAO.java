package com.campus.dao;

import com.campus.model.FoundItem;
import com.campus.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FoundDAO {
    
	public boolean addFoundItem(FoundItem item) {
	    String sql = "INSERT INTO found_items (user_id, item_name, description, location, found_date, contact, image_path) VALUES (?, ?, ?, ?, ?, ?, ?)";
	    try (Connection conn = DatabaseConnection.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        
	        pstmt.setInt(1, item.getUserId());
	        pstmt.setString(2, item.getItemName());
	        pstmt.setString(3, item.getDescription());
	        pstmt.setString(4, item.getLocation());
	        pstmt.setDate(5, item.getFoundDate());
	        pstmt.setString(6, item.getContact());
	        pstmt.setString(7, item.getImagePath());
	        
	        return pstmt.executeUpdate() > 0;
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}
    
    public List<FoundItem> getAllFoundItems() {
        List<FoundItem> items = new ArrayList<>();
        String sql = "SELECT f.*, u.name as user_name FROM found_items f " +
                     "JOIN users u ON f.user_id = u.user_id ORDER BY f.created_at DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                FoundItem item = new FoundItem();
                item.setFoundId(rs.getInt("found_id"));
                item.setUserId(rs.getInt("user_id"));
                item.setItemName(rs.getString("item_name"));
                item.setDescription(rs.getString("description"));
                item.setLocation(rs.getString("location"));
                item.setFoundDate(rs.getDate("found_date"));
                item.setContact(rs.getString("contact"));
                item.setStatus(rs.getString("status"));
                item.setUserName(rs.getString("user_name"));
                item.setImagePath(rs.getString("image_path"));
                items.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }
    
    public List<FoundItem> searchFoundItems(String keyword, String location, String date) {
        List<FoundItem> items = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT f.*, u.name as user_name FROM found_items f " +
            "JOIN users u ON f.user_id = u.user_id WHERE 1=1"
        );
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (f.item_name LIKE ? OR f.description LIKE ?)");
        }
        if (location != null && !location.trim().isEmpty()) {
            sql.append(" AND f.location LIKE ?");
        }
        if (date != null && !date.trim().isEmpty()) {
            sql.append(" AND f.found_date = ?");
        }
        sql.append(" ORDER BY f.created_at DESC");
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {
            
            int paramIndex = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                String searchPattern = "%" + keyword + "%";
                pstmt.setString(paramIndex++, searchPattern);
                pstmt.setString(paramIndex++, searchPattern);
            }
            if (location != null && !location.trim().isEmpty()) {
                pstmt.setString(paramIndex++, "%" + location + "%");
            }
            if (date != null && !date.trim().isEmpty()) {
                pstmt.setDate(paramIndex++, Date.valueOf(date));
            }
            
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                FoundItem item = new FoundItem();
                item.setFoundId(rs.getInt("found_id"));
                item.setUserId(rs.getInt("user_id"));
                item.setItemName(rs.getString("item_name"));
                item.setDescription(rs.getString("description"));
                item.setLocation(rs.getString("location"));
                item.setFoundDate(rs.getDate("found_date"));
                item.setContact(rs.getString("contact"));
                item.setStatus(rs.getString("status"));
                item.setUserName(rs.getString("user_name"));
                items.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }
    
    public boolean updateStatus(int foundId, String status) {
        String sql = "UPDATE found_items SET status = ? WHERE found_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, status);
            pstmt.setInt(2, foundId);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean deleteFoundItem(int foundId) {
        String sql = "DELETE FROM found_items WHERE found_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, foundId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}