# ViralByte-Marketing-Campaign-Analysis

## Project Overview 
ViralByte has been running multiple marketing campaigns across various channels (Facebook, Instagram, Pinterest) to promote our products. We have collected detailed data on daily ad performance, including metrics like impressions, clicks, spend, conversions, and engagement (likes, shares, comments). This project aims to analyze this data to gain insights into the effectiveness of our campaigns, optimize our ad spend, and improve future marketing strategies.

## Problem Statement
ViralByte aims to optimize its marketing campaigns by analyzing past performance data. However, without a clear understanding of the factors contributing to campaign success, the company risks inefficient budget allocation and missed opportunities for growth. This project seeks to evaluate campaign data to identify key performance drivers, maximize the effectiveness of ViralByte’s advertising budget, and refine future marketing strategies for improved engagement and ROI.
## Aims And Objectives
## Aim
This project aims to analyze this data to gain insights into the effectiveness of our campaigns, optimize our ad spend, and improve future marketing strategies.
## Objectives
- Assess the overall performance of each campaign in terms of reach, engagement, and conversions.
- Determine which advertising channels are driving the best results.
- TO identify the cities that show the highest engagement and conversion rates.
- Understand how ads perform across different devices.
- To analyze the performance of individual ads to identify high-performing creatives.
- To calculate the return on investment (ROI) for each campaign.
- Track the performance trends over time to identify patterns and seasonal effects.

## Exploratory Data Analysis
To tackle this project, I used SQL to write and execute SQL queries.
I analysed Key Marketing Metrics like ad performance, channel effectiveness, campaign performance, and ROI generated to provide insights on how to optimize ad spend and improve marketing strategies. 
My approach involved breaking down business questions into structured queries. I used aggregate functions to perform calculations, date functions to extract month and month name from the date, cast function to round up decimal value. I filtered and sorted the data where necessary using HAVING and ORDER BY functions to generate meaningful insights.

## Data Cleaning
I checked the dataset for duplicates, inconsistencies, missing values, and also the format of the data. I changed the datatype of the columns with incorrect data format using ALTER function. I rounded some numerical columns to 2 decimal places using ROUND functions.

## Key Business Questions
_1. Campaign Performance:_

   - Which campaign generated the highest number of impressions, clicks, and conversions?    
```
sql
SELECT Campaign, 
SUM(Impressions) as Impressions,
SUM(Clicks) as Clicks,
SUM(Conversions) as Conversions
FROM Marketing_Data
GROUP BY Campaign
ORDER BY Impressions DESC;
```


- What is the average cost-per-click (CPC)  and click-through rate (CTR) for each campaign?
 ``` 
sql
  SELECT Campaign,
AVG(Daily_Average_CPC) as AVG_CPC
FROM Marketing_Data
GROUP BY Campaign
```
2. Channel Effectiveness:
- Which channel has the highest ROI?-
```
sql
SELECT TOP 1 Channel, (SUM(Total_conversion_value_GBP) - SUM(Spend_GBP)) / SUM(Spend_GBP) as ROI
FROM Marketing_Data
GROUP BY Channel
ORDER BY ROI DESC
```

- How do impressions, clicks, and conversions vary across different  channels?
```
SQL
SELECT Channel, SUM(Impressions) as Impressions, SUM(Clicks) as Clicks, SUM(Conversions) as Conversions
FROM Marketing_Data
GROUP BY Channel
```

3. Geographical Insights:
- Which cities have the highest engagement rates (likes, shares, comments)?
```
SQL
SELECT City_Location,SUM(Likes_Reactions) AS Likes,SUM(Shares) AS Shares,SUM(Comments) AS Comments, 
(SUM(Likes_Reactions) + SUM(Shares) + SUM(Comments)) AS Engagement
FROM [Marketing_Data ]
GROUP BY City_Location 
ORDER BY Likes DESC
```
 What is the conversion rate by city?
```
 SQL
SELECT City_Location, CAST(SUM(Conversions) AS decimal(10,3)) /SUM(CLICKS) * 100 AS Conversion_Rate
FROM [Marketing_Data ]
GROUP BY City_Location
ORDER BY  Conversion_Rate DESC
```

