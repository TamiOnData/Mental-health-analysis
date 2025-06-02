# 🧠 Mental Health Among College Students – Data Cleaning Project

## 📌 Project Overview
This project involved cleaning and preparing a dataset related to mental health conditions (depression, anxiety, panic attacks, etc.) among college students. The goal was to transform messy data into a structured and reliable format ready for analysis and visualization.

## 🗂️ Data Source
- 📥 Downloaded from Kaggle: [Student Mental Health Dataset](https://www.kaggle.com/datasets/reymonthatarigan/student-mental-health?resource=download)
- 👥 Survey-based data including demographics, academics, and mental health indicators
- 📅 Original dataset includes timestamped records and varied formatting


## 🛠️ Tools Used
- 📊 **MySQL** – Data cleaning and transformation
- 💻 GitHub – Version control and project sharing

## 🧹 Data Cleaning Steps
- ✅ Renamed inconsistent columns
- ✅ Standardized text case and values (e.g., Gender, Course)
- ✅ Removed rows with invalid ages (<18 or >80)
- ✅ Converted timestamp into separate `Survey_date` and `Survey_time`
- ✅ Handled null and blank values
- ✅ Removed exact duplicate entries
- ✅ Added a `Course_flag` column to mark known/unknown programs

## 📈 Results & Findings
- 🧑‍🎓 Students in **Year 1 and Year 2** reported higher mental health challenges
- 💔 Single students showed a slightly higher rate of depression
- ❗ Several records had ambiguous or unknown courses, flagged for review
- 🧹 Final dataset is clean, consistent, and ready for exploratory analysis

## 📤 Final Output
You can find the cleaned dataset in the [data/cleaned_dataset.csv](./data/cleaned_dataset.csv) file.

---

### 📫 Let's Connect!
If you liked this project, feel free to star ⭐ the repo or connect with me!

