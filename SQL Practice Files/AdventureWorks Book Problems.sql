-- SQL Server Book Practice Questions

USE adventureworks;

-- Display the employee names and their department names using subquery

SELECT e.contactID
FROM employee e
WHERE EmployeeID IN (
	SELECT DISTINCT EmployeeID
	FROM employeedepartmenthistory edh
    WHERE departmentID = '3'
);

    

































