library(shiny)
library(shinydashboard)
library(DT)
library(leaflet)
library(countrycode)

# Global electrical power production
df <- read.csv("globalpowerplantdatabasev120/modified_global_power_plant_database.csv")
df$continent <- countrycode(sourcevar=df$country, origin='iso3c', destination='continent')
df$continent[df$country_long=='Antarctica'] <- "Antarctica"
df$continent[df$country_long=='Kosovo'] <- "Europe"
  
#  Show only North America
north_america.list <- c("Antigua and Barbuda", "Bahamas", "Barbados", "Belize", "Canada", "Costa Rica", "Cuba", "Dominica", "Dominican Republic",
                        "El Salvador", "Grenada", "Guatemala", "Haiti", "Honduras", "Jamaica", "Mexico", "Nicaragua", "Panama",
                        "Saint Kitts and Nevis", "Saint Lucia", "Saint Vincent and the Grenadines", "Trinidad and Tobago", "United States of America")
df.north_america <- subset(df, country_long %in% north_america.list)

continent.list <- levels(sort(unique(as.factor(c(df$continent,"North America")))))
fuel_type.list <- levels(sort(unique(as.factor(c(df$primary_fuel, "All")))))

color_code <- c("Green", "Black", "Wheat", "Cyan", "Red", "Blue", "Orange", "Brown", "Purple", "Pink", "Yellow", "Honeydew", "Chocolate", "Navy", "Grey")

max.min.range <- range(df$capacity_mw)[2] - range(df$capacity_mw)[1]

# Shiny Interface
ui <- dashboardPage(
  dashboardHeader(title = "CS 424 Project X"),
  
  # Sidebar start
  dashboardSidebar(disable = FALSE, collapsed = FALSE,
                   
                   sidebarMenu(
                     menuItem("Power Plants", tabName = "pp"),
                     menuItem("About", tabName = "about")
                   )
  ),
  # Sidebar end
  
  # Body start
  dashboardBody(
    tabItems(
      # "About" Tab
      tabItem(tabName = "about",
              h2("About"),
              p("This project focuses on the visualization of data using the global electrical power production dataset in 2019.
                Important information such as the country abrreviation, country name, plant name, geographic posistion, capacity and fuel type are recorded.
                By mapping the data onto an interative map, it is possible to see the distribution of power plants around the world based on their continents.
                The original data is available from",
                a(" https://datasets.wri.org/dataset/globalpowerplantdatabase"),
                ".",
                style = "font-family : sans-serif"),
              p("The app is written by Eakasorn Suraminitkul and uses the data from 2019.",
                style = "font-family : sans-serif"),
      ),
      
      # "Power Plants" Tab
      tabItem(tabName = "pp",
              tabsetPanel(
                tabPanel("Map",
                  h2("Power Plants around the World"),
                  
                  # Map
                  fluidRow(
                    column(2,
                           selectInput("continent", "Continent",       
                                       continent.list, selected="North America")
                           ),
                    
                    column(3,sliderInput("min","Above (Min)",1,22500,1)),
                    column(3,sliderInput("max","Below (Max)",1,22500,22500)),
                     
                    column(1,
                           actionButton("reset", "Reset")
                           )
                    ),
                  
                   fluidRow(
                     column(1,
                            checkboxInput("ft1", fuel_type.list[2], FALSE)
                     ),
                     column(1,
                            checkboxInput("ft2", fuel_type.list[3], FALSE)
                     ),
                     column(1,
                            checkboxInput("ft3", fuel_type.list[4], FALSE)
                     ),
                     column(1,
                            checkboxInput("ft4", fuel_type.list[5], FALSE)
                     ),
                     column(1,
                            checkboxInput("ft5", fuel_type.list[6], FALSE)
                     ),
                     column(1,
                            checkboxInput("ft6", fuel_type.list[7], FALSE)
                     ),
                     column(1,
                            checkboxInput("ft7", fuel_type.list[8], FALSE)
                     ),
                     column(1,
                            checkboxInput("ft8", fuel_type.list[9], FALSE)
                     ),
                     column(1,
                            checkboxInput("ft9", fuel_type.list[10], FALSE)
                     ),
                     column(1,
                            checkboxInput("ft10", fuel_type.list[11], FALSE)
                     ),
                     column(1,
                            checkboxInput("ft11", fuel_type.list[12], FALSE)
                     ),
                     column(1,
                            checkboxInput("ft12", fuel_type.list[13], FALSE)
                     ),
                     column(1,
                            checkboxInput("ft13", fuel_type.list[14], FALSE)
                     ),
                     column(1,
                            checkboxInput("ft14", fuel_type.list[15], FALSE)
                     ),
                     column(1,
                            checkboxInput("ft15", fuel_type.list[16], FALSE)
                     ),
                     column(1,
                            checkboxInput("ft16", fuel_type.list[1], TRUE)
                     )
    
                  ),
                  
                  # Leaflet Map
                  fluidRow(
                    box(title = "World Map", solidHeader = TRUE, status = "primary", width = 12,
                        leafletOutput("map", height = 450)
                    )
                  )
              
                ),
                
                tabPanel("Data Table",
                   h2("Data by continent"),
                   
                   # Table
                   fluidRow(
                     box(title = "Table", solidHeader = TRUE, status = "primary", width = 12,
                         DT::dataTableOutput("table"),style = "height:550px; overflow-y: scroll;overflow-x: scroll;")
                   )
                )
                
              )
      )
    )
  )
)


