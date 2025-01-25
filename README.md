## Project Overview  \
This project uses R to analyze cleaned COVID-19 data, focusing on statistical and visual techniques to explore relationships between variables. The workflow includes data preprocessing, handling missing values, exploratory data analysis (EDA), statistical testing, and regression modeling to uncover meaningful insights.  \
\
## Features  \
- **Data Preprocessing:** Loads and processes a cleaned dataset (`CleanedData.csv`) to ensure readiness for analysis.  \
- **Missing Data Visualization:** Generates a missingness map to visualize data gaps.  \
- **Data Visualization:** Produces boxplots, histograms, and Q-Q plots for dependent and independent variables.  \
- **Statistical Analysis:** Conducts normality tests, correlation analysis, and Kaiser-Meyer-Olkin (KMO) tests to assess data suitability for further analysis.  \
- **Regression Modeling:** Builds linear regression models to evaluate the impact of various independent variables on total deaths.  \
\
## Files and Structure  \
\
### **1. Code Script**  \
- **RScript.R**: The main R script containing code for the complete analysis. Key sections include:  \
  - Library imports and working directory setup.  \
  - Data loading from `CleanedData.csv`.  \
  - Missing data handling and visualization.  \
  - Exploratory data analysis (boxplots, histograms, and Q-Q plots).  \
  - Statistical tests (Kolmogorov-Smirnov, Pearson correlation, and KMO).  \
  - Regression modeling to explore relationships between dependent and independent variables.  \
\
### **2. Dataset**  \
- **CleanedData.csv**: The cleaned dataset containing COVID-19-related variables, such as health conditions, employment data, and total deaths.  \
\
### **3. Outputs**  \
- **Graphs and Visualizations:**  \
  - Missingness map (`png/Missingness Map.png`)  \
  - Boxplots, histograms, and Q-Q plots of dependent and independent variables  \
  - Correlation matrices (full and filtered for strong correlations)  \
\
### **4. Output Directory**  \
- **png/**: Folder containing all generated visualizations.  \
\
## How to Use  \
1. **Set Up Environment:**  \
   - Install the required R packages (`ggplot2`, `ppcor`, `car`, `corrplot`, etc.).  \
   - Place the dataset (`CleanedData.csv`) in the working directory.  \
2. **Run the Script:**  \
   - Execute `RScript.R` in an R environment.  \
   - The script processes the data, visualizes trends, and performs statistical analyses.  \
3. **Review Outputs:**  \
   - Check the `png/` folder for generated plots.  \
   - Review the console output for statistical test results and regression summaries.  \
\
## Requirements  \
- **R Version:** 4.0+  \
- **Required Libraries:**  \
  - `ggplot2`  \
  - `ppcor`  \
  - `car`  \
  - `corrplot`  \
  - `corrgram`  \
  - `Amelia`  \
  - `psych`  \
\
## Contact  \
For questions or access to the dataset, feel free to email me.\
