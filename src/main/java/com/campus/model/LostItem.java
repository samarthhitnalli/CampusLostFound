//package com.campus.model;
//
//import java.sql.Date;
//
//public class LostItem {
//    private int lostId;
//    private int userId;
//    private String itemName;
//    private String description;
//    private String location;
//    private Date lostDate;
//    private String contact;
//    private String status;
//    private String userName; // For display purposes
//    
//    public LostItem() {}
//    
//    public LostItem(int userId, String itemName, String description, 
//                    String location, Date lostDate, String contact) {
//        this.userId = userId;
//        this.itemName = itemName;
//        this.description = description;
//        this.location = location;
//        this.lostDate = lostDate;
//        this.contact = contact;
//    }
//    
//    // Getters and Setters
//    public int getLostId() { return lostId; }
//    public void setLostId(int lostId) { this.lostId = lostId; }
//    
//    public int getUserId() { return userId; }
//    public void setUserId(int userId) { this.userId = userId; }
//    
//    public String getItemName() { return itemName; }
//    public void setItemName(String itemName) { this.itemName = itemName; }
//    
//    public String getDescription() { return description; }
//    public void setDescription(String description) { this.description = description; }
//    
//    public String getLocation() { return location; }
//    public void setLocation(String location) { this.location = location; }
//    
//    public Date getLostDate() { return lostDate; }
//    public void setLostDate(Date lostDate) { this.lostDate = lostDate; }
//    
//    public String getContact() { return contact; }
//    public void setContact(String contact) { this.contact = contact; }
//    
//    public String getStatus() { return status; }
//    public void setStatus(String status) { this.status = status; }
//    
//    public String getUserName() { return userName; }
//    public void setUserName(String userName) { this.userName = userName; }
//}
package com.campus.model;

import java.sql.Date;

public class LostItem {
    private int lostId;
    private int userId;
    private String itemName;
    private String description;
    private String location;
    private Date lostDate;
    private String contact;
    private String status;
    private String userName; // For display purposes
    
    public LostItem() {}
    
    public LostItem(int userId, String itemName, String description, 
                    String location, Date lostDate, String contact) {
        this.userId = userId;
        this.itemName = itemName;
        this.description = description;
        this.location = location;
        this.lostDate = lostDate;
        this.contact = contact;
    }
    
    // Getters and Setters
    public int getLostId() { return lostId; }
    public void setLostId(int lostId) { this.lostId = lostId; }
    
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public String getItemName() { return itemName; }
    public void setItemName(String itemName) { this.itemName = itemName; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
    
    public Date getLostDate() { return lostDate; }
    public void setLostDate(Date lostDate) { this.lostDate = lostDate; }
    
    public String getContact() { return contact; }
    public void setContact(String contact) { this.contact = contact; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }
    
    private String imagePath;

    public String getImagePath() { 
        return imagePath; 
    }

    public void setImagePath(String imagePath) { 
        this.imagePath = imagePath; 
    }
}