# 🗳️ Election Intelligence Analytics — Tamil Nadu Assembly Elections

> End-to-end Data Analytics & Business Intelligence project using official election datasets, Python, MySQL, and Power BI to build neutral, evidence-based comparative analysis.

## Portfolio Snapshot

| Evidence | Project coverage |
|---|---|
| **Data** | 3 election / constituency datasets |
| **Scale** | 8,490+ candidate-level records across 234 constituencies |
| **Python** | Cleaning, validation, feature engineering, EDA and research-question analysis |
| **SQL** | Integrity checks, joins, CTEs, window functions and reusable analytical views |
| **Power BI** | Data modelling, KPI analysis and interactive dashboard workflow |
| **Reporting** | Geographic, constituency-transition and vote-share analysis |

**[View the Final Executive Report](./reports/election_intelligence_executive_report.pdf)**

## 📌 Project Overview

**Election Intelligence Analytics** analyzes constituency-level election data from the **2021 and 2026 Tamil Nadu Assembly Elections** and transforms the supplied datasets into validated, analysis-ready data for comparative analysis, BI, and storytelling.

The project combines:

- **Python** for cleaning, feature engineering, EDA, and research-question analysis
- **MySQL / SQL** for validation, integrity checks, analytical queries, and reusable views
- **Power BI** for interactive analysis and reporting
- **Executive reporting** for structured, descriptive interpretation

The analytical focus is on **regional shifts, constituency-level winner changes, and vote-share patterns**.

---

## 🎯 Project Scope

The project works across:

| Scope | Coverage |
|---|---:|
| Core datasets | **3** |
| Candidate-level records | **8,490+** |
| Assembly constituencies | **234** |
| Election years | **2** |
| Core analytical stories | **3** |

---

## 📂 Datasets Used

**Provenance note:** This repository analyzes the three election/reference files supplied with the project. The current repository documents the files used for analysis; it does not independently certify the original publisher or licensing of those inputs.


| Dataset | Description | Purpose |
|---|---|---|
| **e1.csv** | 2021 Tamil Nadu Assembly Election Results | Historical comparison |
| **e2.xlsx** | 2026 Tamil Nadu Assembly Election Results | Comparative analysis |
| **e3.xlsx** | Constituency Master / Reference Data | District, region, reservation, and constituency mapping |

### Primary Analytical Key

`AC Number`

The datasets are connected at constituency level to support cross-year comparison and integration with constituency reference information.

---

## ⚙️ Analytical Workflow

```text
Source Election Data
        ↓
Python Cleaning & Validation
        ↓
Feature Engineering & EDA
        ↓
Research Question Analysis
        ↓
MySQL Validation & Integrity Checks
        ↓
SQL Analytical Layer
        ↓
Power BI Data Model & Dashboard
        ↓
Neutral Data Storytelling & Executive Reporting
```

## 🔎 Data Validation

The SQL layer includes checks for:

- row counts
- null values
- duplicate records
- constituency coverage
- referential integrity
- invalid vote values
- turnout ranges
- reservation categories
- regional coverage
- election-year consistency

This makes validation part of the analytical workflow rather than assuming the imported data is correct.

---

## 🔍 Three Core Analytical Stories

### 1. Geographic Story

**How did the distribution of Assembly seats change across Tamil Nadu's regions between 2021 and 2026?**

Focus:
- regional comparison
- constituency distribution
- geographic pattern analysis

### 2. Flip Story

**Which constituencies changed their winning party between 2021 and 2026?**

Focus:
- constituency-level transitions
- cross-year winner comparison
- geographic distribution of changes

### 3. Vote Share Story

**How did party vote share vary across regions and constituencies?**

Focus:
- vote-share comparison
- regional variation
- constituency-level competitive patterns

---

## 🛠️ Technology Stack

**Python:** Pandas, NumPy, Matplotlib, Seaborn  
**Database:** MySQL  
**SQL:** CTEs, window functions, joins, subqueries, validation queries, analytical views  
**BI:** Power BI  
**Environment:** Jupyter Notebook, Git, GitHub  
**Data formats:** CSV, Excel

---

## 📊 Project Outputs

- Python analytical notebook
- MySQL / SQL analytical layer
- data validation and integrity checks
- constituency and regional comparisons
- vote-share analysis
- winner-change analysis
- Power BI dashboard workflow
- executive presentation
- final executive report

---

## 📌 Repository Contents

```text
Election-Intelligence-Analytics/
├── README.md
├── election_intelligence_analysis.ipynb
├── sql/
│   └── election_intelligence_analytics.sql
├── reports/
│   └── election_intelligence_executive_report.pdf
├── e1.csv
├── e2.xlsx
├── e3.xlsx

```

---

## 📌 Data & Methodology Note

The analysis follows a **neutral and descriptive approach**. It focuses on the supplied election datasets and comparative analytical patterns rather than political advocacy, campaign strategy, prediction, or persuasion.

The findings should be interpreted within the scope, definitions, and limitations of the available project datasets.

---

## What This Project Demonstrates

**Source data → validation → analytical modelling → comparative analysis → BI → clear, evidence-based reporting.**
