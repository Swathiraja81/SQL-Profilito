-- Data Cleaning 
--Break out into Individual Columons 
Select CHARINDEX('@',EmailAddress), EmailAddress,SUBSTRING(EmailAddress,1,CHARINDEX('@',EmailAddress)), SUBSTRING(EmailAddress,CHARINDEX('@',EmailAddress)+1,LEN(EmailAddress))
From [Person].[EmailAddress]

