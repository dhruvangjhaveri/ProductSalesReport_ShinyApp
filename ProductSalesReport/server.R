library(shiny)
library(dplyr)
sales<- readRDS("./data/salesdata.rds")

shinyServer(function(input, output) {
  bydate <- eventReactive(input$showbutton,{
    sequence <- seq(as.Date(paste(input$id2,input$id1,"01",sep = "/")), as.Date(paste(input$id4,input$id3,"01",sep = "/")), by="month")
    sales2  <- filter(sales, date %in% sequence) %>% group_by(group, item) %>% summarise(quantity=sum(quantity), weight = sum(weight), value= sum(value))
    sales2
  })
  
  percentcal <- reactive({sales2 <- bydate()
  sales3 <- group_by(sales2, group) %>% summarise(weight=sum(weight), value= sum(value))
  sales2 <- merge(sales2,sales3, by= "group", all.x = T)
  sales2 <- data.frame(group=sales2$group, item=sales2$item, quantity=sales2$quantity, 
                       weight = sales2$weight.x, value= sales2$value.x,
                       gpercentweight= round((sales2$weight.x/sales2$weight.y)*100,2),
                       gpercentvalue= round((sales2$value.x/sales2$value.y)*100,2)) 
  sales2$tpercentweight <- round((sales2$weight/sum(sales2$weight))*100,2)
  sales2$tpercentvalue <- round((sales2$value/sum(sales2$value))*100,2)
  sales2})
  
  selectgroup <- reactive({ sales2 <- percentcal()
  sales2 <- filter(sales2, group %in% input$group)
  sales2
  })
  
  
  final <-reactive(DT::datatable(selectgroup(),rownames = F,options = list(lengthMenu=c(5,20,50)),
                  colnames = c("Group","Product","Quantity(Pcs)","Weight(Kgs)",
                               "Value(Rs)","Weight(% of Group)",
                               "Value(% of Group)", "Weight(% of Total)",
                               "Value(% of Total)")))
  output$mytable <- DT::renderDataTable(final())
}
)
