-- 10 queries to get insights from 5 tables
USE customer_sales;

-- customer data
-- 1. Overall gender counts
SELECT 
    COUNT(CASE WHEN Gender = 'Female' THEN 1 END) AS Female_count,
    COUNT(CASE WHEN Gender = 'Male' THEN 1 END) AS Male_count
FROM customer_analysis;

-- 2. Overall counts by continent, country, and state 
SELECT 
    Continent, 
    Country, 
    State, 
    COUNT(*) AS customer_count
FROM customer_analysis
GROUP BY Continent, Country, State;
  
-- 3. Overall age counts (like minor, adult, old)
SELECT 
    CASE 
        WHEN TIMESTAMPDIFF(YEAR, Birthday, CURDATE()) BETWEEN 20 AND 39 THEN '20-39'
        WHEN TIMESTAMPDIFF(YEAR, Birthday, CURDATE()) BETWEEN 40 AND 59 THEN '40-59'
        WHEN TIMESTAMPDIFF(YEAR, Birthday, CURDATE()) BETWEEN 60 AND 79 THEN '60-79'
        WHEN TIMESTAMPDIFF(YEAR, Birthday, CURDATE()) >= 80 THEN '80 and above'
    END AS Age_Group,
    COUNT(*) AS Count_Age_Customers
FROM customer_analysis
GROUP BY Age_Group;

-- Exchange data;
-- 4. Currency code contribution
SELECT 
    Currency_Code, 
    SUM(Exchange) AS Total_Contribution
FROM exchange_rates
GROUP BY Currency_Code
ORDER BY Total_Contribution DESC;

-- 5. Yearly contribution
SELECT 
    YEAR(Date) AS Year,              
    AVG(Exchange) AS Average_Rate 
FROM 
    exchange_rates                     
GROUP BY 
    Year                               
ORDER BY 
    Year;                              

-- Product data;
-- 6. Counts of Category, Subcategory, Product Name, and Product
SELECT 
    Category,
    COUNT(DISTINCT Subcategory) AS Subcategory_Count,  
    COUNT(DISTINCT Product_Name) AS Product_Name_Count,  
    COUNT(*) AS Product_Count                             
FROM 
    product_analysis                                        
GROUP BY 
    Category                                             
ORDER BY 
    Category;                                           

-- 7. Brand sales analysis
SELECT 
    Brand,                                      
    SUM(Unit_Price_USD) AS Total_Sales,          
    COUNT(*) AS Product_Count                  
FROM 
    product_analysis                                
GROUP BY 
    Brand                                     
ORDER BY 
    Total_Sales DESC;       
    
-- 8. Color contribution
SELECT 
    Color,                                        
    COUNT(*) AS Product_Count                     
FROM 
    product_analysis                                  
GROUP BY 
    Color                                        
ORDER BY 
    Product_Count DESC;                          
    
-- 9. Profit analysis by Subcategory
SELECT 
    Subcategory,                              
    SUM(Unit_Cost_USD) AS Total_Manufacturing_Cost,   
    SUM(Unit_Price_USD) AS Total_Selling_Cost,   
    SUM(Unit_Price_USD) - SUM(Unit_Cost_USD) AS Total_Profit 
FROM 
    product_analysis                                
GROUP BY 
    Subcategory                              
ORDER BY 
    Total_Profit DESC;                          
    
-- Sales data
-- 10. Overall sales in year
SELECT 
    YEAR(Order_Date) AS Year,                 
    SUM(Quantity) AS Total_Quantity           
FROM 
    sales_analysis                                  
GROUP BY 
    Year                                       
ORDER BY 
    Year;                                     

-- 11. Currency contribution
SELECT 
    Currency_Code,                             
    SUM(Quantity) AS Total_Quantity,          
    ROUND(SUM(Quantity) / (SELECT SUM(Quantity) FROM sales_analysis) * 100, 2) AS Contribution_Percentage  
FROM 
    sales_analysis                            
GROUP BY 
    Currency_Code                           
ORDER BY 
    Total_Quantity DESC;                     

-- Store data
-- 12. Total counts of stores by square meter
SELECT 
    Country,                                  
    COUNT(*) AS Total_Stores,                 
    SUM(Square_Meters) AS Total_Square_Meter    
FROM 
    store_analysis                                
GROUP BY 
    Country                                  
ORDER BY 
    Total_Square_Meter DESC;
