---what is the tax percentage?
Select SalesOrderID,CustomerID,OrderDate,SubTotal,
(TaxAmt/SubTotal)*100 as TaxPercent
From [Sales].[SalesOrderHeader]
Order By SubTotal desc
--What is the Unique Job Title and Count of Jobtitle ?
Select Distinct JobTitle,Count(JobTitle)
From humanresources.employee
Group By JobTitle
--Find the Average and Sum of The Subtotal?
Select avg(subtotal) as AvgSubtotal,Sum(SubTotal) as SumSubtotal
From sales.salesorderheader
---Find the total Quantity of Each productid Which are in self of 'A' or 'C' or 'H' Filter the Results For sum Quantity is More Than 500?
Select ProductID,Sum(Quantity) as TotalAQuantity
From [Production].[ProductInventory]
Where Shelf in ('A','c','H')
Group By ProductID
Having Sum(Quantity) >500
Order By ProductID Asc
--inner JOin
Select P.BusinessEntityID,FirstName,LastName,PhoneNumber
From [Person].[Person] P
join [Person].[PersonPhone] PH
On P.BusinessEntityID=PH.BusinessEntityID
Where LastName LIke 'L%'
order by LastName,FirstName
--Select SalesPersonID,CustomerID,Sum(SubTotal) As Sum_Subtotal
From sales.salesorderheader S
Group by RoLLup(SalesPersonID,CustomerID)
-order by SalesPersonID,CustomerID
--find No of Employees in Each City ?
Select City,Count(b.AddressID) as noofemployees
From Person.BusinessEntityAddress AS b   
    INNER JOIN Person.Address AS a  
	on  b.AddressID = a.AddressID  
Group by a.City
order by a.City
--Find Total Due amount For Each Year ?
Select DATEPART("year",OrderDate) as "YEAR",SUM(Totaldue) as Orderamount
From Sales.SalesOrderHeader
GROUP BY  DATEPART("year",OrderDate)
ORDER By  DATEPART("year",OrderDate)
--Find The Contacts Who are Desiginated as a Maneger in various Department?
SELECT ContactTypeID,Name
FROM Person.ContactType
WHERE Name Like '%Manager%'
Order By ContactTypeID Desc
--who are designated as 'Purchasing Manager'. Return BusinessEntityID, LastName, and FirstName columns. Sort the result set in ascending order of LastName, and FirstName.?
SELECT pp.BusinessEntityID, LastName, FirstName
    FROM Person.BusinessEntityContact AS pb 
        INNER JOIN Person.ContactType AS pc
            ON pc.ContactTypeID = pb.ContactTypeID
        INNER JOIN Person.Person AS pp
            ON pp.BusinessEntityID = pb.PersonID
    WHERE pc.Name = 'Purchasing Manager'
    ORDER BY LastName, FirstName;
 -- From the following table write a query in SQL to find those persons who lives in a territory and the value of salesytd except 0. Return first name, last name,row number as 'Row Number', 'Rank', 'Dense Rank' and NTILE as 'Quartile', salesytd and postalcode. Order the output on postalcode column.
Select P.FirstName,P.LastName,
Row_Number() over (Order by A.PostalCode) As "Row Number"
,Rank() over (order by A.postalcode) as "Rank" 
,DENSE_RANK() over (Order by A.postalcode) as "Dense Rank"
,NTILE(4)over (order by A.postalcode) As Quartile
,Lead(A.postalcode,2,1) over (Order by A.postalcode) As Lead
,A.PostalCode,S.SalesYTD
FROM Sales.SalesPerson S
inner join Person.Person P  
on S.BusinessEntityID = p.BusinessEntityID
inner join Person.Address A
on P.BusinessEntityID=  A.AddressID
where SalesYTD is not Null and TerritoryID <> 0

