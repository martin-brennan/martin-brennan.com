---
title: Find duplicate rows in SQL
date: 2019-04-28T20:09:57+1000
author: Martin Brennan
layout: post
permalink: /find-duplicate-rows-in-sql/
---

Sometimes you need to find and count duplicate data rows in SQL. For example, in my use case I needed to find records in a table where there was more than one usage of the same email address. This would help me figure out how widespread and severe the duplicate issue was; the table in question should not have had duplicate rows based on that column in the first place! (A missing `UNIQUE` index was the culprit).

```sql
SELECT email, COUNT(*)
FROM user_accounts
GROUP BY email
HAVING COUNT(*) > 1;
```

The `HAVING` clause is the important part of this query. To find duplicates, we need to check if any of the groups have a record count > 1. You can put other conditions for the groups in the HAVING clause as well if required, e.g. `COUNT(*) > 1 AND account_status = 1`.

The result of this query can then be used for a sub query/WHERE clause. The result looks like:

```
email              | count
--------------------------------
j.wayne@gmail.com  | 2
g.cooper@gmail.com | 3
```
