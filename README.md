# BuildBot

BuildBot is a web application designed for Age of Empires 2 players to create, manage, and explore build orders for different civilizations. The application allows users to save custom build orders and browse preset builds created by the community.

## Features

- **User Authentication**: Secure signup and login system for users
- **Create Custom Builds**: Design your own build orders with step-by-step instructions for any civilization
- **Explore Preset Builds**: Browse and discover build orders created by other players
- **Save Builds**: Save preset builds to your personal collection for easy access
- **Manage Your Builds**: View and manage all your saved and created build orders
- **Dashboard**: Centralized interface to access all features

## Technology Stack

- **Backend**: Java (JSP - JavaServer Pages)
- **ORM**: Hibernate
- **Database**: Apache Derby
- **Build Tool**: Apache Ant (NetBeans project)
- **Frontend**: HTML, CSS, JavaScript

## Prerequisites

Before running this application, ensure you have the following installed:

- Java Development Kit (JDK) 8 or higher
- Apache Derby Database
- Apache Tomcat or another Java web server
- NetBeans IDE (recommended) or any Java IDE
- Apache Ant (usually comes with NetBeans)

## Database Setup

1. **Install Apache Derby**: Download and install Apache Derby from the official website

2. **Start Derby Server**:
   ```bash
   startNetworkServer
   ```

3. **Create Database**:
   ```sql
   CREATE DATABASE BuildBotDB;
   ```

4. **Database Configuration**: The application is configured to use:
   - Database: `BuildBotDB`
   - Host: `localhost:1527`
   - Username: `buildbot`
   - Password: `aoe2`

5. **Create User** (if needed):
   ```sql
   CALL SYSCS_UTIL.SYSCS_SET_DATABASE_PROPERTY('derby.user.buildbot', 'aoe2');
   ```

Note: Hibernate will automatically create the required tables on first run using the `hibernate.hbm2ddl.auto=update` setting.

## Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/pkrockz/BuildBot.git
   cd BuildBot
   ```

2. **Configure Database Connection**:
   - Open `src/java/hibernate.cfg.xml`
   - Verify/update the database connection settings if needed

3. **Build the project**:
   Using Apache Ant:
   ```bash
   ant clean
   ant build
   ```
   
   Or using NetBeans:
   - Open the project in NetBeans
   - Right-click the project and select "Clean and Build"

4. **Deploy to Web Server**:
   - Deploy the generated WAR file from the `dist` directory to your Tomcat server
   - Or run directly from NetBeans using "Run Project"

## Usage

1. **Access the Application**:
   - Open your web browser and navigate to `http://localhost:8080/BuildBot` (or your configured server address)

2. **Create an Account**:
   - Click on "Signup here" on the login page
   - Fill in your username, email, and password
   - Submit the form to create your account

3. **Login**:
   - Enter your username and password
   - Click "Login" to access the dashboard

4. **Dashboard Options**:
   - **My Builds**: View and manage your saved build orders
   - **Explore New Builds**: Browse preset build orders from the community
   - **Create Your Own Build**: Design custom build orders

5. **Create a Build Order**:
   - Click "Create Your Own Build"
   - Enter the build name (e.g., "Fast Castle")
   - Enter the civilization (e.g., "Britons")
   - Add build steps, one per line
   - Submit to save your build

## Project Structure

```
BuildBot/
├── build.xml              # Ant build configuration
├── nbproject/             # NetBeans project files
├── src/
│   ├── conf/              # Configuration files
│   └── java/
│       ├── buildbot/      # Java source files
│       │   ├── User.java
│       │   ├── UserBuild.java
│       │   ├── UserBuildStep.java
│       │   ├── PresetBuild.java
│       │   └── PresetBuildStep.java
│       └── hibernate.cfg.xml  # Hibernate configuration
├── web/                   # Web resources (HTML, JSP, CSS, images)
│   ├── *.html            # Static HTML pages
│   ├── *.jsp             # JavaServer Pages
│   ├── *.css             # Stylesheets
│   ├── images/           # Image assets
│   └── WEB-INF/          # Web application configuration
└── README.md             # This file
```

## Database Schema

The application uses the following main entities:

- **users**: Stores user account information
- **user_builds**: Stores user-created build orders
- **user_build_steps**: Stores steps for user-created builds
- **preset_builds**: Stores community/preset build orders
- **preset_build_steps**: Stores steps for preset builds

## Contributing

Contributions are welcome! If you'd like to contribute:

1. Fork the repository
2. Create a new branch (`git checkout -b feature/your-feature`)
3. Make your changes
4. Commit your changes (`git commit -m 'Add some feature'`)
5. Push to the branch (`git push origin feature/your-feature`)
6. Open a Pull Request

## License

This project is open source and available for educational purposes.

## About Age of Empires 2

Age of Empires 2 is a real-time strategy game where build orders are crucial for competitive play. A build order is a predetermined sequence of actions that players follow to achieve specific goals efficiently, such as reaching the Castle Age quickly or creating a military rush strategy.

## Support

For issues, questions, or suggestions, please open an issue on the GitHub repository.