server <- function(input, output) {
  # Filter by continent
  re.continent <- reactive(switch (input$continent,
                                   "North America" = df.north_america,
                                   "Africa"        = subset(df, continent==continent.list[1]),
                                   "Americas"      = subset(df, continent==continent.list[2]), # Contains North America
                                   "Antarctica"    = subset(df, continent==continent.list[3]),
                                   "Asia"          = subset(df, continent==continent.list[4]),
                                   "Europe"        = subset(df, continent==continent.list[5]),
                                   "Oceania"       = subset(df, continent==continent.list[7])
  ))
  
  cc1 <- renderText ({ifelse(input$ft1, fuel_type.list[2], "")})
  cc2 <- renderText ({ifelse(input$ft2, fuel_type.list[3], "")})
  cc3 <- renderText ({ifelse(input$ft3, fuel_type.list[4], "")})
  cc4 <- renderText ({ifelse(input$ft4, fuel_type.list[5], "")})
  cc5 <- renderText ({ifelse(input$ft5, fuel_type.list[6], "")})
  cc6 <- renderText ({ifelse(input$ft6, fuel_type.list[7], "")})
  cc7 <- renderText ({ifelse(input$ft7, fuel_type.list[8], "")})
  cc8 <- renderText ({ifelse(input$ft8, fuel_type.list[9], "")})
  cc9 <- renderText ({ifelse(input$ft9, fuel_type.list[10], "")})
  cc10 <- renderText({ifelse(input$ft10, fuel_type.list[11], "")})
  cc11 <- renderText({ifelse(input$ft11, fuel_type.list[12], "")})
  cc12 <- renderText({ifelse(input$ft12, fuel_type.list[13], "")})
  cc13 <- renderText({ifelse(input$ft13, fuel_type.list[14], "")})
  cc14 <- renderText({ifelse(input$ft14, fuel_type.list[15], "")})
  cc15 <- renderText({ifelse(input$ft15, fuel_type.list[16], "")})
  ft.list <- reactive(c(cc1(),cc2(),cc3(),cc4(),cc5(),cc6(),cc7(),cc8(),cc9(),cc10(),cc11(),cc12(),cc13(),cc14(),cc15()))

  output$t <- renderText(ft.list())
  
  # Filter by fuel type
  output$map <- renderLeaflet({
    map <- switch (input$continent,
                               "North America" = leaflet() %>% addTiles() %>% setView(lat = 42, lng = -110, zoom = 2),
                               "Africa"        = leaflet() %>% addTiles() %>% setView(lat = 10, lng =  10, zoom = 2),
                               "Americas"      = leaflet() %>% addTiles() %>% setView(lat = 9, lng = -87, zoom = 2),
                               "Antarctica"    = leaflet() %>% addTiles() %>% setView(lat = -75, lng = 18, zoom = 2),
                               "Asia"          = leaflet() %>% addTiles() %>% setView(lat = 25, lng = 94, zoom = 3),
                               "Europe"        = leaflet() %>% addTiles() %>% setView(lat = 40, lng = 48, zoom = 3),
                               "Oceania"       = leaflet() %>% addTiles() %>% setView(lat = -25, lng = 138, zoom = 3)
    )
    
    if (input$reset){map}
    
    # 'All'
    if (input$ft16==TRUE){
      ft.list <- fuel_type.list[2:16]
      for (i in 1:15){
        temp <- subset(re.continent(), primary_fuel==ft.list[i])
        temp1 <- subset(temp, capacity_mw>=input$min & capacity_mw<=input$max)
        map <- addCircleMarkers(map, lng = temp1$longitude, lat = temp1$latitude,
                                popup = paste(
                                  paste("Country: ", temp1$country_long, sep =''),
                                  paste("Plant: ", temp1$name, sep =''),
                                  paste("Generation Capacity (MW): ", temp1$capacity_mw, sep =''),
                                  paste("Fuel Type: ", temp1$primary_fuel, sep =''),
                                  sep="<br>"),
                                color = color_code[i], radius = (temp1$capacity_mw/max.min.range)*25, fill = FALSE)
      }
          }

    else{
      for (i in 1:15){
        if (ft.list()[i]!="") {
          temp <- subset(re.continent(), primary_fuel==ft.list()[i])
          temp1 <- subset(temp, capacity_mw>=input$min & capacity_mw<=input$max)
          map <- addCircleMarkers(map, lng = temp1$longitude, lat = temp1$latitude,
                                  popup = paste(
                                    paste("Country: ", temp1$country_long, sep =''),
                                    paste("Plant: ", temp1$name, sep =''),
                                    paste("Generation Capacity (MW): ", temp1$capacity_mw, sep =''),
                                    paste("Fuel Type: ", temp1$primary_fuel, sep =''),
                                    sep="<br>"),
                                  color = color_code[i], radius = (temp1$capacity_mw/max.min.range)*25, fill = FALSE)
        }
      }
    }
  
    map <- addLegend(map,"bottomright", colors = color_code[1:15], labels = fuel_type.list[2:16],
                     title = "Fuel Types",
                     opacity = 1)
    map
  })
  

  
  # Table
  output$table <- renderDataTable(
    re.continent()
  )
    
}

shinyApp(ui = ui, server = server)