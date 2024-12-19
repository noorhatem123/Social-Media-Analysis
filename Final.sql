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
