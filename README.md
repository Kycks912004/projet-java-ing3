[![Code Source](https://img.shields.io/badge/Java-Voir%20le%20code%20source-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)](https://github.com/Kycks912004/projet-java-ing3/tree/main/projet-java-ing3-2025-ing3-java-2025-11-2-main/src)
[![GitHub](https://img.shields.io/badge/GitHub-Repo-181717?style=for-the-badge&logo=github)](https://github.com/Kycks912004/projet-java-ing3)

# 🏨 Booking Application — Java OOP

## 🖼️ Architecture du Projet

<div align="center">

**Diagramme de classes complet (UML)**

![Diagramme de classes](https://raw.githubusercontent.com/Kycks912004/projet-java-ing3/main/projet-java-ing3-2025-ing3-java-2025-11-2-main/docs/diagramme_classe_complet.png)

**Vue simplifiée**

![Diagramme simplifié](https://raw.githubusercontent.com/Kycks912004/projet-java-ing3/main/projet-java-ing3-2025-ing3-java-2025-11-2-main/docs/diagramme_classe_sans_m%C3%A9thodes.png)

</div>

---

This Java-based Booking Application allows users to book accommodations with a user-friendly graphical interface following the MVC (Model-View-Controller) architecture pattern.

## Features

- User authentication and registration
- Accommodation search with multiple filters
- Booking management for users
- Payment processing simulation
- Admin dashboard with statistics
- Review and rating system
- Promotions and discount management

## Technologies Used

- Java 8+
- Swing GUI
- JDBC for database connectivity
- MySQL database
- JFreeChart for generating statistics
- Maven for dependency management

## Project Structure

The application follows the MVC architecture:

- **Model**: Java classes representing system entities
- **View**: GUI components for user interaction
- **Controller**: Logic that connects the model and view
- **DAO**: Data Access Objects to handle database operations

## Database Schema

The application uses a MySQL database with the following tables:

- Users
- Accommodations
- Bookings
- Promotions
- Reviews
- Payments

## Getting Started

### Prerequisites

- Java 8 or higher
- MySQL 5.7 or higher
- Maven

### Installation

1. Clone the repository
2. Create a MySQL database named `booking_db`
3. Execute the SQL scripts in the `src/main/resources/db` folder:
   - `create_database.sql`
   - `insert_sample_data.sql`
4. Update the database credentials in `src/main/java/com/booking/utils/DatabaseConnection.java` if needed
5. Build the project using Maven:
   ```
   mvn clean package
   ```
6. Run the application:
   ```
   java -jar target/booking-app-1.0-SNAPSHOT-jar-with-dependencies.jar
   ```

## Usage

### Login Credentials

Default credentials are defined in `insert_sample_data.sql` — update them before any production use.

### User Features

- Search for accommodations by city, type, and price
- View accommodation details
- Make bookings
- Apply promotional codes
- View booking history
- Cancel bookings
- Submit reviews

### Admin Features

- Manage users
- Manage accommodations
- Track bookings
- Create and manage promotions
- View statistics and reports

## UML Diagrams

UML diagrams are stored in the `docs` folder.

## Author

**Kylian Pinto** — M1 Ingénierie Data & IA, ECE Paris  
[![GitHub](https://img.shields.io/badge/GitHub-Kycks912004-181717?style=flat&logo=github)](https://github.com/Kycks912004)

## License

This project is licensed under the MIT License - see the LICENSE file for details.
