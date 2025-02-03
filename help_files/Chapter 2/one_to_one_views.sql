-- SQLite
DROP VIEW IF EXISTS 'vwCUSTOMER_ADDRESS';
DROP VIEW IF EXISTS 'vwCUSTOMER_BIRTHDATE';
CREATE VIEW vwCUSTOMER_ADDRESS
AS SELECT
  CustomerKey,
  AddressLine1,
  AddressLine2,
  GeographyKey
FROM
  DimCustomer;

CREATE VIEW vwCUSTOMER_BIRTHDATE
AS SELECT
  CustomerKey,
  Title,
  FirstName,
  MiddleName,
  LastName,
  NameStyle,
  BirthDate
FROM
  DimCustomer;
  
SELECT 
  ca.*,
  cb.*
FROM
  vwCUSTOMER_ADDRESS ca
JOIN vwCUSTOMER_BIRTHDATE cb
ON ca.CustomerKey = cb.CustomerKey
ORDER BY cb.BirthDate;