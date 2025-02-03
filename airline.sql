-- Create Airlines Table
CREATE TABLE Airlines (
    AirlineID INT AUTO_INCREMENT PRIMARY KEY,
    AirlineName VARCHAR(100) NOT NULL,
    Country VARCHAR(50) NOT NULL
);

-- Create Flights Table
CREATE TABLE Flights (
    FlightID INT AUTO_INCREMENT PRIMARY KEY,
    AirlineID INT NOT NULL,
    FlightNumber VARCHAR(50) NOT NULL UNIQUE,
    DepartureAirport VARCHAR(100) NOT NULL,
    ArrivalAirport VARCHAR(100) NOT NULL,
    DepartureTime DATETIME NOT NULL,
    ArrivalTime DATETIME NOT NULL,
    AvailableSeats INT NOT NULL,
    FOREIGN KEY (AirlineID) REFERENCES Airlines(AirlineID)
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
    FlightID INT NOT NULL,
    BookingDate DATETIME NOT NULL,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (FlightID) REFERENCES Flights(FlightID)
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

-- Insert some sample airlines
INSERT INTO Airlines (AirlineName, Country)
VALUES
('American Airlines', 'USA'),
('British Airways', 'UK'),
('Air India', 'India');

-- Insert some sample flights
INSERT INTO Flights (AirlineID, FlightNumber, DepartureAirport, ArrivalAirport, DepartureTime, ArrivalTime, AvailableSeats)
VALUES
(1, 'AA123', 'JFK', 'LHR', '2025-05-01 14:00:00', '2025-05-01 22:00:00', 150),
(2, 'BA456', 'LHR', 'JFK', '2025-05-02 10:00:00', '2025-05-02 12:00:00', 180),
(3, 'AI789', 'DEL', 'LHR', '2025-06-01 01:00:00', '2025-06-01 06:00:00', 200);

-- Insert some sample customers
INSERT INTO Customers (FirstName, LastName, Phone, Email)
VALUES
('John', 'Doe', '123-456-7890', 'john.doe@example.com'),
('Jane', 'Smith', '987-654-3210', 'jane.smith@example.com');

-- Insert a sample booking
INSERT INTO Bookings (CustomerID, FlightID, BookingDate, TotalAmount)
VALUES
(1, 1, '2025-02-01 09:00:00', 500.00);

-- Insert sample ticket details
INSERT INTO TicketDetails (BookingID, SeatNumber, Class, Price)
VALUES
(1, '12A', 'Economy', 500.00);

