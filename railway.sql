-- Create Trains Table
CREATE TABLE Trains (
    TrainID INT AUTO_INCREMENT PRIMARY KEY,
    TrainName VARCHAR(100) NOT NULL,
    TrainType VARCHAR(50) NOT NULL,
    TotalSeats INT NOT NULL
);

-- Create Stations Table
CREATE TABLE Stations (
    StationID INT AUTO_INCREMENT PRIMARY KEY,
    StationName VARCHAR(100) NOT NULL,
    Location VARCHAR(100) NOT NULL
);

-- Create Customers Table
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Phone VARCHAR(15),
    Email VARCHAR(100) UNIQUE
);

-- Create Bookings Table
CREATE TABLE Bookings (
    BookingID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    TrainID INT NOT NULL,
    DepartureStationID INT NOT NULL,
    ArrivalStationID INT NOT NULL,
    DepartureTime DATETIME NOT NULL,
    ArrivalTime DATETIME NOT NULL,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (TrainID) REFERENCES Trains(TrainID),
    FOREIGN KEY (DepartureStationID) REFERENCES Stations(StationID),
    FOREIGN KEY (ArrivalStationID) REFERENCES Stations(StationID)
);

-- Create TicketDetails Table
CREATE TABLE TicketDetails (
    TicketID INT AUTO_INCREMENT PRIMARY KEY,
    BookingID INT NOT NULL,
    SeatNumber VARCHAR(10) NOT NULL,
    Class VARCHAR(20) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID)
);

-- Sample Data Insert (optional)

-- Insert some sample trains
INSERT INTO Trains (TrainName, TrainType, TotalSeats)
VALUES
('Express 101', 'Express', 500),
('Local 202', 'Local', 200);

-- Insert some sample stations
INSERT INTO Stations (StationName, Location)
VALUES
('Central Station', 'City A'),
('North Station', 'City B'),
('South Station', 'City C');

-- Insert some sample customers
INSERT INTO Customers (FirstName, LastName, Phone, Email)
VALUES
('John', 'Doe', '123-456-7890', 'john.doe@example.com'),
('Jane', 'Smith', '987-654-3210', 'jane.smith@example.com');

-- Insert a sample booking
INSERT INTO Bookings (CustomerID, TrainID, DepartureStationID, ArrivalStationID, DepartureTime, ArrivalTime, TotalAmount)
VALUES
(1, 1, 1, 2, '2025-02-10 08:00:00', '2025-02-10 10:30:00', 50.00);

-- Insert sample ticket details
INSERT INTO TicketDetails (BookingID, SeatNumber, Class, Price)
VALUES
(1, 'A1', 'First Class', 50.00);