4. Device Performance:
- How do ad performances compare across different devices (mobile, desktop, tablet)?
```
SQL
SELECT Device,Ad, SUM(Likes_Reactions) AS Likes,SUM(Shares) AS Shares,SUM(Comments) AS Comments
FROM [Marketing_Data ]
GROUP BY Device,Ad
ORDER BY Likes DESC
```
- Which device type generates the highest conversion rates?
```
SQL
SELECT TOP 1 Device, CAST(SUM(Conversions) AS decimal(10,3)) /SUM(CLICKS) * 100 AS Conversion_Rate
FROM [Marketing_Data ]
GROUP BY Device
ORDER BY Conversion_Rate DESC
```
5. Ad-Level Analysis:
- Which specific ads are performing best in terms of engagement and conversions?
```
SQL
SELECT Ad, SUM(Likes_Reactions) AS Likes,SUM(Shares) AS Shares,SUM(Comments) AS Comments, 
(SUM(Shares) + SUM(Comments) + SUM(Likes_Reactions)) AS Engagements,
SUM(Conversions) AS Conversions
FROM [Marketing_Data ]
GROUP BY Ad
ORDER BY Likes DESC
```

- What are the common characteristics of high-performing ads?
```
SQL
SELECT Ad, SUM(Likes_Reactions) AS Likes,SUM(Shares) AS Shares,SUM(Comments) AS Comments, 
(SUM(Shares) + SUM(Comments) + SUM(Likes_Reactions)) AS Engagements,
SUM(Conversions) AS Conversions
FROM [Marketing_Data ]
GROUP BY Ad
ORDER BY Likes DESC
```
```
SQL
SELECT Ad, Likes_Reactions AS Likes, Shares AS Shares, Comments AS Comments, Conversions AS Conversions
FROM [Marketing_Data ]
ORDER BY Likes DESC
```
6. ROI Calculation:
- What is the ROI for each campaign, and how does it compare across different channels and devices?

```
SQL
SELECT Campaign, Channel, Device,
(SUM(Total_conversion_value_GBP) - SUM(Spend_GBP)) / SUM(Spend_GBP) as ROI
FROM Marketing_Data
GROUP BY Campaign,Channel,Device
ORDER BY ROI DESC
```
- How does spend correlate with conversion value across different campaigns?

```
SQL
SELECT Campaign,
SUM(Spend_GBP) AS Spend_GBP,
SUM(Total_conversion_value_GBP) AS Total_conversion_value_GBP,
SUM(Total_conversion_value_GBP)/SUM(Spend_GBP) AS Spend_per_Convertion
FROM [Marketing_Data ]
GROUP BY Campaign
ORDER BY Spend_per_Convertion
```
7. Time Series Analysis:
- Are there any noticeable trends or seasonal effects in ad performance over time?
```
SQL
SELECT DATEPART(MONTH, DATE) AS MONTH, DATENAME(MONTH, DATE) AS MONTH_NAME,
SUM(Spend_GBP) AS Spend_GBP,
SUM(Total_conversion_value_GBP) AS Total_conversion_value_GBP,
SUM(Conversions) AS CONVERSIONS
FROM [Marketing_Data ]
GROUP BY DATEPART(MONTH, DATE), DATENAME(MONTH, DATE) 
ORDER BY MONTH
```

## Insights
- The Fall Campaign outperformed all other periods, generating the highest number of impressions, clicks, and conversions. In total, Fall recorded 6,434,259 impressions, 85,120 clicks, and 14,886 conversions, which indicate strong audience engagement and high conversion during the fall season.
- Fall had the highest Cost Per Click (CPC) at $0.9314 and an Average Click-Through Rate (CTR) of 1.13%. Summer followed with a CPC of $0.8849 and CTR of 1.14%, while Spring had the lowest CPC at $0.8592 but the highest CTR at 1.23%. These trends suggest that while Fall had the highest ad costs, Spring delivered the most efficient engagement in terms of CTR.
   Pinterest has the highest Return on Investment (ROI) of 21.50 compared to the rest of the campaign showing strong cost efficiency and good revenue generation during this time.
