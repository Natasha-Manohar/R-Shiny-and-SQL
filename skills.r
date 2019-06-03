#Skills
tabItem(tabName = "SkillsCreate",
        h2("New Skills"),
        fluidRow(
          tabBox(
            title = "Skills Information",
            id = "tabset2", height = "250px",
            
            tabPanel("General",
                     textInput("skillId", "Enter Skill Id"),
                     textInput("skillName", "Enter Skill Name")
          )
        ),
        actionButton(
          inputId = "SkillCreateSubmit", 
          label = "Create entry", 
          style="color: black; background-color: coral"
        ))
)

tabItem(tabName = "skillUpdate",
        h2("Skill Candidate"),
        fluidRow(
          tabBox(
            title = "Skill Record",
            id = "tabset3", height = "250px",
            uiOutput(outputId = "skillId"),
            textInput("Skill ID", "Skill Name")
          ),
          tabBox(
            title = "Skill Information",
            id = "tabset4", height = "250px",
            
            tabPanel("General",
                     textInput("skillId", "Enter skill ID"),
                     textInput("skillName", "Enter skill Name")
        ),
        actionButton(
          inputId = "skillId", 
          label = "Create entry", 
          style="color: black; background-color: coral"
        )))
)

tabItem(tabName = "skillDelete",
        h2("Delete a skill"),
        fluidRow(
          tabBox(
            title = "Skill Record",
            id = "tabset5", height = "250px",
            selectInput(
              inputId = "skillIdDeleteKey",
              label = "Select skill to Delete",
              
          tabBox(
            title = "Skill Information",
            id = "tabset6", height = "250px",
            
            tabPanel("General",
                     textInput("skillId", "Enter skill ID"),
                     textInput("skillName", "Enter skill Name")
            )
          ))
        ),
        actionButton(
          inputId = "SkillDeleteSubmit", 
          label = "Delete entry", 
          style="color: black; background-color: coral"
        )
))


observeEvent(input$SkillCreateSubmit, {
    df <- data.frame(
    id = input$skillId,
    name = input$skillName,
    stringsAsFactors = FALSE)
  print(df)
  sql <- "INSERT INTO ?table VALUES(?skillId,
  ?id,
  ?name,
);"
    
  query <- sqlInterpolate(pool, sql, .dots = c(
    list(table = "Skills"), 
    as_list(df)
  ))
  print(query)
  dbExecute(pool, query)
  tbl <- data.frame(pool %>% tbl("Skills" ))
  updateSelectInput(session, "Skill ID", choices = tbl$skillId )
  updateSelectInput(session, "Skill Name", choices = tbl$skilllName)
})


observeEvent(input$skillId, {
  req(input$skillId, !is.na(input$skillId))
  df = data.frame(pool %>% tbl("Skiils") )
  row = which(df$skillId == input$skillId)
  updateTextInput(session, "Skill ID", value = df[,"skillId"][row])
  updateTextInput(session, "Skill Name", value = df[,"skillName"][row])
})


observeEvent(input$SkillsUpdateSubmit, {
  df <- data.frame(
    Id = input$skillsUpdateId,
    Name = input$skillsUpdateName
   )
  
  sql <- "UPDATE ?table SET
  Id = ?Id,
  Name = ?Name,
  WHERE skillId = ?skillId;"
  
  query <- sqlInterpolate(pool, sql, .dots = c(
    list(table = "Skills"), 
    as_list(df),
    list(skillId = input$skillId)
  ))
  print(query)
  dbExecute(pool, query)
})


observeEvent(input$skillIDDeleteKey, {
  req(input$skillIdDeleteKey, !is.na(input$skillIdDeleteKey))
  df = data.frame(pool %>% tbl("Skills") )
  row = which(df$skillId == input$skillIdDeleteKey)
  updateTextInput(session, "skillId", value = df[,"skillId"][row])
  updateTextInput(session, "skillName", value = df[,"skillName"][row])
})

observeEvent(input$SkillDeleteSubmit, {
  
  sql <- "DELETE FROM ?table WHERE skillId = ?skill;"
  
  query <- sqlInterpolate(pool, sql, .dots = c(
    list(table = "Skill"), 
    list(candidateEmail = input$skillIdDeleteKey)
  ))
  dbExecute(pool, query)
  tbl <- data.frame(pool %>% tbl("Skill" ))
  updateSelectInput(session, "skillId", choices = tbl$skillId )
  updateSelectInput(session, "skillIdDeleteKey", choices = tbl$skillId )
})