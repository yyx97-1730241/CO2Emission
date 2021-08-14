
library("shiny")
library("tidyverse")
library("plotly")

### A country, 10 years, trade, consumption, production

my_server <- function(input, output) {

  ### create plot ###
  output$graph_id <- renderPlotly({
    new_us_data <- us_data %>%
      filter(country == input$country_id)


    plot_ly(
      data = new_us_data,
      x = ~year,
      y = ~co2_per_capita,
      type = "scatter",
      mode = "lines"
    ) %>%
      layout(
        title = "CO2 Emission Per Capita Change between 1998-2017",
        xaxis = list(title = "Year"),
        yaxis = list(title = "CO2 Emission in Million tonnes")
      )
  })
  output$value <- renderText({
    new_data <- us_data %>%
      filter(country == input$country_id)


    highest <- new_data %>%
      filter(co2_per_capita == max(co2_per_capita)) %>%
      pull(co2_per_capita)
    highest <- highest[1]


    lowest <- new_data %>%
      filter(co2_per_capita == min(co2_per_capita)) %>%
      pull(co2_per_capita)
    lowest <- lowest[1]

    average <- new_data %>%
      summarise(mean = mean(co2_per_capita), na.rm = TRUE) %>%
      pull(mean)

    med <- new_data %>%
      summarise(med = median(co2_per_capita), na.rm = TRUE) %>%
      pull(med)

    range <- highest - lowest

    paste("Country Name: ", input$country_id, " ", "Mean: ", average,
      "Medium: ", med,
      "Highest: ", highest, "Lowest: ", lowest, "Range: ", range,
      sep = "\n"
    )
  })
}
