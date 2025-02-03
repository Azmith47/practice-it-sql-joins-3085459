-- SQLite
SELECT 
  e1.EmployeeKey EmployeeKey,
  e1.FirstName Employee_First_Name,
  e1.LastName Employee_Last_Name,
  e2.FirstName Manager_First_Name,
  e2.LastName Manager_Last_Name
FROM DimEmployee e1
JOIN DimEmployee e2
ON e1.EmployeeKey = e2.ParentEmployeeKey;