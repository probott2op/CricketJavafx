-- Create Products Table
CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    StockQuantity INT NOT NULL
);

-- Create Customers Table
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Phone VARCHAR(15),
    Email VARCHAR(100) UNIQUE
);

-- Create Sales Table
CREATE TABLE Sales (
    SaleID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    SaleDate DATETIME NOT NULL,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Create SalesDetails Table
CREATE TABLE SalesDetails (
    SaleDetailID INT AUTO_INCREMENT PRIMARY KEY,
    SaleID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    TotalPrice DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (SaleID) REFERENCES Sales(SaleID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Create Inventory Table
CREATE TABLE Inventory (
    InventoryID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT NOT NULL,
    StockQuantity INT NOT NULL,
    LastUpdated DATETIME NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Sample Data Insert (optional, for testing)

-- Insert some sample products
INSERT INTO Products (ProductName, Category, Price, StockQuantity)
VALUES
('Milk', 'Dairy', 2.50, 100),
('Bread', 'Bakery', 1.20, 50),
('Apple', 'Fruit', 0.80, 200);

-- Insert some sample customers
INSERT INTO Customers (FirstName, LastName, Phone, Email)
VALUES
('John', 'Doe', '123-456-7890', 'john.doe@example.com'),
('Jane', 'Smith', '987-654-3210', 'jane.smith@example.com');

-- Insert a sample sale
INSERT INTO Sales (CustomerID, SaleDate, TotalAmount)
VALUES
(1, '2025-02-03 10:00:00', 10.50);

-- Insert sale details
INSERT INTO SalesDetails (SaleID, ProductID, Quantity, UnitPrice, TotalPrice)
VALUES
(1, 1, 2, 2.50, 5.00),   -- 2 Milk
(1, 2, 1, 1.20, 1.20);   -- 1 Bread

-- Insert into Inventory (to track stock levels)
INSERT INTO Inventory (ProductID, StockQuantity, LastUpdated)
VALUES
(1, 100, '2025-02-03 10:00:00'),  -- Milk
(2, 50, '2025-02-03 10:00:00'),   -- Bread
(3, 200, '2025-02-03 10:00:00');  -- Apple
