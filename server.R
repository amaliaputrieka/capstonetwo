server <- function(input,output){
    
    output$plot_1 <- renderPlotly({
        vids_favor <- vids %>% 
            filter(trending_date %in% input$datechosen) %>% 
            group_by(category_id) %>% 
            summarise(mean_likesratio = mean(like_ratio),
                      mean_dislikeratio = mean(dislike_ratio)) %>% 
            ungroup() %>% 
            mutate(favor=mean_likesratio/mean_dislikeratio) %>% 
            arrange(-favor)
        
        vids_favor <- vids_favor %>% 
            mutate(keterangan = paste(category_id,"\n Like Ratio:",round(mean_likesratio,3), "<br> Dislike Ratio:",round(mean_dislikeratio,3), "\n Favor:",round(favor,3)))
        
        plot_favor <- vids_favor %>% 
            ggplot(aes(x = mean_likesratio, y = mean_dislikeratio, text = keterangan)) +
            geom_point(aes(color = category_id, size = favor)) +
            theme_minimal() +
            theme(legend.position = "none",plot.title = element_text(hjust=0.5)) +
            scale_x_continuous(labels = scales::comma) +
            labs(title = "Like Ratio VS Dislike Ratio per category", x= "Like Ratio", y= "Mean Dislike Ratio", size= "", color= "")
        
        ggplotly(plot_favor,tooltip = "text") %>% 
            # displaymodebar opsi untuk menunjukkan tools bantuan di plotly
            config(displayModeBar = F)
    })

    output$plot_2 <- renderPlotly({
        comp1 <- vids %>% 
            filter(trending_date %in% input$datechosen2) %>% 
            group_by(category_id) %>% 
            summarise(freq = n(), Total.Views = sum(views)) %>% 
            mutate(ket1 = paste("Category: ",category_id,"\n Total Videos: ",freq,"\n Total Views: ", Total.Views))
        
        plot_comp1 <- comp1 %>% 
            ggplot(aes(y = freq, x = Total.Views, size= 40, text= ket1)) +
            geom_point(aes(fill = category_id)) +
            theme_minimal() +
            theme(legend.position = "none") +
            scale_x_continuous(labels = scales::comma) +
            labs(title = "Video Counts per Category VS Total Views", x= "Total Views", y= "Video Counts", size= "", color= "")
        
        ggplotly(plot_comp1, tooltip = "text") %>% 
        # layout() mengatur ukuran dan posisi plotly
        # disini saya menentukan besar plot dengan heigt dan width
        # legend = orientation "h" mengubah posisi legend menjadi horizontal
        # posisi legend pada plotly tidak bisa diatur langsung dengan "bottom" seperti ggplot
        # sehingga kita harus memposiiskan manual dengan kordinat x dan y
         #  layout(height = 360,width = 450,
          #        legend = list(orientation = "h", x = 0.20, y = -0.2)) %>% 
            # displaymodebar opsi untuk menunjukkan tools bantuan di plotly
            config(displayModeBar = F)
    })
    
    output$plot_3 <- renderPlotly({

        pdc <- vids %>% 
            group_by(publish_wday, category_id) %>% 
            summarise(views = sum(views)) %>% 
            arrange(-views) %>% 
            mutate(ket2 = paste("Category: ",category_id,"\n Total Views: ",views,"\n Publish Day: ", publish_wday))
        
        pdc1 <- pdc %>% 
            filter(category_id %in% input$category_id)
        
        plot_pdc1 <- pdc1 %>% 
            ggplot(aes(y = publish_wday, x = views, text = ket2)) +
            geom_col(aes(fill = publish_wday)) +
            theme_minimal() +
            theme(legend.position = "none") +
            scale_x_continuous(labels = scales::comma) +
            labs(title = "Prime Time (Day)", x= "Total Views", y= "", size= "", color= "")
        
       ggplotly(plot_pdc1, tooltip = "text") %>% 
           config(displayModeBar = F)

    })
    
    output$plot_4 <- renderPlotly({
        ptc <- vids %>% 
            group_by(publish_when, category_id) %>% 
            summarise(views = sum(views)) %>% 
            arrange(-views) %>% 
            mutate(ket3 = paste("Category: ",category_id,"\n Total Views: ",views,"\n Publish Day: ", publish_wday))
        
        ptc1 <- ptc %>% 
            filter(category_id %in% input$category_id2)
        
        plot_ptc1 <- ptc1 %>% 
            ggplot(aes(y = publish_when, x = views, text = ket3)) +
            geom_col(aes(fill = publish_when)) +
            theme_minimal() +
            theme(legend.position = "none") +
            scale_x_continuous(labels = scales::comma) +
            labs(title = "Prime Time (Hour)", x= "Total Views", y= "", size= "", color= "", pos)
        
       ggplotly(plot_ptc1, tooltip = "text")  %>% 
           config(displayModeBar = F)
    })
    
    output$TVC <- renderValueBox({
    
    TVC <- vids %>% 
        group_by(channel_title) %>% 
        summarise(TotalViewsChannel= sum(views)) %>% 
        arrange(-TotalViewsChannel) %>% 
        head(1)
        
        valueBox(
            value = tags$p(TVC$channel_title, style = "font-size: 60%;"),
            subtitle = tags$p("Popular Channel", style = "font-size: 100%;"),
            icon = icon("star"),
            color = "olive"
        )
    })
    
    output$TVCt <- renderValueBox({
        
        TVCt <- vids %>% 
            group_by(category_id) %>% 
            summarise(TotalViewsCategory= sum(views)) %>% 
            arrange(-TotalViewsCategory) %>% 
            head(1)
        
        valueBox(
            value = tags$p(TVCt$category_id, style = "font-size: 60%;"),
            subtitle = tags$p("Popular Category", style = "font-size: 100%;"),
            icon = icon("star"),
            color = "fuchsia"
        )
    })
    
    output$TVT <- renderValueBox({
        
        TVT <- vids %>% 
            group_by(title) %>% 
            summarise(TotalViewsTitle= sum(views)) %>% 
            arrange(-TotalViewsTitle) %>% 
            head(1)
        
        valueBox(
            value = tags$p(substr(TVT$title,1,14), style = "font-size: 60%;"),
            subtitle = tags$p("Popular Video", style = "font-size: 100%;"),
            icon = icon("star"),
            color = "yellow"
        )
    })
    
    output$plot_5 <- renderPlotly({
    cbyd <- vids %>% 
        group_by(publish_wday, category_id) %>% 
        summarise(views = sum(views)) %>% 
        arrange(-views) %>% 
        mutate(ket4 = paste("Category: ",category_id,"\n Total Views: ",views,"\n Publish Day: ", publish_wday))
    
    cbyd1 <- cbyd %>% 
        filter(publish_wday %in% input$day)
    
    plot_cbyd1 <- cbyd1 %>% 
        ggplot(aes(y = category_id, x = views, text = ket4)) +
        geom_col(aes(fill = category_id)) +
        theme_minimal() +
        theme(legend.position = "none") +
        scale_x_continuous(labels = scales::comma) +
        labs(title = "Category Total Views by Day", x= "Total Views", y= "", size= "", color= "")
    
    ggplotly(plot_cbyd1, tooltip = "text") %>% 
        config(displayModeBar = F)
    })
    
    output$plot_6 <- renderPlotly({
    cbyt <- vids %>% 
        group_by(publish_when, category_id) %>% 
        summarise(views = sum(views)) %>% 
        arrange(-views) %>% 
        mutate(ket5 = paste("Category: ",category_id,"\n Total Views: ",views,"\n Publish Day: ", publish_wday))
    
    cbyt1 <- cbyt %>% 
        filter(publish_when %in% input$when)
    
    plot_cbyt1 <- cbyt1 %>% 
        ggplot(aes(y = category_id, x = views, text = ket5)) +
        geom_col(aes(fill = category_id)) +
        theme_minimal() +
        theme(legend.position = "none") +
        scale_x_continuous(labels = scales::comma) +
        labs(title = "Category Total Views by Time", x= "Total Views", y= "", size= "", color= "")
    
    ggplotly(plot_cbyt1, tooltip = "text") %>% 
        config(displayModeBar = F)
    })
    
    
}