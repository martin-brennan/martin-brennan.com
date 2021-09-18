---
title: Data Migrations
date: 2018-12-02T20:07:00+10:00
author: Martin Brennan
layout: post
permalink: /data-migrations/
---

Migrations are a tricky thing. You may have been a part of one, perhaps large or small, at some point in your software career. They can range from something small, like adding a new column in Rails to a pre-existing table and populating it with conditional data, to large, like taking a client's existing database that is full of data and migrating it to an entirely new database and table setup, with completely different software.

I am conducting the latter at this point in time, and it made me think about how I've never really seen any articles about data migrations in my time as a software engineer, having gone through a few myself. So, having learned even more about the process this time around, I thought I'd write a post to summarize my thoughts on the matter, and give some advice on how you can complete a successful data migration with a minimum amount of stress.

<!--more-->

## Step 1 - Know Your Data

This is the most important step. It may seem obvious, but you must know exactly what you are working with before you dive into a migration. For the small example I mentioned above you'd need to know a few things; is there any default data you'd like to set for the new column, can any of the rows have a null value for the column, what kind of conditions determine the new value, are there a lot of records that will be affected, if so how can this change be executed efficiently, and so on. For a large system-to-system migration, you will need to know a lot more.

Examining the source data and mapping it to the target data model is the first step here. For example, say you have several CSV files as backups from the source database. The database tables within may be in a completely different structure to your own system's. The CSVs may take several different tables and squish them together into one file. Whatever the case, you will need to go through each of your source files and figure out what goes where. I found that using spreadsheets is the easiest way to do this. Simply make a spreadsheet with the column headings of each of the source database tables and write notes for each column on where the data will end up in the new system. Whiteboarding also helps a lot in this process, you can draw out diagrams and flow charts, and find relationships between data easily here.

Next, once you have a fairly good idea of the data you are working with and where it is going, you are bound to have many questions about it. This is to be expected; especially when coming from a legacy system into a greenfield project with a new database. There may be large data inconsistencies (such as missing data, identifiers that lead nowhere, malformed or badly formatted strings like phone numbers) and you will need to come up with a strategy for dealing with each of these inconsistencies. This is an ideal time to take your questions to your client, as many of them as possible. After all, they are the ones using their current system, and are best placed to know what to do in the situations where there is missing data. Sometimes the malformed data will be a total write off and will need to be dropped, and sometimes it can be migrated at a later time. Asking the client questions is a good way to find out their priorities on what the most important data is here as well.

After you've done all this, and had your questions answered and your strategies outlined, you will also need to know the target data model very well. If you are working on a software team, ensure you have keen knowledge of the database and data models. I've worked on a team previously where the SQL was hidden away from some developers; this will not work for anyone who is carrying out migrations. Knowing how the data is structured is crucial to the success of the migration.

## Step 2 - Developing Your Tools

Now that you've got a handle on your data, you can start developing the tools you need to migrate that data. This may be a long process depending on the complexity of the migration and your experience with working with previous data migrations. You won't know the best way to do things until you do them, and I don't profess to know the best way myself. We are all constantly learning! I'd advise that you use the programming language you are most familiar with for writing migration tools; this is so you don't get distracted with learning a new language along the way, and you should hopefully know the best or most common way to do certain things in the language at any rate.

## Step 3 - Practice Makes Perfect



headings:


- practice makes perfect
-- run migrations as many times as you can (use production backups too)
-- write a run sheet and stick with it. keep it up to date
-- should never be any surprises!
- migration tools
-- sqlite is a godsend especially with csvs; load them into SQLite for easier querying
-- logging is your friend
-- keep canonical sets of old to new id mappings, keep output of previous migrations in dated folders
-- make sure bulk insert statements have begin/commit transactions