- Facebook has 5,438,638 Impressions, 69,961 Clicks which is the highest compared to Instagram with 4,839,709 Impressions, 68,655 Clicks and  Pinterest  with 4,364,288 Impressions, 42,982 Clicks. However, Instagram has 15,590 Conversions which is the highest compared to Facebook with 13,132 Conversions and Pinterest with 11,530 Conversions. This shows Facebook had the most traffic while Instagram converted the most users.
- London has the highest overall engagement (285,706), followed by Manchester (278,159) and Birmingham (237,874).
- Birmingham has the highest overall conversion rate (28.78), followed by Manchester (22.86) and London (17.61)
- Both the "Discount" ad  and  the "Collection" ad performed better on Mobile than on Desktop. Mobile devices generated higher engagement across all ad types, confirming that users are more active on mobile compared to desktops.
- Discount ads have the highest likes which is the most common interaction  indicating user appreciation while Collection has the highest share. This suggests that collection ads content is valuable enough to be shared but it may need adjustments in message or visuals to increase user interaction. However, comments are the least frequent engagement, implying that the ads may not be prompting much conversation or feedback
- Desktop generated the highest conversion rate 0f 23.98%. This implies that ads are purchased more via desktop compared to mobile.
- Discount ads are the best performing ads in terms of overall engagements(459,629)  and conversions(21,183)
- Discount Ad shows that it is high-performing having the highest number of Likes, Comments and Conversions. 
Spring recorded the highest ROI (23.82 from Pinterest on Desktop) but showed lower values across other platforms. Similarly, Summer demonstrated strong overall performance, with a high ROI from Pinterest. Fall maintained a competitive ROI, though slightly lower than Spring and Summer.
- Pinterest emerged as the top-performing channel, particularly on Desktop, which indicates it being the primary driver of high ROI. In contrast, Facebook recorded the lowest ROI, suggesting it may not be the most effective platform for this campaign. Additionally, Desktop consistently outperformed Mobile, indicating that users on desktops are more likely to convert or engage profitably.
- There is a positive correlation between Spend and Total Conversion Value across all campaigns, meaning that higher spending generally leads to higher conversion value. Fall exhibits the strongest correlation, while Summer shows relatively high efficiency despite lower spending.
- Early months  from  (March–August) show relatively stable but lower performance, suggesting a low ad strategy.  Increased spending from September to November leads to higher conversions and conversion value. Ad performance improves in the later months of the year, likely due to seasonal demand.
  
## Recommendations

- Given that Fall generated the highest impressions, clicks, and conversions, allocate a higher budget for campaigns during this period to maximize engagement and ROI. Consider launching promotional offers or exclusive deals in Fall to capitalize on the strong seasonal demand.
- Pinterest delivered the highest ROI, particularly on Desktop. Prioritize Pinterest ads for high-ROI campaigns, especially during Spring and Summer.
- Facebook generated the most traffic but had the lowest ROI. Optimize Facebook campaigns by improving audience targeting and refining creatives to enhance conversion rates.
- Since Instagram had the highest conversions, increase budget allocation for Instagram, particularly for high-intent audiences. Test Instagram-exclusive promotions to further boost conversion potential.
- Discount ads had the highest engagements and conversions, suggesting strong appeal. Invest more in Discount ads while testing variations for further improvement. Since Collection ads had the highest shares but fewer interactions, adjust messaging to drive more direct engagement.
- Since higher spending leads to higher conversion value, strategically increase budget allocation from September to November when ad performance peaks. Maintain steady but lower spending from March–August, using this period for testing new strategies.
- London had the highest engagement, which can be improved by allocating more resources to ads in this city. Additionally, optimize ads Manchester and Birmingham by improving ads message and introducing a catchy call to action. Birmingham, despite lower engagement numbers, had a strong conversion rate. Test tailored messaging to further enhance performance.



