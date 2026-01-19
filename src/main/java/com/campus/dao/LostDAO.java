//package com.campus.dao;
//
//import com.campus.model.LostItem;
//import com.campus.util.DatabaseConnection;
//import java.sql.*;
//import java.util.ArrayList;
//import java.util.List;
//
//public class LostDAO {
//    
//    public boolean addLostItem(LostItem item) {
//        String sql = "INSERT INTO lost_items (user_id, item_name, description, location, lost_date, contact) VALUES (?, ?, ?, ?, ?, ?)";
//        try (Connection conn = DatabaseConnection.getConnection();
//             PreparedStatement pstmt = conn.prepareStatement(sql)) {
//            
//            pstmt.setInt(1, item.getUserId());
//            pstmt.setString(2, item.getItemName());
//            pstmt.setString(3, item.getDescription());
//            pstmt.setString(4, item.getLocation());
//            pstmt.setDate(5, item.getLostDate());
//            pstmt.setString(6, item.getContact());
//            
//            return pstmt.executeUpdate() > 0;
//        } catch (SQLException e) {
//            e.printStackTrace();
//            return false;
//        }
//    }
//    
//    public List<LostItem> getAllLostItems() {
//        List<LostItem> items = new ArrayList<>();
//        String sql = "SELECT l.*, u.name as user_name FROM lost_items l " +
//                     "JOIN users u ON l.user_id = u.user_id ORDER BY l.created_at DESC";
//        
//        try (Connection conn = DatabaseConnection.getConnection();
//             Statement stmt = conn.createStatement();
//             ResultSet rs = stmt.executeQuery(sql)) {
//            
//            while (rs.next()) {
//                LostItem item = new LostItem();
//                item.setLostId(rs.getInt("lost_id"));
//                item.setUserId(rs.getInt("user_id"));
//                item.setItemName(rs.getString("item_name"));
//                item.setDescription(rs.getString("description"));
//                item.setLocation(rs.getString("location"));
//                item.setLostDate(rs.getDate("lost_date"));
//                item.setContact(rs.getString("contact"));
//                item.setStatus(rs.getString("status"));
//                item.setUserName(rs.getString("user_name"));
//                items.add(item);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return items;
//    }
//    
//    public List<LostItem> searchLostItems(String keyword, String location, String date) {
//        List<LostItem> items = new ArrayList<>();
//        StringBuilder sql = new StringBuilder(
//            "SELECT l.*, u.name as user_name FROM lost_items l " +
//            "JOIN users u ON l.user_id = u.user_id WHERE 1=1"
//        );
//        
//        if (keyword != null && !keyword.trim().isEmpty()) {
//            sql.append(" AND (l.item_name LIKE ? OR l.description LIKE ?)");
//        }
//        if (location != null && !location.trim().isEmpty()) {
//            sql.append(" AND l.location LIKE ?");
//        }
//        if (date != null && !date.trim().isEmpty()) {
//            sql.append(" AND l.lost_date = ?");
//        }
//        sql.append(" ORDER BY l.created_at DESC");
//        
//        try (Connection conn = DatabaseConnection.getConnection();
//             PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {
//            
//            int paramIndex = 1;
//            if (keyword != null && !keyword.trim().isEmpty()) {
//                String searchPattern = "%" + keyword + "%";
//                pstmt.setString(paramIndex++, searchPattern);
//                pstmt.setString(paramIndex++, searchPattern);
//            }
//            if (location != null && !location.trim().isEmpty()) {
//                pstmt.setString(paramIndex++, "%" + location + "%");
//            }
//            if (date != null && !date.trim().isEmpty()) {
//                pstmt.setDate(paramIndex++, Date.valueOf(date));
//            }
//            
//            ResultSet rs = pstmt.executeQuery();
//            while (rs.next()) {
//                LostItem item = new LostItem();
//                item.setLostId(rs.getInt("lost_id"));
//                item.setUserId(rs.getInt("user_id"));
//                item.setItemName(rs.getString("item_name"));
//                item.setDescription(rs.getString("description"));
//                item.setLocation(rs.getString("location"));
//                item.setLostDate(rs.getDate("lost_date"));
//                item.setContact(rs.getString("contact"));
//                item.setStatus(rs.getString("status"));
//                item.setUserName(rs.getString("user_name"));
//                items.add(item);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return items;
//    }
//    
//    public boolean updateStatus(int lostId, String status) {
//        String sql = "UPDATE lost_items SET status = ? WHERE lost_id = ?";
//        try (Connection conn = DatabaseConnection.getConnection();
//             PreparedStatement pstmt = conn.prepareStatement(sql)) {
//            
//            pstmt.setString(1, status);
//            pstmt.setInt(2, lostId);
//            
//            return pstmt.executeUpdate() > 0;
//        } catch (SQLException e) {
//            e.printStackTrace();
//            return false;
//        }
//    }
//    
//    public boolean deleteLostItem(int lostId) {
//        String sql = "DELETE FROM lost_items WHERE lost_id = ?";
//        try (Connection conn = DatabaseConnection.getConnection();
//             PreparedStatement pstmt = conn.prepareStatement(sql)) {
//            
//            pstmt.setInt(1, lostId);
//            return pstmt.executeUpdate() > 0;
//        } catch (SQLException e) {
//            e.printStackTrace();
//            return false;
//        }
//    }
//}
package com.campus.dao;

