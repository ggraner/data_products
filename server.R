#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    mtcars$liter100km <- 235/mtcars$mpg
    mtcars$wtinkg <- (mtcars$wt*1000)*0.4535
    
    mtcars$mpgsp <- ifelse(mtcars$liter100km - 10 >0, mtcars$liter100km - 10,0)
    # create model 1
    model1 <- lm(wtinkg ~ liter100km, data=mtcars)
    # create model 2
    model2 <- lm(wtinkg ~ mpgsp, data=mtcars)
    
    # predict model 1
    model1pred <- reactive({
            mpgInput <- input$sliderCars
            predict(model1, newdata=data.frame(liter100km=mpgInput))
    })
    # predict model 2
    model2pred <- reactive({
            mpgInput <- input$sliderCars
            predict(model2, newdata=data.frame(liter100km=mpgInput, 
                                               mpgsp=ifelse(mpgInput-10>0,mpgInput-10,0)))
    })
    output$Plot1 <- renderPlot({
            mpgInput <- input$sliderCars
            
            plot(mtcars$liter100km, mtcars$wtinkg, xlab="Liter per 100 km",
                 ylab="Weight (in kilogram)", bty="n", pch=16,
                 xlim=c(5,25),ylim=c(500,2600))
            if(input$showModel1){
                    abline(model1, col="green", lwd=2)
            }
            if(input$showModel2){
                    model2lines <- predict(model2, newdata=data.frame(
                            liter100km=5:25, mpgsp=ifelse(5:25 - 10 >0, 5:25 -10,0)
                    ))
                    lines(5:25, model2lines, col="blue", lwd=2)
            }
            
            legend(25,250,c("Model 1 Prediction", "Model 2 Prediction"),
                   pch=16, col=c("green","blue"), bty="n", cex=1.2)
            points(mpgInput, model1pred(),col="green", pch=16, cex=2)
            points(mpgInput, model2pred(),col="blue", pch=16, cex=2)
            
    })
    output$pred1 <- renderText({
           model1pred()
    })
    output$pred2 <- renderText({
            model2pred()
    })

})
