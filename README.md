# TSQL-Handy-Functions
This is a repository with a list of a very useful functions in Transact SQL to use in querys.

Here you can find some SQL Functions that do not exist natively in SQL Server and which I usually use in SQL Server.

# dbo.CleanString
Used to clean up special characters that are "hidden" in a string such as commands like the ENQ (Inquiry) character or some spetial chars like %@€. 

# dbo.Split
It divides a string with a list of text "records", separated by a separator into a resultset with as many rows as the separate records.

# dbo.UDTToLocalTime
This one is from Bobman I found it on StackOverflow (http://stackoverflow.com/questions/3404646/how-to-calculate-the-local-datetime-from-a-utc-datetime-in-tsql-sql-2005/8842966#8842966) and it dynamically converts a UTC DateTime to a Daylight Saving DateTime. I'm using this same function at least in 2 diferent reports that compare some UTC DateTime in Portugal (GMT).