import com.campus.model.LostItem;
import com.campus.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LostDAO {
    
	public boolean addLostItem(LostItem item) {
	    String sql = "INSERT INTO lost_items (user_id, item_name, description, location, lost_date, contact, image_path) VALUES (?, ?, ?, ?, ?, ?, ?)";
	    try (Connection conn = DatabaseConnection.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        
	        pstmt.setInt(1, item.getUserId());
	        pstmt.setString(2, item.getItemName());
	        pstmt.setString(3, item.getDescription());
	        pstmt.setString(4, item.getLocation());
	        pstmt.setDate(5, item.getLostDate());
	        pstmt.setString(6, item.getContact());
	        pstmt.setString(7, item.getImagePath());
	        
	        return pstmt.executeUpdate() > 0;
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}
    
    public List<LostItem> getAllLostItems() {
        List<LostItem> items = new ArrayList<>();
        String sql = "SELECT l.*, u.name as user_name FROM lost_items l " +
                     "JOIN users u ON l.user_id = u.user_id ORDER BY l.created_at DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                LostItem item = new LostItem();
                item.setLostId(rs.getInt("lost_id"));
                item.setUserId(rs.getInt("user_id"));
                item.setItemName(rs.getString("item_name"));
                item.setDescription(rs.getString("description"));
                item.setLocation(rs.getString("location"));
                item.setLostDate(rs.getDate("lost_date"));
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
    
    public List<LostItem> searchLostItems(String keyword, String location, String date) {
        List<LostItem> items = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT l.*, u.name as user_name FROM lost_items l " +
            "JOIN users u ON l.user_id = u.user_id WHERE 1=1"
        );
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (l.item_name LIKE ? OR l.description LIKE ?)");
        }
        if (location != null && !location.trim().isEmpty()) {
            sql.append(" AND l.location LIKE ?");
        }
        if (date != null && !date.trim().isEmpty()) {
            sql.append(" AND l.lost_date = ?");
        }
        sql.append(" ORDER BY l.created_at DESC");
        
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
                LostItem item = new LostItem();
                item.setLostId(rs.getInt("lost_id"));
                item.setUserId(rs.getInt("user_id"));
                item.setItemName(rs.getString("item_name"));
                item.setDescription(rs.getString("description"));
                item.setLocation(rs.getString("location"));
                item.setLostDate(rs.getDate("lost_date"));
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
    
    public boolean updateStatus(int lostId, String status) {
        String sql = "UPDATE lost_items SET status = ? WHERE lost_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, status);
            pstmt.setInt(2, lostId);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean deleteLostItem(int lostId) {
        String sql = "DELETE FROM lost_items WHERE lost_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, lostId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}