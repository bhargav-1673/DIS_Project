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
