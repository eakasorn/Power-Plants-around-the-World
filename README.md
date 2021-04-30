# Information
This application makes use of electricity generating power plants data collected from around the globe. The data can be obtained from the World Resources Institute at https://datasets.wri.org/dataset/globalpowerplantdatabase. The original file consists of data from 2019 in the form of a .csv file.

The data is manipulated to reduce the size of the file by removing unnecessary column attributes such as Commision year and Plant owner. The main attributes that are focused on are the plant name, its geographical position and the country it is located in, the power generating capacity (MW) as well as primary fuel type. The final number of attributes remaining is about 10.

# Instruction
To run this application, R language and RStudio version 1.4.1103 is recommended. In this application, the library packages required are shiny, shinydashboard, DT, leaflet and countrycode.

To install R, click the link https://www.r-project.org/ and choose the version 4.0.4.
To install RStudio, click the link https://rstudio.com/products/rstudio/download/ and choose the RStudio Desktop version.
After downloading and installing R and RStudio, to install the required packages to run the code, in RStudio application on the bottom left section named "Console", run the 'code install.packages()' where inside the brackets, put in the name of the library to install. Note that double quotation marks are required. (For example, to install shiny package use the code 'install.packages("shiny")')
Set the working directory to the folder path where the csv file is located. This can be done using the code 'setwd()' where the path to the folder is inside the bracket.
To run the code open the app.R file in RStudio and select Run App in the top middle section of the application.