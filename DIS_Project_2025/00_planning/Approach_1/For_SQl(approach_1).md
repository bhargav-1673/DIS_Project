### Entities and Relationships for SQL Database

#### Main Entities
- **Users** (UserID, Name, Email, PasswordHash, Role, Phone, Address, CreatedAt) 
  - Stores information about farmers, buyers, suppliers, and admins.
- **Farms** (FarmID, UserID, FarmName, Location, SoilType, Size) 
  - Contains details of farms managed by users.
- **Crops** (CropID, FarmID, Name, GrowthStage, YieldPrediction, PlantationDate, HarvestDate)
   - Manages information about different crops grown on farms.
- **WeatherData** (WeatherID, FarmID, Temperature, Humidity, Rainfall, SoilMoisture, RecordedAt)
   - Stores real-time weather data related to farms.
- **PestAlerts** (AlertID, FarmID, AlertType, Severity, SuggestedAction, AlertDate) 
  - Logs pest-related alerts and suggested actions.
- **Products** (ProductID, UserID, Name, Category, Price, Stock, Description, ImageURL, CreatedAt)
   - Contains marketplace items including crops, equipment, fertilizers, and others.
- **Orders** (OrderID, BuyerID, TotalAmount, PaymentStatus, OrderStatus, OrderDate)
   - Manages orders placed by buyers.
- **IrrigationLogs** (LogID, FarmID, WaterUsage, RecommendedUsage, RecordedAt)
   - Tracks irrigation activities and recommended water usage.

#### Relationships
- **One-to-Many:** A User can own multiple Farms.
- **One-to-Many:** A Farm can have multiple Crops.
- **One-to-One:** A Farm can have one WeatherData record at a time.
- **One-to-Many:** A Farm can have multiple PestAlerts.
- **One-to-Many:** A User can list multiple Products for sale.
- **Many-to-One:** Multiple Orders can be placed by a single Buyer.- **One-to-Many:** A Farm can have multiple IrrigationLogs.

<hr>

 ```sql
CREATE TABLE Users (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    Role ENUM('Farmer', 'Buyer', 'Supplier', 'Admin') NOT NULL,
    Phone VARCHAR(20),
    Address TEXT,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

``

CREATE TABLE Farms (
    FarmID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    FarmName VARCHAR(255),
    Location VARCHAR(255),
    SoilType VARCHAR(255),
    Size DECIMAL(10,2),
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);

CREATE TABLE Crops (
    CropID INT PRIMARY KEY AUTO_INCREMENT,
    FarmID INT,
    Name VARCHAR(255) NOT NULL,
    GrowthStage VARCHAR(50),
    YieldPrediction DECIMAL(10,2),
    PlantationDate DATE,
    HarvestDate DATE,
    FOREIGN KEY (FarmID) REFERENCES Farms(FarmID) ON DELETE CASCADE
);

CREATE TABLE WeatherData (
    WeatherID INT PRIMARY KEY AUTO_INCREMENT,
    FarmID INT,
    Temperature DECIMAL(5,2),
    Humidity DECIMAL(5,2),
    Rainfall DECIMAL(5,2),
    SoilMoisture DECIMAL(5,2),
    RecordedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (FarmID) REFERENCES Farms(FarmID) ON DELETE CASCADE
);

CREATE TABLE PestAlerts (
    AlertID INT PRIMARY KEY AUTO_INCREMENT,
    FarmID INT,
    AlertType VARCHAR(255),
    Severity ENUM('Low', 'Medium', 'High'),
    SuggestedAction TEXT,
    AlertDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (FarmID) REFERENCES Farms(FarmID) ON DELETE CASCADE
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    Name VARCHAR(255) NOT NULL,
    Category ENUM('Crop', 'Equipment', 'Fertilizer', 'Other') NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Stock INT NOT NULL,
    Description TEXT,
    ImageURL VARCHAR(255),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    BuyerID INT,
    TotalAmount DECIMAL(10,2) NOT NULL,
    PaymentStatus ENUM('Pending', 'Completed', 'Failed') DEFAULT 'Pending',
    OrderStatus ENUM('Processing', 'Shipped', 'Delivered', 'Cancelled') DEFAULT 'Processing',
    OrderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (BuyerID) REFERENCES Users(UserID) ON DELETE CASCADE
);

CREATE TABLE IrrigationLogs (
    LogID INT PRIMARY KEY AUTO_INCREMENT,
    FarmID INT,
    WaterUsage DECIMAL(10,2),
    RecommendedUsage DECIMAL(10,2),
    RecordedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (FarmID) REFERENCES Farms(FarmID) ON DELETE CASCADE
);