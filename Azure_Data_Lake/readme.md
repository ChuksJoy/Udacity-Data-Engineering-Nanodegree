# Project Overview

In this project, we will be building a data lake solution for Divvy bikeshare using Azure Databricks and a lake house architecture.

Divvy is a bike sharing program in Chicago, Illinois USA, which allows riders to use bikes from various stations around the city for a specified time. The anonymized bike trip data provided by the City of Chicago will be our main data source for this project. To supplement this data, we have also created fake rider and account profiles, along with fake payment data.

The dataset includes several tables such as Rider, Account, Payment, Trip, and Station, forming a relational database structure. Our goal is to design a star schema based on specific business outcomes for analysis and insights.

![Diagram](https://video.udacity-data.com/topher/2022/March/6239366d_dend-project-erd/dend-project-erd.jpeg)

## The business outcomes we are targeting are as follows:

### Analyze Ride Duration:
We will investigate the time spent per ride based on various factors, such as:

- Date and time factors like the day of the week and time of day.
- Starting and ending station for each ride.
- Age of the rider at the time of the ride.
- Membership type, whether the rider is a member or a casual rider.

### Analyze Expenditure:
We'll examine the amount of money spent on rides:

- Per month, quarter, and year.
- Per member, considering the age of the rider at the start of their account.

## To achieve this, we'll proceed with the following steps:

### Design a Star Schema:
We'll design a star schema that organizes the data into fact and dimension tables, allowing efficient and flexible querying for our business outcomes.

### Import Data to Azure Databricks:
We'll import the data from both the Divvy bikeshare dataset and our generated fake data into Azure Databricks, using Delta Lake to create a Bronze data store.

### Create a Gold Data Store:
We'll use Delta Lake tables to create a Gold data store, where we'll transform the data into the desired star schema, making it easier to analyze and gain insights.

By implementing these steps, we aim to provide a robust data lake solution for Divvy bikeshare data analysis, empowering us to make informed decisions based on the ride duration and expenditure patterns.
