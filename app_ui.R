
library("shiny")
library("tidyverse")
library("plotly")
### LIBRARY ###


carbon <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")


us_data <- carbon %>%
  filter(year < 2018) %>%
  filter(year > 1997) %>%
  filter(iso_code != "") %>%
  select(
    year, country, co2_per_capita
  )

### Introduction Page
intro <- tabPanel(
  "Introduction",
  mainPanel(
    h2("Introduction"),
    p("In the 21st century, people's life is getting better and better,
        however, more and more green house gases like carbon dioxide are
        produced by human. Thus, this website disscusses the co2 emission per
        capita in the world change over time in recent two decades. "),
    p("Variable used: country with iso code,
        year from 1998-2017, and co2_per_captita"),
    p("There are seveal statistics calculated especially for the US:
        The average CO2 emssion per capita for the US in twenty years is 19.1478
        The medium CO2 emssion per capita for the US in twenty years is 19.927.
        The max CO2 emssion per capita for the US in twenty years is 21.289
        in year 2000.
        The min CO2 emssion per capita for the US in twenty years is 16.213
        in year 2017.
        The range of CO2 emssion per capita for the US in twenty years is 5.076.
        "),
    p("We can see that CO2 emission per capita for the US is lowest in
      year 2017 which indicates that the US is doing a better job at
      decreasing the emsion recently, despite the value is still high
      compare to other countries.
        ")
  )
)

### Visualization Page
graph <- tabPanel(
  "Visualization",
  sidebarLayout(
    sidebarPanel(
      p("You can choose the Country you want to look at"),
      selectInput(
        inputId = "country_id",
        label = h3("Country Selection"),
        choices = us_data$country,
        selected = 1
      ),
      hr(),
      fluidRow(column(10, verbatimTextOutput("value")))
    ),
    mainPanel(
      h2("Visualization"),
      plotlyOutput("graph_id"),
      p("The visualtion indicates CO2 emission per capita change over time for
        each country. The graph can show the trend for past two decades to tell
        whether the country is controling the emission. The table on the left
        side is the country's statistics on co2 emission. For develped counties
        such as the US and the UK, their emission of CO2 per capita is
        gradually decreasing, but for developing countries like China, their
        emission per capita is gradually increasing. Those mean the world is
        developing since high CO2 emission is associating with production and
        trade. Meanwhile, the developed counties are reducing their emission
        produced before. However, the emission of deveoped countries is still
        higher than the emission of developing countries"),
    )
  )
)

### Fluid Page
my_ui <- fluidPage(
  h1("Carbon Dioxide Website "),
  navbarPage(
    inverse = TRUE,
    "CO2 Emissions",
    intro,
    graph
  )
)
