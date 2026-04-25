# manufacturing-failure-analysis
An end-to-end data analysis project identifying the root causes of  machine failures in a manufacturing environment, quantifying their  business cost, and building an interactive dashboard to support  maintenance decision-making.

## Live Dashboard
👉 [View Interactive Tableau Dashboard](https://public.tableau.com/views/FailureAnalysisDashboard/FailureAnalysisDashboard)

## Business Problem

Machine failures in manufacturing environments cause unplanned downtime, 
quality losses, and significant financial cost. This project addresses 
three core questions:

1. Which failure types cause the most downtime and what do they cost?
2. At what point do tool wear and torque levels become dangerous?
3. Which product types are most at risk and why?

The goal is to move from reactive maintenance (fixing machines after 
they break) to predictive maintenance (identifying risk before failure 
occurs).

## Dataset

**Source:** AI4I 2020 Predictive Maintenance Dataset — UCI Machine Learning Repository  
**Link:** https://archive.ics.uci.edu/dataset/601/ai4i+2020+predictive+maintenance+dataset  
**Size:** 10,000 production runs across three product types (L, M, H)  
**Features:** Air temperature, process temperature, rotational speed, 
torque, tool wear, and five failure type indicators (TWF, HDF, PWF, OSF, RNF)  
**Overall failure rate:** 3.39% (339 failures out of 10,000 runs)

## Tools Used

| Tool | Purpose |
|------|---------|
| Python (pandas, matplotlib) | Data cleaning, OEE analysis, visualisation |
| SQL (SQLite) | Business queries and cost impact analysis |
| Tableau Public | Interactive dashboard |
| Jupyter Notebook | Analysis environment |

## Key Findings

### 1. Three failure types cause 82% of all downtime cost
Heat Dissipation Failure (HDF), Overstrain Failure (OSF), and Power 
Failure (PWF) account for 308 out of 339 total failures — representing 
approximately £308,000 of the £373,000 estimated annual downtime cost.
Prioritising these three failure types would eliminate the majority of 
unplanned stoppages.

### 2. Tool wear has a critical tipping point at 200 minutes
Failure rate stays stable at around 2.2% for tool wear between 0 and 
200 minutes. Above 200 minutes it jumps to 15.4% — a 7x increase. 
This suggests a clear maintenance policy: replace tools before they 
reach 200 minutes of use regardless of visual condition.

### 3. High torque is extremely dangerous
Machines running above 60Nm have a 41.8% failure rate — nearly one 
in two runs ends in failure. Even at 50-60Nm the rate is 8.3%, 
significantly above the safe operating range of 0.6-1.9% seen between 
20-50Nm. Any machine exceeding 50Nm should trigger an immediate 
operational review.

### 4. L-type products carry disproportionate risk
L-type products have a 3.9% failure rate compared to 2.1% for H-type — 
nearly twice as high. With 6,000 L-type runs per year they account for 
£235,000 of the total £373,000 annual cost. Production planning should 
consider whether L-type product schedules can be optimised to reduce 
machine stress.

## Recommendations

Based on the analysis, three immediate actions would significantly 
reduce downtime cost:

1. **Implement a 200-minute tool replacement policy**
2. **Add torque monitoring alerts**
3. **Prioritise HDF root cause investigation**

## Project Structure

manufacturing-failure-analysis/
│
├── oee_exploration.ipynb
├── manufacturing_analysis.sql
├── ai4i_clean.csv
├── failure_analysis.png
└── README.md

## How to Run

1. Clone this repository
2. Install dependencies: `pip install pandas matplotlib jupyter`
3. Open `oee_exploration.ipynb` in Jupyter Notebook
4. Run all cells in order
5. View the live dashboard at the link above
