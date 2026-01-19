//package com.campus.model;
//
//import java.sql.Date;
//
//public class FoundItem {
//    private int foundId;
//    private int userId;
//    private String itemName;
//    private String description;
//    private String location;
//    private Date foundDate;
//    private String contact;
//    private String status;
//    private String userName; // For display purposes
//    
//    public FoundItem() {}
//    
//    public FoundItem(int userId, String itemName, String description, 
//                     String location, Date foundDate, String contact) {
//        this.userId = userId;
//        this.itemName = itemName;
//        this.description = description;
//        this.location = location;
//        this.foundDate = foundDate;
//        this.contact = contact;
//    }
//    
//    // Getters and Setters
//    public int getFoundId() { return foundId; }
//    public void setFoundId(int foundId) { this.foundId = foundId; }
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
//    public Date getFoundDate() { return foundDate; }
//    public void setFoundDate(Date foundDate) { this.foundDate = foundDate; }
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

public class FoundItem {
    private int foundId;
    private int userId;
    private String itemName;
    private String description;
    private String location;
    private Date foundDate;
    private String contact;
    private String status;
    private String userName; // For display purposes
    
    public FoundItem() {}
    
    public FoundItem(int userId, String itemName, String description, 
                     String location, Date foundDate, String contact) {
        this.userId = userId;
        this.itemName = itemName;
        this.description = description;
        this.location = location;
        this.foundDate = foundDate;
        this.contact = contact;
    }
    
    // Getters and Setters
    public int getFoundId() { return foundId; }
    public void setFoundId(int foundId) { this.foundId = foundId; }
    
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public String getItemName() { return itemName; }
    public void setItemName(String itemName) { this.itemName = itemName; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
    
    public Date getFoundDate() { return foundDate; }
    public void setFoundDate(Date foundDate) { this.foundDate = foundDate; }
    
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