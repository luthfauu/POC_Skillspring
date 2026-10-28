create database course_analytics; 
use course_analytics;

CREATE TABLE course_events (
    event_id VARCHAR(20) PRIMARY KEY,
    user_id VARCHAR(20),
    course_name VARCHAR(50),
    event_name VARCHAR(50),
    device VARCHAR(20)
);

SELECT *
FROM course_events;
