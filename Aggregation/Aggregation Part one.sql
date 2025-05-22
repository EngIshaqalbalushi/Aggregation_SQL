

--Aggregation Functions

--Company Database

--Count total number of employees in the Employees table.

select Count(*) as NumberOFEmployee from EMPLOYEE


--Calculate average salary from the Salaries table.

select avg(Salary) as AverageSalary from EMPLOYEE


 --Count employees in each department using Employees grouped by Dept_ID.
 SELECT d.Dnumber AS Dept_ID, COUNT(e.Ssn) AS EmployeeCount
FROM DEPARTMENT d
LEFT JOIN EMPLOYEE e ON d.Mgr_ssn = e.Ssn
GROUP BY d.Dnumber;

 --Find total salary per department by joining Employees and Salaries.
 SELECT d.Dnumber AS Dept_ID, SUM(e.Salary) AS TotalSalary
FROM DEPARTMENT d
LEFT JOIN EMPLOYEE e ON d.Mgr_ssn = e.Ssn
GROUP BY d.Dnumber;


--Show departments (Dept_ID) having more than 5 employees with their counts.
SELECT d.Dnumber AS Dept_ID, COUNT(e.Ssn) AS EmployeeCount
FROM DEPARTMENT d
LEFT JOIN EMPLOYEE e ON d.Mgr_ssn = e.Ssn
GROUP BY d.Dnumber
HAVING COUNT(e.Ssn) > 5;


--University Database 
--Count total number of students in the student Table

SELECT COUNT(*) AS TotalStudents
FROM STUDENT;

--Count number of students per city (group by City in Student).
SELECT h.City, COUNT(l.S_id) AS StudentCount
FROM HOSTEL h
LEFT JOIN Live l ON h.Hostel_id = l.Hostel_id
GROUP BY h.City;
--Count students per course using Enrols (group by CourseID).
SELECT c.Course_name, COUNT(e.S_id) AS StudentCount
FROM COURSE c
LEFT JOIN Enroll e ON c.Course_id = e.Course_id
GROUP BY c.Course_name;

--Count number of courses per department using Course (group by DepartmentID).
SELECT d.D_name AS DepartmentName, COUNT(h.Course_id) AS CourseCount
FROM DEPARTMENT d
LEFT JOIN Handled h ON d.Department_id = h.Department_id
GROUP BY d.D_name;

-- Count number of students assigned to each hostel (group by HostelID).

SELECT h.Hostel_name, COUNT(l.S_id) AS StudentCount
FROM HOSTEL h
LEFT JOIN Live l ON h.Hostel_id = l.Hostel_id
GROUP BY h.Hostel_name;

--count total flight in flight
SELECT COUNT(*) AS TotalFlights
FROM Flight;

--Average available seats per leg using FLIGHT_LEG table.
SELECT AVG(amount) AS AverageFare
FROM Fare;


--Count flights scheduled per airline from FLIGHT grouped by Airline_ID.

SELECT weekdays, COUNT(*) AS FlightCount
FROM Flight
GROUP BY weekdays;

-- Total payments per leg using LEG_INSTANCE table grouped by Flight_Leg_ID.


-- List flight legs with total payments > 10000 grouped by Flight_Leg_ID
SELECT 
    li.leg_no AS Flight_Leg_ID,
    SUM(f.amount) AS Total_Payments
FROM 
    LegInstance li
JOIN 
    SeatReservation sr ON li.given_date = sr.given_date
JOIN 
    AirplaneReservation ar ON sr.reservation_id = ar.reservation_id
GROUP BY 
    li.leg_no;


--	Hotel Database
-- Count total rooms across all hotels from Rooms table.
SELECT COUNT(*) AS TotalRooms
FROM Room;

--Average room price per night from Rooms table.
SELECT AVG(CAST(nithlyrate AS DECIMAL(10,2))) AS AvgNightlyRate
FROM Room;

-- Count rooms per hotel grouped by Hotel_ID.
SELECT branch_id, COUNT(*) AS RoomCount
FROM Room
GROUP BY branch_id
ORDER BY branch_id;

--Sum booking cost per guest from Bookings grouped by Guest_ID.
SELECT 
    c.C_ID AS Guest_ID,
    c.name AS GuestName,
    SUM(DATEDIFF(DAY, b.Checkin, b.CheckOut) * CAST(r.nithlyrate AS DECIMAL(10,2))) AS TotalBookingCost
FROM custmer c
JOIN Book b ON c.B_ID = b.B_ID
JOIN Room r ON
GROUP BY c.C_ID, c.name;

--Guests with total bookings > 5000 grouped by Guest_ID
SELECT 
    c.C_ID AS Guest_ID,
    c.name AS GuestName,
    SUM(DATEDIFF(DAY, b.Checkin, b.CheckOut) * CAST(r.nithlyrate AS DECIMAL(10,2))) AS TotalBookingCost
FROM custmer c
JOIN Book b ON c.B_ID = b.B_ID
JOIN Room r ON /* Missing room-booking relationship */
GROUP BY c.C_ID, c.name
HAVING SUM(DATEDIFF(DAY, b.Checkin, b.CheckOut) * CAST(r.nithlyrate AS DECIMAL(10,2))) > 5000;


--Bank Database
--- Count total number of customers in Customers table.
SELECT COUNT(*) AS total_customers
FROM Customers;

--Average account balance from Accounts table.
SELECT AVG(balance) AS average_balance
FROM account;

-- Count accounts per branch grouped by Branch_ID.


-- Sum loan amounts per customer from Loans grouped by Customer_ID.
-- This won't work with your current schema - just an example
SELECT b.branch_id, COUNT(a.account_number) AS account_count
FROM branch b
LEFT JOIN customers c ON b.branch_id = c.branch_id
LEFT JOIN account a ON c.customer_id = a.customer_id
GROUP BY b.branch_id;

--List customers with total loan > 200000 grouped by Customer_ID.
SELECT customer_id, SUM(amount) AS total_loan_amount
FROM loans
GROUP BY customer_id
HAVING SUM(amount) > 200000;