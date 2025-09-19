---
title: Fast SQL Server Paging
date: 2016-06-25T14:30:00+10:00
author: Martin Brennan
layout: post
permalink: /fast-sql-server-paging/
---


{% include deprecated.html message="In 2025 MSSQL Server paging with `OFFSET… FETCH` still works, but for large datasets this approach slows down on deep pages. Modern best practice is to use keyset/seek pagination instead, and only fetch total row counts when needed." cssclass="deprecated" %}

Just a quick tip if you ever need to implement paging in [MSSQL](https://www.microsoft.com/en-au/server-cloud/products/sql-server/). Here is a simple example of the query, which gets page _x_ of size _y_ and gets the total row count as well.

```sql
SELECT ID, Name, [RowCount] = COUNT(*) OVER()
FROM MyTable
WHERE Name LIKE '%Example%'
ORDER BY ID
OFFSET @Page ROWS
FETCH NEXT @PageSize ROWS ONLY
```

This must be used with an `ORDER BY` clause. The `@Page` and `@PageSize` determine which set of records are returned out of the total result set.
