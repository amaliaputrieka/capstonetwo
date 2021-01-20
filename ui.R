ui <- dashboardPage(
    # Dashboard Page Setup ----------------------------------------------------
    
    dashboardHeader(title = "CDS"),
    dashboardSidebar(
        sidebarMenu(
            menuItem(text = "Overview",tabName = "tab_overview",icon = icon("map")),
            menuItem(text = "Information",tabName = "tab_information",icon = icon("list")),
            menuItem(text = "About",tabName = "tab_about",icon = icon("book"))
        )
    ),
    dashboardBody(
        tags$head(tags$style(HTML('
                                /* logo */
                                .skin-blue .main-header .logo {
                                background-color: #f4b943;
                                }

                                /* logo when hovered */
                                .skin-blue .main-header .logo:hover {
                                background-color: #f4b943;
                                }

                                /* navbar (rest of the header) */
                                .skin-blue .main-header .navbar {
                                background-color: #f4b943;
                                }        

                                /* main sidebar */
                                .skin-blue .main-sidebar {
                                background-color: #f4b943;
                                }

                                /* active selected tab in the sidebarmenu */
                                .skin-blue .main-sidebar .sidebar .sidebar-menu .active a{
                                background-color: #ff0000;
                                }

                                /* other links in the sidebarmenu */
                                .skin-blue .main-sidebar .sidebar .sidebar-menu a{
                                background-color: #00ff00;
                                color: #000000;
                                }

                                /* other links in the sidebarmenu when hovered */
                                .skin-blue .main-sidebar .sidebar .sidebar-menu a:hover{
                                background-color: #ff69b4;
                                }
                                /* toggle button when hovered  */                    
                                .skin-blue .main-header .navbar .sidebar-toggle:hover{
                                background-color: #ff69b4;
                                }
                                .box.box-solid.box-primary>.box-header {
  color:#fff;
  background:#666666
                    }

.box.box-solid.box-primary{
border-bottom-color:#666666;
border-left-color:#666666;
border-right-color:#666666;
border-top-color:#666666;
}
                                
                                '))),
       # tags$head(
        #    tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
       # ),
    
        tabItems(
            # Tab Overview
            tabItem(
                tags$head(
                    tags$style(HTML("
      @import url('//fonts.googleapis.com/css?family=Potta One|Cabin:400,700');
      
      h4 {
        font-family: 'Potta One', cursive;
        font-weight: 500;
        line-height: 1.1;
        color: #48ca3b;
      }

    "))
                ),
                               tabName = "tab_overview", 
                    fluidPage(
                        fluidRow(
                            align= "center",
                            # Dynamic valueBoxes
                            valueBoxOutput("TVC"),
                            
                            valueBoxOutput("TVCt"),
                            
                            valueBoxOutput("TVT")
                        ),
                        tags$br(),
                        fluidRow(
                            # Dibuat beberapa column agar teks bisa berada ditengah dan tidak memanjang sampai ujung body
                            column(width = 1),
                            column(width = 10,
                                   # align = "center" untuk membuat posisi teks center
                                   tags$h2("Let us help you to develop your first Content!",align="center"),
                                   tags$h4("Having watched videos on youtube, you might wondering to make one! But what kind of videos you should develop? Let's check what insight you could gain from us!" ,align="center")),
                            column(width = 2)
                        ),
                        tags$br(),
                        tags$br(),
                        fluidRow(
                            # Dibuat beberapa column agar teks bisa berada ditengah dan tidak memanjang sampai ujung body
                            column(width = 1),
                            column(width = 10,
                                   tags$h4("Curious about what makes a category become more popular compare to another one? Did the video counts affect the popularity?" ,align="center")),
                            column(width = 2)
                        ),
                        fluidRow(
                            # perhatikan div(). semua objek yang ada didalam div() akan mendapat pengaturan yang sama
                            # disini div() mengatur semua objek dengan align = "center". karena itu judul dan teks semua ada di tengah
                            tags$div(align="center",
                                     box(width = 12, style = "background-color:#4d3a7d;",title = "Video Counts to Total Views",solidHeader = T,status = "warning",
                                         (dateRangeInput(inputId = "datechosen2", label = "Period:",   start = "2017-11-14", end = "2017-11-30", min = NULL, max = NULL, format = "yyyy-mm-dd", startview = "month", weekstart = 0, language = "en", separator = " to ", width = NULL, autoclose = TRUE)),
                                         plotlyOutput(outputId = "plot_2"))
                            )
                        ),
                        tags$br(),
                        fluidRow(
                            # Dibuat beberapa column agar teks bisa berada ditengah dan tidak memanjang sampai ujung body
                            column(width = 1),
                            column(width = 10,
                                   tags$h4("How about the ratio of like and dislike of each video category?" ,align="center")),
                            column(width = 2)
                        ),
                        fluidRow(
                            # perhatikan div(). semua objek yang ada didalam div() akan mendapat pengaturan yang sama
                            # disini div() mengatur semua objek dengan align = "center". karena itu judul dan teks semua ada di tengah
                            tags$div(align="center",
                                     box(width = 12,title = "Like VS Dislike Ratio",solidHeader = T,status = "primary",
                                         (dateRangeInput(inputId = "datechosen", label = "Period:",   start = "2017-11-14", end = "2017-11-30", min = NULL, max = NULL, format = "yyyy-mm-dd", startview = "month", weekstart = 0, language = "en", separator = " to ", width = NULL, autoclose = TRUE)),
                                         plotlyOutput(outputId = "plot_1"))
                            )
                        )
                        # br() untuk menambah break line 
                       
                    )
            ),
            # Tab Information
            tabItem(tabName = "tab_information",
                    fluidPage(
                        tags$br(),
                        fluidRow(
                            # Dibuat beberapa column agar teks bisa berada ditengah dan tidak memanjang sampai ujung body
                            column(width = 1),
                            column(width = 10,
                                   tags$h4("Find the right time to post a video!" ,align="center")),
                            column(width = 2)
                        ),
                        fluidRow(
                            tabBox(
                                title = "Prime time to post a video category",
                                id = "tabset1", height = "550px",width = "400px",
                                         tabPanel("Day",(selectInput(inputId = "category_id",label = "Select Category:",choices = c(levels(vids$category_id)),selected = "All Category")),
                                         plotlyOutput(outputId = "plot_3")),
                                         tabPanel("Hour",(selectInput(inputId = "category_id2",label = "Select Category:",choices = c(levels(vids$category_id)),selected = "All Category")),
                                         plotlyOutput("plot_4")))),
                        tags$br(),
                        verticalLayout(
                            tabBox(
                                title = "The most popular category at this time",
                                id = "tabset2", height = "250px",width = "400px",
                                tabPanel("Day",(radioButtons(inputId = "day", label = "Select Day", choices = c(levels(vids$publish_wday)), selected = "Monday", inline = T)),
                                         plotlyOutput(outputId = "plot_5")),
                                tabPanel("Hour",(radioButtons(inputId = "when", label = "Select When", choices = c(levels(vids$publish_when)), selected = "8am to 3pm", inline = T)),
                                         plotlyOutput("plot_6"))))
                            )
                        ),
            tabItem(tabName = "tab_about",
                    fluidPage(
                        fluidRow(
                            # Dibuat beberapa column agar teks bisa berada ditengah dan tidak memanjang sampai ujung body
                            column(width = 1),
                            column(width = 10,
                                   # align = "center" untuk membuat posisi teks center
                                   tags$h1("Content Development Support (CDS)",align="center"),
                                   tags$br(),
                                   tags$h2("We are growing based on society needs. Our intention to help you develop your content leads us to moving forward.", align="center"),
                                   tags$br(),
                                   tags$h4("Should you need further support, please kindly contact us anytime through: " ,align="center"),
                                   tags$h4("Phone: +6282XXXXX09XX: " ,align="center"),
                                   tags$h4("Email: test@xxxxx.com: " ,align="center")),
                            column(width = 2)
                            # radioButtons(inputId, label, choices, selected, inline)
                        )
            
                    )
            )
        )
    )
)