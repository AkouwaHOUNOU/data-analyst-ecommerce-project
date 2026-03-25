# ================================
# E-COMMERCE DATA ANALYSIS PROJECT
# ================================

# IMPORT LIBRARIES
import pandas as pd
import matplotlib.pyplot as plt

print("STARTING DATA ANALYSIS PROJECT")

# ================================
# LOAD DATA
# ================================

print("\nLOADING DATA...")

# Make sure the file is in the same folder
df = pd.read_excel("Data_analysis.xlsx")

print("DATA LOADED SUCCESSFULLY")
print("\nDATA PREVIEW:")
print(df.head())

# ================================
# DATA CLEANING
# ================================

print("\nCLEANING DATA...")

# Remove rows with missing CustomerID
df = df.dropna(subset=["CustomerID"])

# Remove negative values
df = df[(df["Quantity"] > 0) & (df["UnitPrice"] > 0)]

# Create Revenue column
df["Revenue"] = df["Quantity"] * df["UnitPrice"]

print("DATA CLEANING COMPLETED")

# ================================
# DATA ANALYSIS
# ================================

# REVENUE BY COUNTRY
print("\nANALYSIS: REVENUE BY COUNTRY")
revenue_by_country = df.groupby("Country")["Revenue"].sum().sort_values(ascending=False)
print(revenue_by_country.head())

# TOP CUSTOMERS
print("\nANALYSIS: TOP CUSTOMERS")
top_customers = df.groupby("CustomerID")["Revenue"].sum().sort_values(ascending=False)
print(top_customers.head())

# NUMBER OF SALES
print("\nANALYSIS: NUMBER OF SALES")
num_sales = df["InvoiceNo"].nunique()
print("TOTAL NUMBER OF SALES:", num_sales)

# AVERAGE REVENUE PER CUSTOMER
print("\nANALYSIS: AVERAGE REVENUE PER CUSTOMER")
avg_revenue = df["Revenue"].sum() / df["CustomerID"].nunique()
print("AVERAGE REVENUE PER CUSTOMER:", avg_revenue)

# ================================
# DATA VISUALIZATION
# ================================

print("\nCREATING VISUALIZATION...")

revenue_by_country.head(10).plot(kind="bar")
plt.title("TOP 10 COUNTRIES BY REVENUE")
plt.xlabel("COUNTRY")
plt.ylabel("REVENUE")

plt.show()

print("\nDATA ANALYSIS COMPLETED SUCCESSFULLY")
