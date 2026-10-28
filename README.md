# SkillSpring – Course Discovery Analytics POC

## 📌 Project Overview

SkillSpring is a web analytics proof of concept (POC) built to understand how users interact with a course-discovery website. The project combines website event tracking with data analysis to explore course engagement, enrollment behavior, and device performance.

**Live Website:** [SkillSpring Course Discovery](https://luthfauu.github.io/course-discovery-analytics/)

## 🎯 Objectives

- Implement website event tracking using Google Tag Manager (GTM) and Google Analytics 4 (GA4).
- Analyze course views, enrollment clicks, and successful form submissions.
- Identify potential enrollment funnel drop-offs.
- Compare course performance and device activity.
- Use SQL and Python to extract insights and suggest business improvements.

## 🛠️ Tools Used

- **Website:** HTML, CSS, JavaScript, GitHub Pages
- **Web Analytics:** Google Tag Manager (GTM), Google Analytics 4 (GA4)
- **Data Analysis:** MySQL, Python, Pandas
- **Visualization:** Matplotlib, Seaborn
- **Environment:** Jupyter Notebook

## 📂 Project Structure

- **`1-dataset/`** – Original GA4 export and synthetic event-level dataset.
- **`2-implementation-doc/`** – Detailed implementation documentation and website HTML code.
- **`3-python/`** – Python notebook containing data analysis and visualizations.
- **`4-screenshots/`** – GTM and GA4 implementation and testing screenshots.
- **`5-readme/`** – Project README documentation.
- **`6-sql/`** – SQL table schema and analysis queries.

## 📊 Dataset

Two datasets were used for different purposes:

- **Original GA4 data:** Used to validate event tracking and explore reports generated from actual website visits.
- **Synthetic dataset:** Contains 100 simulated event records with `event_id`, `user_id`, `course_name`, `event_name`, and `device`. It was created to support deeper SQL and Python analysis because the actual GA4 data was limited.

The two datasets were kept separate throughout the analysis.

## 💡 Key Insights

The following findings are from the synthetic dataset:

- **Course engagement:** Web Development recorded the highest course views (19). Data Analytics and Web Development had the highest enrollment clicks, with 12 each.
- **Course conversion:** Data Analytics and Web Development achieved view-to-lead conversion rates of 23.53% each, compared with 12.50% for Cyber Security.
- **Enrollment funnel:** Of 50 unique users associated with course views, 35 clicked Enroll and 10 generated leads. The largest decrease occurred between views and enrollment clicks.
- **Device performance:** Desktop recorded 17 enrollment clicks and 6 leads, while tablet recorded 6 clicks and no leads.

## 💼 Recommendations

- Review course fees, durations, and descriptions, and compare pricing with competing institutes.
- Investigate the lower conversion rate for Cyber Security.
- Test the enrollment experience on tablet devices.
- Monitor funnel drop-offs and simplify the enrollment process where necessary.



## ⚠️ Limitations

This is a demo website with a form that is not connected to a real backend. The actual GA4 dataset is limited and may include test visits. SQL and Python findings are based on synthetic data and should not be interpreted as actual customer behavior.

## ✅ Conclusion

This project demonstrates an end-to-end introductory web analytics workflow, from implementing GTM and GA4 tracking to analyzing event data with SQL and Python and translating findings into business recommendations.

For detailed implementation steps, SQL queries, Python analysis, and screenshots, refer to the respective project folders.

