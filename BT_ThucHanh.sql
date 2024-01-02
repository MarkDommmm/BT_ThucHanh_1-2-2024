use NORTHWND
-- Hãy cho biết  những khách hàng nào  đã đặt nhiều hơn 20 đơn hàng và sắp xếp theo thứ tự tổng số đơn hàng lớn hơn 20
 SELECT  CustomerID, COUNT([OrderID]) as TotalOrders
 FROM Orders
 GROUP BY  CustomerID
 HAVING count(OrderID) > 20
 ORDER BY TotalOrders DESC

-- Hãy  lọc  ra các nhân viên(EmployeeID)  có tổng số đơn hàng lớn hơn hoặc  bằng 100, sắp xếp  theo tổng số đơn hàng giảm dần
 SELECT o.EmployeeID, e.lastname+ ' ' +e.Firstname as FullName,  COUNT(OrderID) as TotalOrders
 FROM Orders o
 JOIN Employees e on e.EmployeeID = o.EmployeeID
 GROUP BY  o.EmployeeID, e.lastname+ ' ' +e.Firstname
 HAVING count(OrderID) > 100
  ORDER BY TotalOrders DESC

-- Hãy cho biết những thể loại nào (categoryID) có số sản phẩm  khác nhau lớn hơn 11
 SELECT categoryID, COUNT(categoryID) as TotalProducts
 FROM   Products
 GROUP BY categoryID
 HAVING  COUNT(categoryID) > 11

 -- Hãy cho biết những thể loại nào (CategoryID) có số tổng số lượng sản phẩm  trong kho (UnitslnStock) lớn hơn 350
 SELECT CategoryID, SUM(UnitsInStock) as Total_UnitsInStock
 FROM Products
 GROUP BY CategoryID
 HAVING SUM(UnitsInStock) > 350

 -- Hãy cho biết những quốc gia nào có nhiều hơn 7 khách hàng và sắp xếp giảm dần
 SELECT ShipCountry, COUNT(CustomerID) as TotalCustomers
 FROM Orders
 GROUP BY	ShipCountry
 HAVING COUNT(CustomerID) > 7
 ORDER BY TotalCustomers DESC

 -- Hãy cho biết những ngày nào có nhiều hơn  5 đơn hàng được giao , sắp xếp tăng dần theo ngày giao hàng
 SELECT o.ShippedDate as Day, count(DAY(ShippedDate)) as TotalOrders
 FROM Orders o
 GROUP BY o.ShippedDate 
 HAVING count(DAY(ShippedDate)) > 5
 ORDER BY ShippedDate 

 -- Hãy cho biết những quốc gia bắt đầu bằng chữ 'A' hoặc 'G' và có số lượng đơn hàng lớn hơn 29
 SELECT ShipCountry, COUNT(ORDERID) as TotalOrder
 FROM Orders
 WHERE ShipCountry like 'A%' OR ShipCountry like 'G%'
 GROUP BY ShipCountry
 HAVING  COUNT(ORDERID) > 29

 -- Hãy cho biết những thành phố nào có số lượng đơn hàng được giao là khác 1 và 2,  ngày đặt hàng từ ngày 1997-04-01 đến 1997-08-31
 SELECT ShipCountry, COUNT(OrderID) as Total
 FROM Orders
 WHERE ShippedDate BETWEEN '1997-04-01' AND '1997-08-31'
 GROUP BY ShipCountry
 HAVING COUNT(OrderID) > 2

 --Từ bảng Products và Categories, 
-- hãy tìm các sản phẩm thuộc danh mục ‘Seafood’ 
-- (Đồ hải sản) in ra các thông tin sau đây:
--Mã thể loại
--Tên thể loại
--Mã sản phẩm
--Tên sản phẩm
SELECT p.ProductID, p.ProductName ,c.CategoryID, c.CategoryName
FROM Products p 
JOIN Categories c ON c.CategoryID = p.CategoryID
WHERE c.CategoryName = 'SeaFood'



--Từ bảng Products và Suppliers, 
-- hãy tìm các sản phẩm thuộc được cung cấp từ nước ‘Germany’ (Đức) :
--Mã nhà cung cấp
--Quốc gia
--Mã sản phẩm
--Tên sản phẩm
SELECT  s.SupplierID, s.Country, p.ProductID, p.ProductName
FROM Suppliers s
JOIN Products p ON p.SupplierID = s.SupplierID 
WHERE s.Country = 'Germany'

 

--Từ 3 bảng Orders, Customers, Shippers hãy in ra các thông tin sau đây:
--Mã đơn hàng
--Tên khách hàng
--Tên công ty vận chuyển
--Ngày yêu cầu chuyển hàng
--Ngày giao hàng
--Chỉ in ra các đơn hàng của các khách hàng đến từ thành phố ‘London’
--Và chỉ in ra các đơn hàng bị giao muộn hơn quy định. RequiredDate < ShippedDate
SELECT o.OrderID, c.ContactName, s.CompanyName, o.RequiredDate, o.ShippedDate
FROM Orders o
JOIN Customers c ON c.CustomerID = o.CustomerID
JOIN Shippers s ON s.ShipperID = o.ShipVia
WHERE c.City = 'London' AND o.RequiredDate  < o.ShippedDate

-- Liệt kê các đơn hàng có ngày đặt gần nhất
SELECT *
FROM Orders
WHERE OrderDate = (
SELECT MAX( o.OrderDate)
FROM Orders o
)

-- Liệt kê tất cả các sản phẩm (ProductName) mà không có đơn đặt hàng nào đặt mua chúng.
SELECT *
FROM Products 
Where ProductID NOT IN (
SELECT ProductID 
FROM [Order Details]
)

-- Lấy thông tin về các đơn hàng, và tên các sản phẩm  thuộc các đơn hàng chưa được giao cho khách.
SELECT o.OrderID , p.ProductName
FROM Orders o
JOIN [Order Details] od on od.OrderID = o.OrderID
JOIN Products p ON p.ProductID = od.ProductID
where o.OrderID IN (
SELECT OrderID
FROM Orders
WHERE ShippedDate IS NULL
)


SELECT ProductID, ProductName, CategoryID, RANK() OVER (ORDER BY UnitPrice DESC) as RANKING
FROM Products

SELECT ProductID, ProductName, CategoryID,
       (SELECT COUNT(DISTINCT UnitPrice) 
        FROM Products p2 
        WHERE p2.UnitPrice >= p1.UnitPrice) as RANKING
FROM Products p1
ORDER BY UnitPrice DESC;

