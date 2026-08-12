![Uber Mysql](https://github.com/ajayvarmaco/Uber/blob/main/Data/Images/ubertopbanner.png)

# Uber - Operational Insights & Revenue Optimization

## Project Overview
This project focuses on analyzing Uber trip data to extract meaningful insights regarding passengers, trip details, and revenue trends. I performed data exploration, cleaning, transformation, and in-depth analysis to uncover patterns in trip distances, revenue generation, tip behavior, passenger counts, and more. The goal is to identify key areas where Uber can optimize operations, increase revenue, and improve customer satisfaction.

## Problem Statement
Uber faces challenges in optimizing trip efficiency, managing passenger demands, and maximizing revenue. High-demand periods can lead to inefficiencies in trip allocation, delays, and suboptimal service. This project aims to analyze revenue trends, customer behavior, and operational performance to recommend strategies for better resource allocation and improved service during peak times.

## Resources
Here are resources related to the project:

- **Project Documentation**: Detailed documentation outlining the methodology, approach, and results.
- **SQL Queries**: SQL scripts used for data extraction, cleaning, and analysis.
- **Source Data**: Raw data used for analysis, including Uber trip details and payment information.
- **Project Appendix**: Additional project details and supplementary information.
- **Dashboard File**: Power BI dashboard used for data visualization and analysis.
- **Figma**: Documentation and design for project visuals and reports.

## Table of Contents

1. [Data Exploration & Initial Analysis](#data-exploration--initial-analysis)
2. [Data Cleaning](#data-cleaning)
3. [Data Transformation](#data-transformation)
4. [Revenue & Performance Analysis](#revenue--performance-analysis)
5. [Passenger & Trip Insights](#passenger--trip-insights)
6. [Tip Behavior Analysis](#tip-behavior-analysis)
7. [Key Findings & Business Recommendations](#key-findings--business-recommendations)
8. [Power BI Dashboard](#power-bi-dashboard)
9. [SQL Queries Used](#sql-queries-used)
10. [Tech Stack & Tools](#tech-stack--tools)

---

## Data Exploration & Initial Analysis
- Retrieved and analyzed raw Uber trip data for initial inspection.
- Described the table structure and checked for column data types.
- Identified and handled NULL or missing values in critical columns.
- Grouped trips by payment type to understand the distribution of cash vs. card payments.

![Uber Mysql](https://github.com/ajayvarmaco/Uber/blob/main/Data/Images/mysql-vscode.png)

---

## Data Cleaning
- Removed unwanted or irrelevant records, such as trips with incorrect or missing passenger counts.
- Checked for missing values in critical fields like `market_id`, `store_id`, `order_protocol`, etc.
- Handled missing data by cleaning columns that were essential for further analysis.

---

## Data Transformation
- Created new calculated columns such as `revenue_per_passenger`, `revenue_percentage_by_payment_type`, and more.
- Modified column data types to ensure accurate calculations and data integrity.
- Performed calculations like converting total fare to revenue per passenger, average tip percentages, etc.

---

## Revenue & Performance Analysis
- Analyzed daily and hourly revenue trends to uncover peak revenue periods.
- Investigated the relationship between delivery time and revenue, identifying critical time periods where revenue generation is highest.
- Studied revenue by payment type to understand the contribution of cash and card payments to overall revenue.
---

## Passenger & Trip Insights
- Analyzed trip details such as average trip distance, duration, and speed.
- Investigated how passenger counts influence average fare and revenue generation per passenger.
- Evaluated the peak hours for pickups and drop-offs to better understand high-traffic times.

---

## Tip Behavior Analysis
- Studied how tips contribute to overall revenue generation, both in total and percentage terms.
- Investigated tip behavior by payment type and by trip distance to uncover trends.
- Calculated the average tip per trip and how it varies based on payment method and trip distance.

---

![Uber Doc](https://github.com/ajayvarmaco/Uber/blob/main/Data/Images/Uber_doc_snap.png)

**Full Project Documentation**  
Check the uber_project_doc file in the repository for the complete project documentation:

---

## Key Findings & Business Recommendations

- **Promote Digital Payments**: Encourage credit card and app-based payments by offering discounts or loyalty points to improve revenue traceability and boost tipping.

- **Optimize Peak Hours**: Focus driver allocation during peak hours (8 AM, 9 AM, 12 PM) and implement surge pricing to maximize driver earnings and meet demand.

- **Group Ride Incentives**: Offer discounts or bundled pricing for group rides to increase occupancy and drive more revenue per trip.

- **Refine Pricing**: Use revenue-per-minute and revenue-per-mile data to adjust fare structures, particularly in high-congestion areas, to better balance time and distance costs.

- **Target Long-Distance Riders**: Promote longer trips, such as airport or outstation rides, through discounts or subscription models to increase overall revenue and tips.

- **Enhance Short Trip Profitability**: Focus on service in dense city centers to reduce idle time, minimize fuel costs, and increase the frequency of short trips.

---

## Power BI Dashboard
- A Power BI dashboard was created to visualize revenue trends, tip behavior, and passenger counts over time.
- Various KPIs such as revenue per passenger, tip percentages, and average fare per trip were plotted for quick insights.

![Uber Dashboard](https://github.com/ajayvarmaco/Uber/blob/main/Data/Images/uber-dashboard-1.png)

![Uber Dashboard 2](https://github.com/ajayvarmaco/Uber/blob/main/Data/Images/uber-dashboard-2.png)
  
**Example Insights Visualized**:
- Revenue per passenger across different payment types.
- Trip duration vs. revenue.
- Average trip speed, distance, and fare trends.
  
You can view and interact with the dashboard for a better understanding of the data's trends and insights.

---

## SQL Queries Used
The analysis was performed using SQL queries to extract, clean, and analyze the data:

1. **Revenue Analysis**: Queries calculating the total and average revenue per passenger, tip contributions, and revenue by payment type.
2. **Performance Trends**: Queries analyzing revenue trends based on time of day, payment method, and other key factors.
3. **Trip Insights**: Queries investigating average trip distances, durations, and speeds.
4. **Tip Behavior**: Queries calculating average tips, tip percentages, and comparing behavior across payment types and trip lengths.

The SQL queries used can be found in the `Uber_Queries.sql` file within this repository.

---

## Tech Stack & Tools

- **Database**: MySQL
- **Querying & Analysis**: SQL
- **Data Storage**: Google Cloud (for data storage and processing)
- **Visualization**: Power BI
- **Development Environment**: MySQL Workbench, VS Code (with MySQL plugin)
- **Documentation**: Figma (for project documentation and design)

---

## Conclusion
This project aimed to analyze Uber's trip data to uncover insights into revenue trends, operational performance, and passenger behavior. The insights generated provide actionable recommendations for improving Uber's operational efficiency, revenue generation, and customer satisfaction.

---

**Full Project Documentation**  
Check the uber_project_doc file in the repository for the full project documentation:

![Uber Mysql](https://github.com/ajayvarmaco/Uber/blob/main/Data/Images/figma-docs.png)


![Uber Mysql](https://github.com/ajayvarmaco/Uber/blob/main/Data/Images/uberbottombanner2.png)
