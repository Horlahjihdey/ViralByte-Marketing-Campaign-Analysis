SELECT * FROM [Marketing Data]
WHERE Total_conversion_value_GBP = ' '

-- I WANT TO CHECK FOR DUPLICATE --
SELECT *, COUNT(*) FROM [Marketing Data]
GROUP BY Campaign,Date,City_Location,Channel,Device,Ad,Impressions,CTR,Clicks,Daily_Average_CPC,Spend_GBP,Conversions,Total_conversion_value_GBP,Likes_Reactions,Shares,Comments,Latitude,Longitude
HAVING COUNT(*) > 1
-- No Duplicate Detected--

-- CHANGING IMPRESSION FROM FLOAT TO INTEGER--
ALTER TABLE [Marketing Data] 
ALTER COLUMN Impressions INT;
-- SUCCESSFULLY CHANGE DATATYPE FROM FLOAT TO INTEGER--

--CONVERTING DAILY_AVERAGE_CPC and TOTAL_CONVERSION_VALUE_GBP--
UPDATE [Marketing Data]
SET Daily_Average_CPC = ROUND (Daily_Average_CPC, 3)
UPDATE [Marketing Data]
SET Total_conversion_value_GBP = ROUND (Total_conversion_value_GBP, 4)

--●	Which campaign generated the highest number of impressions, clicks, and conversions--
SELECT Campaign, 
SUM(Impressions) as Impressions,
SUM(Clicks) as Clicks,
SUM(Conversions) as Conversions
FROM [Marketing Data]
GROUP BY Campaign
ORDER BY Impressions DESC

--●	What is the average cost-per-click (CPC)  and click-through rate (CTR) for each campaign?--
SELECT Campaign,
AVG(Daily_Average_CPC) as AVG_CPC
FROM [Marketing Data]
GROUP BY Campaign

--Converting percentage of CTR to decimal--
UPDATE [Marketing Data]
SET CTR = CAST(REPLACE(CTR, '%', '') AS FLOAT)/100
--Converting FLOAT CTR to Decimal--
ALTER TABLE [Marketing Data] 
ALTER COLUMN CTR DECIMAL(10,4)

SELECT Campaign,
SUM (Spend_GBP)/SUM (Clicks)
FROM[Marketing Data]
GROUP BY Campaign

ALTER TABLE [Marketing Data]
ALTER COLUMN Spend_GBP MONEY;

SELECT Campaign,
SUM (Spend_GBP)/SUM (Clicks) As CPC,
AVG (CTR) AS AVERAGE_CTR
FROM[Marketing Data]
GROUP BY Campaign

--Number 2 question--
--Which channel has the highest ROI--
SELECT Campaign,
(SUM (Total_conversion_value_GBP) - SUM (Spend_GBP)) /SUM (Spend_GBP) AS ROI
FROM [Marketing Data]
GROUP BY Campaign

--●	How do impressions, clicks, and conversions vary across different  channels?--
SELECT channel,
SUM(Impressions) As Impression,
SUM(Clicks) As Clicks,
SUM(Conversions) As Conversions
FROM [Marketing Data]
GROUP BY Channel

--Number 3--
--●	Which cities have the highest engagement rates (likes, shares, comments)?--

SELECT City_Location,
SUM(Likes_Reactions) As Likes_Reactions,
SUM(Shares) As Shares,
SUM(Comments) As Comments
FROM [Marketing Data]
GROUP BY City_Location
ORDER BY Likes_Reactions DESC

--●	What is the conversion rate by city?--
SELECT City_Location,
CAST (SUM (Conversions) AS Decimal (10,3)) /SUM (Clicks)*100 As Conversion_Rate
FROM [Marketing Data]
GROUP BY City_Location

--Number 4--
--●	How do ad performances compare across different devices (mobile, desktop, tablet)?--
SELECT Device, Ad,
SUM(Likes_Reactions) As Likes_Reactions,
SUM(Shares) As Shares,
SUM(Comments) As Comments
FROM [Marketing Data]
GROUP BY Device,Ad

--●	Which device type generates the highest conversion rates?--
SELECT Device,
CAST (SUM (Conversions) AS Decimal (10,3)) /SUM (Clicks)*100 As Conversion_Rate
FROM [Marketing Data]
GROUP BY Device

--Number 5--
--●	Which specific ads are performing best in terms of engagement and conversions?--
SELECT Ad,
SUM(Likes_Reactions) As Likes_Reactions,
SUM(Shares) As Shares,
SUM(Comments) As Comments,
SUM(Conversions) As Conversions
FROM [Marketing Data]
GROUP BY Ad
ORDER BY Likes_Reactions

--Number 5b--
--●	What are the common characteristics of high-performing ads?--
SELECT Channel, Ad,Device,
SUM(Likes_Reactions) As Likes_Reactions,
SUM(Shares) As Shares,
SUM(Comments) As Comments,
SUM(Conversions) As Conversions
FROM [Marketing Data]
GROUP BY Channel, Ad,Device
ORDER BY Device DESC

--Number 6--
--●	What is the ROI for each campaign, and how does it compare across different channels and devices?--
SELECT Campaign,Channel,Device,
(SUM(Total_Conversion_Value_GBP)- SUM(Spend_GBP))/ SUM(Spend_GBP) As ROI
FROM [Marketing Data]
GROUP BY Campaign,Channel,Device
ORDER BY ROI DESC

--Number 6b--
--●	How does spend correlate with conversion value across different campaigns?--
SELECT Campaign,
SUM (Spend_GBP) AS Spend_GBP,
SUM (Total_Conversion_Value_GBP) As Total_Conversion_Value_GBP
FROM [Marketing Data]
GROUP BY Campaign
ORDER BY Spend_GBP

--Number 7--
--●	Are there any noticeable trends or seasonal effects in ad performance over time?--
SELECT DATEPART(MONTH, DATE) AS MONTH, DATENAME(MONTH, DATE) AS MONTH_NAME,
SUM(Spend_GBP) AS Spend_GBP,
SUM(Total_Conversion_Value_GBP) AS Total_Conversion_Value_GBP
FROM [Marketing Data]
GROUP BY DATEPART(MONTH, DATE), DATENAME(MONTH, DATE)
ORDER BY MONTH