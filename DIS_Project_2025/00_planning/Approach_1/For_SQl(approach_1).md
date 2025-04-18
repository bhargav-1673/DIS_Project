- **Users (UserID, Name, Email, PasswordHash, Role, Phone, Address, CreatedAt)**
  - Stores information about farmers and admins.

- **Farms (FarmID, UserID, FarmName, Location, SoilType, Size)**
  - Contains details of farms managed by users.

- **Fields (FieldID, FarmID, CropID, Size, IrrigationSystem, SoilQuality)**
  - Represents individual farm fields that are assigned specific crops.

- **Crops (CropID, Name, Season, WaterRequirement, GrowthStage, YieldPrediction, PlantationDate, HarvestDate)**
  - Stores crop details and their respective attributes.

- **WeatherData (WeatherID, FarmID, Temperature, Humidity, Rainfall, SoilMoisture, RecordedAt)**
  - Logs real-time weather data for specific farms.

- **PestAlerts (AlertID, FarmID, FieldID, AlertType, Severity, SuggestedAction, AlertDate)**
  - Stores pest alert notifications and suggested actions.

- **IrrigationLogs (LogID, FieldID, WaterUsage, RecommendedUsage, RecordedAt)**
  - Tracks irrigation activities for individual fields.

- **Workers (WorkerID, Name, PhoneNumber, JoinedDate)**
  - Stores worker details, who manage different farm fields.

- **Worker_Field (WorkerID, FieldID)**
  - Establishes a many-to-many relationship between workers and fields.

- **Equipment (EquipmentID, FarmID, Name, Type, LastMaintenanceDate, NextMaintenanceDue)**
  - Tracks farm equipment and their maintenance schedules.

- **Reports (ReportID, FarmID, ReportType, GeneratedAt, Data)**
  - Stores generated reports for yield predictions and resource usage.

### Relationships:
- **One-to-Many:** A User can manage multiple Farms.
- **One-to-Many:** A Farm can contain multiple Fields.
- **One-to-Many:** A Field can be assigned one Crop, but a Crop can be grown in multiple Fields.
- **One-to-Many:** A Farm can have multiple WeatherData records over time.
- **One-to-Many:** A Farm can have multiple PestAlerts.
- **One-to-Many:** A Field can have multiple IrrigationLogs.
- **Many-to-Many:** Workers can manage multiple Fields, and a Field can be managed by multiple Workers.
- **One-to-Many:** A Farm can own multiple Equipment items.
- **One-to-Many:** A Farm can generate multiple Reports over time.


<hr>

 ```sql
-- Users Table
-- Stores information about farmers and admins
CREATE TABLE Users (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    Role ENUM('Farmer', 'Admin') NOT NULL,
    Phone VARCHAR(15),
    Address TEXT,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Farms Table
-- Contains details of farms managed by users
CREATE TABLE Farms (
    FarmID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    FarmName VARCHAR(255) NOT NULL,
    Location TEXT,
    SoilType VARCHAR(100),
    Size DECIMAL(10,2),
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);

-- Fields Table
-- Represents individual farm fields that are assigned specific crops
CREATE TABLE Fields (
    FieldID INT PRIMARY KEY AUTO_INCREMENT,
    FarmID INT,
    CropID INT,
    Size DECIMAL(10,2),
    IrrigationSystem VARCHAR(100),
    SoilQuality VARCHAR(100),
    FOREIGN KEY (FarmID) REFERENCES Farms(FarmID) ON DELETE CASCADE
);

-- Crops Table
-- Stores crop details and their respective attributes
CREATE TABLE Crops (
    CropID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    Season VARCHAR(100),
    WaterRequirement VARCHAR(50),
    GrowthStage VARCHAR(100),
    YieldPrediction DECIMAL(10,2),
    PlantationDate DATE,
    HarvestDate DATE
);

-- WeatherData Table
-- Logs real-time weather data for specific farms
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

-- PestAlerts Table
-- Stores pest alert notifications and suggested actions
CREATE TABLE PestAlerts (
    AlertID INT PRIMARY KEY AUTO_INCREMENT,
    FarmID INT,
    FieldID INT,
    AlertType VARCHAR(100),
    Severity VARCHAR(50),
    SuggestedAction TEXT,
    AlertDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (FarmID) REFERENCES Farms(FarmID) ON DELETE CASCADE,
    FOREIGN KEY (FieldID) REFERENCES Fields(FieldID) ON DELETE CASCADE
);

-- IrrigationLogs Table
-- Tracks irrigation activities for individual fields
CREATE TABLE IrrigationLogs (
    LogID INT PRIMARY KEY AUTO_INCREMENT,
    FieldID INT,
    WaterUsage DECIMAL(10,2),
    RecommendedUsage DECIMAL(10,2),
    RecordedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (FieldID) REFERENCES Fields(FieldID) ON DELETE CASCADE
);

-- Workers Table
-- Stores worker details, who manage different farm fields
CREATE TABLE Workers (
    WorkerID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    PhoneNumber VARCHAR(15) UNIQUE NOT NULL,
    JoinedDate DATE
);

-- Worker_Field Table
-- Establishes a many-to-many relationship between workers and fields
CREATE TABLE Worker_Field (
    WorkerID INT,
    FieldID INT,
    PRIMARY KEY (WorkerID, FieldID),
    FOREIGN KEY (WorkerID) REFERENCES Workers(WorkerID) ON DELETE CASCADE,
    FOREIGN KEY (FieldID) REFERENCES Fields(FieldID) ON DELETE CASCADE
);

-- Equipment Table
-- Tracks farm equipment and their maintenance schedules
CREATE TABLE Equipment (
    EquipmentID INT PRIMARY KEY AUTO_INCREMENT,
    FarmID INT,
    Name VARCHAR(255) NOT NULL,
    Type VARCHAR(100),
    LastMaintenanceDate DATE,
    NextMaintenanceDue DATE,
    FOREIGN KEY (FarmID) REFERENCES Farms(FarmID) ON DELETE CASCADE
);

-- Reports Table
-- Stores generated reports for yield predictions and resource usage
CREATE TABLE Reports (
    ReportID INT PRIMARY KEY AUTO_INCREMENT,
    FarmID INT,
    ReportType VARCHAR(255) NOT NULL,
    GeneratedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Data TEXT,
    FOREIGN KEY (FarmID) REFERENCES Farms(FarmID) ON DELETE CASCADE
);
