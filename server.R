options(shiny.maxRequestSize=3000*1024^2) 
 
shinyServer(function(input, output, session) {
  
	volumes <- c('home'="~")
    shinyDirChoose(input, 'Outdir', roots=volumes, session=session, restrictions=system.file(package='base'))
    output$Dir <- renderPrint({parseDirPath(volumes, input$Outdir)})



	 
    In <- observeEvent(input$Submit, {
		
	    # print(input$Outdir)
	    outdir <- paste0("~", do.call("file.path", input$Outdir[[1]]), "/")
	    # print(outdir)
		
	  the.file <- input$filename
	  # print(the.file$name)
	  
      if(is.null(the.file))stop("Please upload data")
      Sep=strsplit(the.file$name,split=".", fixed=T)[[1]]
	  # print(Sep)
	  
      if(Sep[length(Sep)]=="csv")a1=read.csv(input$filename$datapath,stringsAsFactors=F,header=TRUE, row.names=1,comment.char="")
      if(Sep[length(Sep)]!="csv") {
        try((a1=read.table(input$filename$datapath,stringsAsFactors=F,header=TRUE, row.names=1,comment.char="")), silent=T)
  	  if(!exists("a1")) {
  		  print("Initial data import failed, file format may be incorrect. Trying alternate data import...")
          a0=read.table(input$filename$datapath,stringsAsFactors=F,header=TRUE, row.names=NULL,comment.char="")
          a1 <- data.matrix(a0[-1])
          rownames(a1) <- a0[[1]]
        }
      }

	
	Data=data.matrix(a1)
	
	geomeans <- exp(rowMeans(log(Data)))
	Sizes <- apply(Data, 2, function(cnts) median((cnts/geomeans)[geomeans > 
	            0]))
	Out = NULL
   if (length(Sizes) != length(Data) & length(Sizes) != ncol(Data)) 
       stop("The number of library size factors is not the same as the number of samples!")
   if (length(Sizes) == length(Data)) 
       Out = Data/Sizes
   if (length(Sizes) == ncol(Data)) 
       Out = t(t(Data)/Sizes)

  
   write.csv(Out, file=paste0(outdir,strsplit(the.file$name,split=".", fixed=T)[[1]][1],"_Normalized.csv"), quote=F) #write input 

   print("Done Normalizing Data!")
   ARG = 1
   
   if(ARG==1){
   	 stopApp(returnValue = invisible())
   }
	})
	
    
})
  
    # Act <- eventReactive(input$Submit,{
 #      In()})
#  if(input$myBtn > 0){
#          stopApp(7)
#  stopApp(returnValue = invisible())
# })