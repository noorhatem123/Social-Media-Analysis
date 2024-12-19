-- 1. Create Database
CREATE DATABASE social_media_analytics;
USE social_media_analytics;

-- 2. Sentiment Table
CREATE TABLE sentiment (
    sentiment_id INT PRIMARY KEY,
    sentiment VARCHAR(50)
);

-- 3. Platforms Table
CREATE TABLE platforms (
    platform_id INT PRIMARY KEY,
    Platform VARCHAR(50)
);

-- 4. Audience Demographics Table
CREATE TABLE audience_demographics (
    audience_id INT PRIMARY KEY,
    Audience_Gender VARCHAR(20),
    Audience_Age INT,
    Audience_Location VARCHAR(100),
    Audience_Interests VARCHAR(100)
);

-- 5. Post Details Table
CREATE TABLE post_details (
    Post_ID INT PRIMARY KEY,
    platform_id INT,
    sentiment_id INT,
    Post_Type VARCHAR(50),
    Post_Timestamp DATETIME,
    Post_Content TEXT,
    Post_Hour INT,
    Post_Minute INT,
    FOREIGN KEY (platform_id) REFERENCES platforms(platform_id),
    FOREIGN KEY (sentiment_id) REFERENCES sentiment(sentiment_id)
);

-- 6. Engagement Metrics Table
CREATE TABLE engagement_metrics (
    Post_ID INT PRIMARY KEY,
    audience_id INT,
    platform_id INT,
    sentiment_id INT,
    Likes INT,
    Comments INT,
    Shares INT,
    Reach INT,
    Impressions INT,
    Engagement_Rate FLOAT,
    FOREIGN KEY (Post_ID) REFERENCES post_details(Post_ID),
    FOREIGN KEY (audience_id) REFERENCES audience_demographics(audience_id),
    FOREIGN KEY (platform_id) REFERENCES platforms(platform_id),
    FOREIGN KEY (sentiment_id) REFERENCES sentiment(sentiment_id)
);

-- Select the platform name, sentiment type, and count of posts
-- Retrieve Sentiment Trends by Platform 
SELECT 
    p.Platform,                     -- The name of the platform (e.g., Facebook, Twitter)
    s.sentiment,                   -- The sentiment type (Positive, Neutral, Negative)
    COUNT(em.Post_ID) AS Post_Count -- The total number of posts with the specific sentiment on the platform
FROM 
    engagement_metrics em           -- Main table containing post engagement metrics
JOIN 
    platforms p ON em.platform_id = p.platform_id -- Joining to get platform names
JOIN 
    sentiment s ON em.sentiment_id = s.sentiment_id -- Joining to get sentiment types
GROUP BY 
    p.Platform, s.sentiment          -- Grouping by platform and sentiment for aggregation
ORDER BY 
    p.Platform, s.sentiment;         -- Sorting the result by platform and sentiment for better readability


-- Find Top Audience Demographics for Engagement
-- Select audience demographics and their average engagement rate
SELECT 
    ad.Audience_Gender,             -- The gender of the audience (e.g., Male, Female, Other)
    ad.Audience_Age,                -- The age group of the audience
    ad.Audience_Location,           -- The location of the audience (e.g., Country, Region)
    AVG(em.Engagement_Rate) AS Avg_Engagement_Rate -- The average engagement rate for this demographic
FROM 
    engagement_metrics em            -- Main table containing post engagement metrics
JOIN 
    audience_demographics ad ON em.audience_id = ad.audience_id -- Joining to get audience demographics
GROUP BY 
    ad.Audience_Gender, ad.Audience_Age, ad.Audience_Location -- Grouping by audience attributes for aggregation
ORDER BY 
    Avg_Engagement_Rate DESC         -- Sorting by highest average engagement rate to find top-performing demographics
LIMIT 10;                            -- Limiting the results to the top 10 audience groups


-- Analyze Post Types and Engagement Metrics
-- Select post type, platform, and average engagement metrics
SELECT 
    pd.Post_Type,                   -- The type of the post (e.g., Image, Video, Link)
    p.Platform,                     -- The name of the platform (e.g., Facebook, Twitter)
    AVG(em.Likes) AS Avg_Likes,     -- The average number of likes for this post type on the platform
    AVG(em.Comments) AS Avg_Comments, -- The average number of comments for this post type on the platform
    AVG(em.Shares) AS Avg_Shares    -- The average number of shares for this post type on the platform
FROM 
    post_details pd                  -- Table containing post details
JOIN 
    engagement_metrics em ON pd.Post_ID = em.Post_ID -- Joining to get engagement metrics
JOIN 
    platforms p ON pd.platform_id = p.platform_id -- Joining to get platform names
GROUP BY 
    pd.Post_Type, p.Platform         -- Grouping by post type and platform for aggregation
ORDER BY 
    Avg_Likes DESC;                  -- Sorting by the highest average likes for insights into popular post types


