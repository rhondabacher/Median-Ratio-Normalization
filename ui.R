library(shiny)
library(shinyFiles)

shinyUI(fluidPage(
  
  titlePanel("Median-Ratio Normalization:"),
  # Application title

      column(4,
		  fileInput("filename", label = "Data file input (support .csv, .txt, .tab)",
		  accept = c(
		            "text/csv",
		            "text/comma-separated-values,text/plain",
		            ".csv"))),

              
      column(4,

             tags$div(tags$b("Please select a folder for output:")),

             shinyDirButton('Outdir', label ='Select Output Folder', title = 'Please select a folder')),

   actionButton("Submit","Submit for processing"),

   
   mainPanel(
     (textOutput("Done normalizing data"))
	 )
 ))
