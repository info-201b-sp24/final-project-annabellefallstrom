
first_tab_panel <- tabPanel("First graph",
                                    h1("add graph title"),
                                    
)


secont_tab_panel <- tabPanel("Second graph",
                             h1("TO DO: Add another graph here.")
)


third_tab_panel <- tabPanel("third graph",
                            h1("add graph title"),
                            
)

ui <- navbarPage("Add title",
                 first_tab_panel,
                 secont_tab_panel,
                 third_tab_panel
)