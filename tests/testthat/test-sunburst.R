test_that("sunburst works", {
  valid_data = data.frame(
    Label=c("E. coli","S. enterica", "L. monocytogenes", "Escherichia", "Salmonella", "Listeria"),
    Parent = c("Escherichia", "Salmonella", "Listeria",  "Bacteria", "Bacteria", "Bacteria"),
    Value = c(20, 10, 100,0, 0, 0)
  )

  invalid_data_two_without_parents = data.frame(
    Label=c("E. coli","S. enterica", "L. monocytogenes", "Escherichia", "Salmonella", "Listeria"),
    Parent = c("Escherichia", "Salmonella", "Listeria",  "Bacteria", "Bacteria", "ParentlessLabel2"),
    Value = c(20, 10, 100,0, 0, 0)
  )

  invalid_data_circular = data.frame(
    Label=c("E. coli","S. enterica", "L. monocytogenes", "Escherichia", "Salmonella", "Listeria", "Bacteria"),
    Parent = c("Escherichia", "Salmonella", "Listeria",  "Bacteria", "Bacteria", "Bacteria", "Escherichia"),
    Value = c(20, 10, 100,0, 0, 0, 0)
  )

  # Expect no error
  expect_error(sunburst(valid_data), NA)

  # Expect plotly htmlwidget class
  expect_s3_class(sunburst(valid_data), class = c("plotly", "htmlwidget"))

  #Expect error when more than one label is left parent-less. All lineages should meet at ONLY one point. not 2
  expect_error(sunburst(invalid_data_two_without_parents), "Bacteria,ParentlessLabel2")
  expect_error(sunburst(invalid_data_two_without_parents), "parent")

  #Expect circular error
  expect_error(sunburst(invalid_data_circular), "Circular")
})


test_that("lineage2sunburst", {
  lineages <- c(
    "Cancer Cohort>HM>BALL",
    "Cancer Cohort>HM>BALL",
    "Cancer Cohort>HM>BALL",
    "Cancer Cohort>HM>TALL",
    "Cancer Cohort>HM>AML",
    "Cancer Cohort>HM>AML>CBF",
    "Cancer Cohort>HM>AML>CBF"
  )

  lineages_comma <- c(
    "Cancer Cohort,HM,BALL",
    "Cancer Cohort,HM,BALL",
    "Cancer Cohort,HM,BALL",
    "Cancer Cohort,HM,TALL",
    "Cancer Cohort,HM,AML",
    "Cancer Cohort,HM,AML,CBF",
    "Cancer Cohort,HM,AML,CBF"
  )

  invalid_lineages_circular <- c(
    "Cancer Cohort>HM>BALL",
    "Cancer Cohort>HM>BALL",
    "Cancer Cohort>HM>BALL",
    "Cancer Cohort>HM>TALL",
    "Cancer Cohort>HM>AML",
    "Cancer Cohort>HM>AML>CBF",
    "Cancer Cohort>HM>AML>CBF",
    "Cancer Cohort>HM>AML>CBF>Cancer Cohort"
  )

  invalid_lineages_mutiple_ancestors <- c(
    "Cancer Cohort>HM>BALL",
    "Cancer Cohort>HM>BALL",
    "Cancer Cohort>HM>BALL",
    "Cancer Cohort>HM>TALL",
    "Cancer Cohort>HM>AML",
    "Cancer Cohort>HM>AML>CBF",
    "Cancer Cohort2>HM>AML>CBF"
    )

  # Expect no error
  expect_error(lineage2sunburst(lineages), NA)

  # Expect appropriate class
  expect_s3_class(lineage2sunburst(lineages), class = c("plotly", "htmlwidget"))
  expect_s3_class(lineage2sunburst(lineages, return_dataframe = TRUE), class = c("data.frame"))

  expect_s3_class(lineage2sunburst(lineages_comma, sep = ","), class = c("plotly", "htmlwidget"))

  # Expect cyclical error
  expect_error(lineage2sunburst(invalid_lineages_circular), "Circular")
  expect_error(lineage2sunburst(invalid_lineages_mutiple_ancestors), "Multiple Ancestors")


})
