# 📌 Campus Lost & Found Portal

<div align="center">

![Java](https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)
![JSP](https://img.shields.io/badge/JSP-007396?style=for-the-badge&logo=java&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-005C84?style=for-the-badge&logo=mysql&logoColor=white)
![Bootstrap](https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white)
![Apache Tomcat](https://img.shields.io/badge/Apache%20Tomcat-F8DC75?style=for-the-badge&logo=apachetomcat&logoColor=black)

**A modern web-based platform to report, search, and recover lost items on campus**

[Features](#-features) • [Installation](#-installation) • [Usage](#-usage) • [Documentation](#-documentation) • [Contributing](#-contributing)

</div>

---

## 📖 Table of Contents

- [About](#-about)
- [Problem Statement](#-problem-statement)
- [Features](#-features)
- [Technology Stack](#-technology-stack)
- [Screenshots](#-screenshots)
- [Installation](#-installation)
- [Configuration](#%EF%B8%8F-configuration)
- [Usage](#-usage)
- [Project Structure](#-project-structure)
- [Database Schema](#-database-schema)
- [API Endpoints](#-api-endpoints)
- [Troubleshooting](#-troubleshooting)
- [Contributing](#-contributing)
- [License](#-license)
- [Contact](#-contact)

---

## 🎯 About

**Campus Lost & Found Portal** is a full-stack web application designed to help students and staff efficiently report and recover lost items on campus. It replaces inefficient manual tracking methods (notice boards, WhatsApp groups) with a centralized, organized digital platform.

### Why This Project?

In educational institutions, lost items are typically managed through:
- ❌ Physical notice boards (limited reach)
- ❌ WhatsApp groups (unorganized, hard to search)
- ❌ Word-of-mouth (unreliable)

**Our Solution:**
- ✅ Centralized digital platform
- ✅ Image-based item identification
- ✅ Advanced search and filtering
- ✅ Real-time updates
- ✅ Direct contact between finders and owners

---

## 🔍 Problem Statement

In many colleges, offices, hostels, and public places, students and staff frequently lose personal belongings such as:
- ID cards
- Wallets
- Mobile phones
- Keys
- Water bottles
- Laptops

**Current Challenges:**
- Difficulty tracking lost items
- No centralized record system
- Time wastage for students and administrators
- Low recovery chances

**Our Solution Provides:**
- User-friendly interface
- Secure data storage in MySQL
- CRUD operations using Java Servlets, JSP, and JDBC
- Search and filtering options
- Image upload for better identification
- Improved transparency and organization

---

## ✨ Features

### 👤 User Features

| Feature | Description |
|---------|-------------|
| 🔐 **User Authentication** | Secure registration and login system |
| 📝 **Report Lost Items** | Report lost items with detailed descriptions and images |
| ✅ **Report Found Items** | Help others by reporting found items |
| 🔍 **Advanced Search** | Filter items by name, location, date |
| 🖼️ **Image Upload** | Upload photos for better item identification |
| 📱 **Responsive Design** | Works seamlessly on mobile, tablet, and desktop |
| 🔔 **Status Updates** | Mark items as resolved when recovered |
| 📊 **Personal Dashboard** | View and manage your reported items |

### 🔧 Admin Features

| Feature | Description |
|---------|-------------|
| 👥 **User Management** | View and manage all registered users |
| 📋 **Item Management** | Access all lost and found items |
| 🗑️ **Spam Control** | Delete fake or inappropriate posts |
| 📈 **Statistics Dashboard** | View platform usage statistics |
| 🖼️ **Image Preview** | View item images in full screen |

### 💻 Technical Features

- **MVC Architecture** - Clean separation of concerns
- **DAO Pattern** - Organized database operations
- **Session Management** - Secure user sessions
- **File Upload** - Servlet 3.0+ multipart support
- **Responsive UI** - Bootstrap 5 with modern design
- **Image Gallery** - Grid layout with hover effects
- **Modal Previews** - Full-screen image viewing

---

## 🛠️ Technology Stack

### Frontend
- **HTML5** - Semantic markup
- **CSS3** - Modern styling with gradients and animations
- **JavaScript** - Dynamic interactions
- **Bootstrap 5.3** - Responsive framework
- **Bootstrap Icons** - Icon library

### Backend
- **Java (JDK 8+)** - Core programming language
- **Servlets** - Request handling
- **JSP** - Dynamic page generation
- **JDBC** - Database connectivity

### Database
- **MySQL 8.x** - Relational database

### Server
- **Apache Tomcat 9.x/10.x** - Servlet container

### Architecture
- **MVC Pattern** - Model-View-Controller
- **DAO Pattern** - Data Access Object

---

## 📸 Screenshots

### Landing Page
*Modern hero section with gradient background and feature showcase*

### User Dashboard
*Card-based dashboard with quick action buttons*

### Report Lost Item
*Clean form with drag-and-drop image upload and live preview*

### Lost Items Gallery
*Responsive grid layout with hover zoom effects*

### Admin Dashboard
*Statistics overview with tabbed interface for managing users and items*

### Search Results
*Unified search with separated sections for lost and found items*

---

## 📥 Installation

### Prerequisites

Before you begin, ensure you have the following installed:

- ✅ **JDK 8 or higher** - [Download](https://www.oracle.com/java/technologies/downloads/)
- ✅ **Apache Tomcat 9.x or 10.x** - [Download](https://tomcat.apache.org/download-90.cgi)
- ✅ **MySQL Server 8.x** - [Download](https://dev.mysql.com/downloads/mysql/)
- ✅ **MySQL JDBC Driver** - [Download](https://dev.mysql.com/downloads/connector/j/)
- ✅ **IDE** (Optional) - Eclipse, IntelliJ IDEA, or NetBeans

### Step-by-Step Setup

#### 1️⃣ Clone the Repository

```bash
git clone https://github.com/samarthhitnalli/CampusLostFound.git
cd CampusLostFound
```

#### 2️⃣ Database Setup

Start MySQL and create the database:

```bash
mysql -u root -p
```

Run the SQL script:

```sql
source database_schema.sql
```

Or manually execute:

```sql
CREATE DATABASE campus_lost_found;
USE campus_lost_found;

-- Create tables
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('user', 'admin') DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE lost_items (
    lost_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    item_name VARCHAR(100) NOT NULL,
    description TEXT,
    location VARCHAR(255) NOT NULL,
    lost_date DATE NOT NULL,
    contact VARCHAR(15) NOT NULL,
    image_path VARCHAR(255),
    status ENUM('lost', 'resolved') DEFAULT 'lost',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE found_items (
    found_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    item_name VARCHAR(100) NOT NULL,
    description TEXT,
    location VARCHAR(255) NOT NULL,
    found_date DATE NOT NULL,
    contact VARCHAR(15) NOT NULL,
    image_path VARCHAR(255),
    status ENUM('found', 'resolved') DEFAULT 'found',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Insert default admin
INSERT INTO users (name, email, phone, password, role) 
VALUES ('Admin', 'admin@campus.com', '9999999999', 'admin123', 'admin');
```

#### 3️⃣ Configure Database Connection

Edit `src/com/campus/util/DatabaseConnection.java`:

```java
private static final String URL = "jdbc:mysql://localhost:3306/campus_lost_found";
private static final String USERNAME = "root";
private static final String PASSWORD = "your_mysql_password"; // Update this
```

#### 4️⃣ Add Dependencies

Place `mysql-connector-java-8.x.x.jar` in:
```
WebContent/WEB-INF/lib/
```

#### 5️⃣ Create Upload Directory

Create the uploads folder:
```
WebContent/uploads/
```

#### 6️⃣ IDE Setup (Eclipse)

1. **Import Project**
   - File → Import → Existing Projects into Workspace
   - Select project directory

2. **Configure Build Path**
   - Right-click project → Build Path → Configure Build Path
   - Add MySQL connector JAR to Libraries

3. **Configure Tomcat**
   - Window → Preferences → Server → Runtime Environments
   - Add Apache Tomcat 9.x
   - Browse to installation directory

4. **Deploy**
   - Right-click project → Run As → Run on Server
   - Select Tomcat server

#### 7️⃣ Manual Deployment

If not using an IDE:

1. Export project as WAR file
2. Copy WAR to `tomcat/webapps/`
3. Start Tomcat:

```bash
# Windows
cd C:\apache-tomcat-9.0.x\bin
startup.bat

# Linux/Mac
cd /path/to/tomcat/bin
./startup.sh
```

---

## ⚙️ Configuration

### Database Configuration

File: `src/com/campus/util/DatabaseConnection.java`

```java
private static final String URL = "jdbc:mysql://localhost:3306/campus_lost_found";
private static final String USERNAME = "root";
private static final String PASSWORD = "your_password";
```

### Server Configuration

- **Default Port:** 8080
- **Context Path:** `/CampusLostFound`
- **Session Timeout:** 30 minutes

### Application Settings

File: `WebContent/WEB-INF/web.xml`

```xml
<session-config>
    <session-timeout>30</session-timeout>
</session-config>
```

### File Upload Settings

- **Max File Size:** 5 MB
- **Allowed Formats:** JPG, PNG, GIF
- **Upload Directory:** `WebContent/uploads/`

---

## 🚀 Usage

### Accessing the Application

Open your browser and navigate to:

```
http://localhost:8080/CampusLostFound/
```

### Demo Credentials

#### Admin Account
```
Email: admin@campus.com
Password: admin123
```

#### User Account
```
Email: john@campus.com
Password: pass123
```

### User Workflow

#### 1. Register/Login
- Click "Create Account" or "Sign In"
- Fill in your details
- Submit the form

#### 2. Report a Lost Item
- Navigate to Dashboard
- Click "Report Lost Item"
- Fill in item details:
  - Item name
  - Description
  - Location where lost
  - Date lost
  - Contact number
  - Upload image (optional)
- Submit

#### 3. Report a Found Item
- Click "Report Found Item"
- Provide item details with image
- Submit

#### 4. Search for Items
- Go to "View Lost Items" or "View Found Items"
- Use search filters:
  - Search by item name
  - Filter by location
  - Filter by date
- Click item images for full-screen preview

#### 5. Contact & Resolve
- View contact information
- Call/message the finder/owner
- Mark item as "Resolved" after recovery

### Admin Workflow

#### 1. Access Admin Panel
- Login with admin credentials
- View dashboard statistics

#### 2. Manage Users
- Click "Users" tab
- View all registered users
- Monitor user activity

#### 3. Manage Items
- Click "Lost Items" or "Found Items" tab
- View all reported items with images
- Delete spam/fake posts

#### 4. Monitor Statistics
- View total users count
- Check lost items count
- Check found items count

---

## 📁 Project Structure

```
CampusLostFound/
│
├── src/
│   └── com/
│       └── campus/
│           ├── model/                    # Data Models (POJOs)
│           │   ├── User.java            # User entity
│           │   ├── LostItem.java        # Lost item entity
│           │   └── FoundItem.java       # Found item entity
│           │
│           ├── dao/                      # Data Access Objects
│           │   ├── UserDAO.java         # User database operations
│           │   ├── LostDAO.java         # Lost items operations
│           │   └── FoundDAO.java        # Found items operations
│           │
│           ├── servlet/                  # Controllers
│           │   ├── RegisterServlet.java # User registration
│           │   ├── LoginServlet.java    # User authentication
│           │   ├── LogoutServlet.java   # Session management
│           │   ├── LostItemServlet.java # Lost item operations
│           │   ├── FoundItemServlet.java# Found item operations
│           │   └── SearchServlet.java   # Search functionality
│           │
│           └── util/                     # Utilities
│               └── DatabaseConnection.java # DB connection manager
│
├── WebContent/                           # Web Resources
│   ├── uploads/                         # Uploaded images
│   │
│   ├── WEB-INF/
│   │   ├── lib/
│   │   │   └── mysql-connector-java-8.x.x.jar
│   │   └── web.xml                      # Deployment descriptor
│   │
│   ├── index.jsp                        # Landing page
│   ├── login.jsp                        # Login page
│   ├── register.jsp                     # Registration page
│   ├── user-dashboard.jsp               # User home
│   ├── admin-dashboard.jsp              # Admin panel
│   ├── report-lost.jsp                  # Report lost form
│   ├── report-found.jsp                 # Report found form
│   ├── view-lost.jsp                    # Lost items gallery
│   ├── view-found.jsp                   # Found items gallery
│   └── search-results.jsp               # Search results
│
├── database_schema.sql                   # Database setup script
├── README.md                            # This file
└── LICENSE                              # License file
```

---

## 🗄️ Database Schema

### Table Details

#### `users`
| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| user_id | INT | PRIMARY KEY, AUTO_INCREMENT | Unique user identifier |
| name | VARCHAR(100) | NOT NULL | Full name |
| email | VARCHAR(100) | UNIQUE, NOT NULL | Email address |
| phone | VARCHAR(15) | NOT NULL | Contact number |
| password | VARCHAR(255) | NOT NULL | User password |
| role | ENUM('user','admin') | DEFAULT 'user' | User role |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Registration date |

#### `lost_items`
| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| lost_id | INT | PRIMARY KEY, AUTO_INCREMENT | Unique item identifier |
| user_id | INT | FOREIGN KEY → users | Reporter user ID |
| item_name | VARCHAR(100) | NOT NULL | Name of item |
| description | TEXT | - | Detailed description |
| location | VARCHAR(255) | NOT NULL | Location where lost |
| lost_date | DATE | NOT NULL | Date when lost |
| contact | VARCHAR(15) | NOT NULL | Contact number |
| image_path | VARCHAR(255) | - | Path to uploaded image |
| status | ENUM('lost','resolved') | DEFAULT 'lost' | Item status |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Report date |

#### `found_items`
| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| found_id | INT | PRIMARY KEY, AUTO_INCREMENT | Unique item identifier |
| user_id | INT | FOREIGN KEY → users | Reporter user ID |
| item_name | VARCHAR(100) | NOT NULL | Name of item |
| description | TEXT | - | Detailed description |
| location | VARCHAR(255) | NOT NULL | Location where found |
| found_date | DATE | NOT NULL | Date when found |
| contact | VARCHAR(15) | NOT NULL | Contact number |
| image_path | VARCHAR(255) | - | Path to uploaded image |
| status | ENUM('found','resolved') | DEFAULT 'found' | Item status |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Report date |

---

## 🔌 API Endpoints

### Authentication

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/register` | Register new user |
| POST | `/login` | User login |
| GET | `/logout` | User logout |

### Lost Items

| Method | Endpoint | Parameters | Description |
|--------|----------|------------|-------------|
| POST | `/lost-item` | action=add | Report lost item |
| POST | `/lost-item` | action=updateStatus | Mark as resolved |
| POST | `/lost-item` | action=delete | Delete item (admin) |

### Found Items

| Method | Endpoint | Parameters | Description |
|--------|----------|------------|-------------|
| POST | `/found-item` | action=add | Report found item |
| POST | `/found-item` | action=updateStatus | Mark as resolved |
| POST | `/found-item` | action=delete | Delete item (admin) |

### Search

| Method | Endpoint | Parameters | Description |
|--------|----------|------------|-------------|
| GET | `/search` | keyword, location, date, type | Search items |

---

## 🐛 Troubleshooting

### Common Issues and Solutions

#### ❌ Issue: ClassNotFoundException: com.mysql.cj.jdbc.Driver

**Solution:**
```bash
1. Verify MySQL connector JAR is in WebContent/WEB-INF/lib/
2. Clean and rebuild project
3. Check Build Path configuration
```

#### ❌ Issue: Unable to connect to database

**Solution:**
```bash
1. Check if MySQL service is running:
   # Windows
   net start MySQL80
   
   # Linux
   sudo systemctl start mysql

2. Verify credentials in DatabaseConnection.java
3. Test connection string: jdbc:mysql://localhost:3306/campus_lost_found
4. Ensure database exists: SHOW DATABASES;
```

#### ❌ Issue: 404 Error - Page Not Found

**Solution:**
```bash
1. Check URL context path: /CampusLostFound/
2. Verify Tomcat deployment
3. Ensure JSP files are in WebContent/ directory
4. Check Tomcat logs in tomcat/logs/catalina.out
```

#### ❌ Issue: Images not uploading

**Solution:**
```bash
1. Create WebContent/uploads/ folder
2. Check folder permissions (read/write)
3. Verify file size (max 5MB)
4. Check file extension (jpg, png, gif)
```

#### ❌ Issue: Images not displaying

**Solution:**
```bash
1. Check image_path in database
2. Verify uploads folder exists and is accessible
3. Clear browser cache
4. Check browser DevTools console for 404 errors
```

#### ❌ Issue: Servlet not found

**Solution:**
```bash
1. Ensure @WebServlet annotations are present
2. Clean and rebuild project
3. Check web.xml configuration
4. Restart Tomcat server
```

#### ❌ Issue: Session timeout

**Solution:**
```xml
<!-- Increase timeout in web.xml -->
<session-config>
    <session-timeout>60</session-timeout> <!-- 60 minutes -->
</session-config>
```

---

## 🤝 Contributing

We welcome contributions from the community! Here's how you can help:

### How to Contribute

1. **Fork the Repository**
   ```bash
   git clone https://github.com/samarthhitnalli/CampusLostFound.git
   ```

2. **Create a Feature Branch**
   ```bash
   git checkout -b feature/AmazingFeature
   ```

3. **Make Your Changes**
   - Write clean, documented code
   - Follow existing code style
   - Add comments where necessary

4. **Commit Your Changes**
   ```bash
   git commit -m 'Add some AmazingFeature'
   ```

5. **Push to Branch**
   ```bash
   git push origin feature/AmazingFeature
   ```

6. **Open a Pull Request**
   - Provide a clear description
   - Reference any related issues

### Coding Standards

- **Java:**
  - Follow Java naming conventions
  - Use meaningful variable names
  - Add JavaDoc comments for classes and methods

- **JSP:**
  - Proper HTML5 semantic structure
  - Consistent indentation (4 spaces)
  - Separate concerns (logic vs presentation)

- **SQL:**
  - Use uppercase for SQL keywords
  - Proper indexing for performance

### Areas for Contribution

- 🐛 Bug fixes
- ✨ New features
- 📝 Documentation improvements
- 🎨 UI/UX enhancements
- ⚡ Performance optimizations
- 🔒 Security improvements

---

## 📜 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

```
MIT License

Copyright (c) 2026 Samarth Hitnalli

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

## 👥 Authors & Credits

### Development Team

- **SAMARTH HITNALLI** - *Lead Developer* - [GitHub](https://github.com/samarthhitnalli)


### Acknowledgments

- [Bootstrap](https://getbootstrap.com/) - UI Framework
- [Bootstrap Icons](https://icons.getbootstrap.com/) - Icon Library
- [Apache Tomcat](https://tomcat.apache.org/) - Servlet Container
- [MySQL](https://www.mysql.com/) - Database System
- Stack Overflow community for troubleshooting help
- All contributors who helped improve this project

---

### Report Issues

Found a bug or have a feature request?
- 🐛 [Report Bug](https://github.com/samarthhitnalli/CampusLostFound/issues)
- 💡 [Request Feature](https://github.com/samarthhitnalli/CampusLostFound/issues)

### Project Links

- 📂 **Repository:** [https://github.com/samarthhitnalli/CampusLostFound](https://github.com/samarthhitnalli/CampusLostFound)
- 📖 **Documentation:** [Wiki](https://github.com/samarthhitnalli/CampusLostFound/wiki)
- 🎥 **Demo Video:** [YouTube to be Uploaded](https://youtube.com/watch?v=your-video-id)

---

## 🔮 Future Enhancements

### Planned Features

- [ ] Email notifications when matching items are found
- [ ] SMS alerts for item recovery
- [ ] Mobile application (Android/iOS)
- [ ] Advanced AI-based image matching
- [ ] Multi-language support
- [ ] Chat system between users
- [ ] Password recovery functionality
- [ ] User rating and review system
- [ ] Analytics dashboard with charts
- [ ] Export reports to PDF
- [ ] Integration with campus ID system
- [ ] QR code generation for items
- [ ] Geolocation-based search
- [ ] Push notifications
- [ ] Social media integration

### Security Enhancements

- [ ] Password hashing (BCrypt/Argon2)
- [ ] CSRF token protection
- [ ] SQL injection prevention
- [ ] XSS attack prevention
- [ ] Rate limiting
- [ ] Two-factor authentication
- [ ] Session encryption
- [ ] Input sanitization

---

## 📊 Project Statistics

![GitHub stars](https://img.shields.io/github/stars/samarthhitnalli/CampusLostFound?style=social)
![GitHub forks](https://img.shields.io/github/forks/samarthhitnalli/CampusLostFound?style=social)
![GitHub watchers](https://img.shields.io/github/watchers/samarthhitnalli/CampusLostFound?style=social)
![GitHub issues](https://img.shields.io/github/issues/samarthhitnalli/CampusLostFound)
![GitHub pull requests](https://img.shields.io/github/issues-pr/samarthhitnalli/CampusLostFound)
![GitHub last commit](https://img.shields.io/github/last-commit/samarthhitnalli/CampusLostFound)
![GitHub repo size](https://img.shields.io/github/repo-size/samarthhitnalli/CampusLostFound)

---

## 🙏 Support

If you found this project helpful, please consider:

- ⭐ Starring the repository
- 🐛 Reporting bugs
- 💡 Suggesting new features
- 📖 Improving documentation
- 🔀 Submitting pull requests

---

<div align="center">

**Made with ❤️ by Samarth**

*Helping students reunite with their belongings, one item at a time*

[⬆ Back to Top](#-campus-lost--found-portal)

</div>