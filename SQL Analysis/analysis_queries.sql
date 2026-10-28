 -- ANALYSIS QUERIES
 
 use course_analytics;
 -- 1. Business question: Which courses attract the most interest?
 SELECT course_name, COUNT(*) AS total_views FROM course_events WHERE event_name = 'view_course'
GROUP BY course_name ORDER BY total_views DESC;
-- Output
-- Web Development	19
-- Data Analytics	18
-- Cyber Security	18
-- Insight: Web Development received the highest number of course views (19), slightly ahead of Data Analytics and Cyber Security (18 each). Interest is nearly evenly distributed across all three courses.

-- 2. Business question: How do courses rank based on enrollment attempts?
WITH course_enrollments AS (
SELECT course_name, COUNT(*) AS total_enroll_clicks FROM course_events WHERE event_name = 'enroll_click'
GROUP BY course_name)
SELECT course_name, total_enroll_clicks, RANK() OVER (ORDER BY total_enroll_clicks DESC) AS enrollment_rank
FROM course_enrollments;
-- Output:
-- course_name  total_enroll_clicks  enrollment_rank
-- Data Analytics	         12	                1
-- Web Development        	 12	                1
-- Cyber Security	         11	                3 
-- insight: Data Analytics and Web Development rank jointly first, with 12 enrollment clicks each, while Cyber Security comes next with 11 clicks. The difference is minimal, suggesting similar enrollment interest across all three courses.

-- 3. Business question: What percentage of users who click Enroll successfully submit the form?
SELECT course_name,
ROUND(100.0 * COUNT(DISTINCT CASE WHEN event_name = 'generate_lead' THEN user_id END)
/( COUNT(DISTINCT CASE WHEN event_name = 'enroll_click' THEN user_id END)),2) 
AS click_to_submit_pct
FROM course_events GROUP BY course_name ORDER BY click_to_submit_pct DESC;
-- Output:
-- Data Analytics	33.33
-- Web Development	33.33
-- Cyber Security	18.18
-- Insight: Data Analytics and Web Development had the highest conversion rates (33.33%), while Cyber Security had the lowest (18.18%). All courses generally have lower rates indicating its enrollment experience may need further investigation.

-- 4. Business question: Which courses convert the most interested users into leads?
SELECT course_name, 
ROUND(100.0 * COUNT(DISTINCT CASE WHEN event_name = 'generate_lead' THEN user_id END)
/ (COUNT(DISTINCT CASE WHEN event_name = 'view_course' THEN user_id END)),2) AS viewer_to_submit_pct
FROM course_events GROUP BY course_name ORDER BY viewer_to_submit_pct DESC;
-- Output:
-- Data Analytics	23.53
-- Web Development	23.53
-- Cyber Security	12.50
-- Insight: View-to-lead conversion rates were relatively low across all courses (12.5%–23.53%), indicating that most viewers did not submit the enrollment form. The business could review course fees, duration, and the enrollment process to identify possible improvements.

-- 5. Business question: Where are users dropping off in the enrollment funnel?
SELECT course_name,
COUNT(DISTINCT CASE WHEN event_name = 'view_course' THEN user_id END) AS viewed_users,
COUNT(DISTINCT CASE WHEN event_name = 'enroll_click' THEN user_id END) AS clicked_users,
COUNT(DISTINCT CASE WHEN event_name = 'generate_lead' THEN user_id END) AS submitted_users
FROM course_events GROUP BY course_name;
-- Output:
-- Course           viewed_users   clicked_users   submitted_users
-- Cyber Security	     16	             11	                2
-- Data Analytics	     17	             12	                4
-- Web Development	     17	             12	                4
-- Insight: The biggest drop-off occurs between viewing a course and clicking Enroll, followed by another drop-off during form submission. Cyber Security has the highest drop-off, with only 2 of 11 users who clicked Enroll submitting the form.

-- 6. Business question: Does user behavior differ by device?
SELECT device, COUNT(DISTINCT user_id) AS total_users,
SUM(CASE WHEN event_name = 'view_course' THEN 1 ELSE 0 END) AS total_views,
SUM(CASE WHEN event_name = 'enroll_click' THEN 1 ELSE 0 END) AS total_enroll_clicks,
SUM(CASE WHEN event_name = 'generate_lead' THEN 1 ELSE 0 END) AS total_leads
FROM course_events GROUP BY device ORDER BY total_users DESC;
-- Output:
-- device	total_users	 total_views total_enroll_clicks total_leads
-- mobile	    20	          22	             12	          4
-- desktop	    19	          20	             17	          6
-- tablet	    11	          13	              6	          0
-- Insight: Desktop users generated the most enrollment clicks (17) and leads (6), while tablet users generated no leads despite 13 course views. The tablet enrollment experience may need investigation to identify possible usability issues.

-- 7. Business question: Is the dataset reliable enough to analyze?
--  A. Check missing values
SELECT SUM(course_name IS NULL OR course_name = '') AS missing_course,
SUM(event_name IS NULL OR event_name = '') AS missing_event,
SUM(user_id IS NULL OR user_id = '') AS missing_user, SUM(device IS NULL OR device = '') AS missing_device
FROM course_events;
-- Output:
-- 0	0	0	0
-- Insight: The dataset has no missing values in the checked columns, indicating good completeness

-- B. Check for duplicate event records
SELECT event_id, COUNT(*) AS record_count FROM course_events GROUP BY event_id HAVING COUNT(*) > 1;
-- Output: null
-- Insight: No duplicate event IDs were found, indicating that each event record has a unique identifier.

-- RECOMMENDATIONS
-- Improve course-to-enrollment conversion: Review course descriptions, fees, duration, and calls to action to encourage more viewers to click Enroll.
-- Investigate Cyber Security performance: Examine its pricing, course content, and enrollment journey to understand its lower conversion rate.
-- Review tablet usability: Test the enrollment form and user experience on tablet devices to identify possible technical or usability issues.
-- Reduce enrollment drop-offs: Simplify the form and check unnecessary steps that could discourage users from submitting their details.
-- Monitor conversion metrics: Track course views, enrollment clicks, lead submissions, and conversion rates regularly to identify changes in user behavior.



