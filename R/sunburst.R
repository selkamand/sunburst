#
# lineage2inheritancedf <- function(lineage){
#   assertthat::assert_that(!any(is.na(lineage)), msg = utilitybeltfmt::fmterror("Lineage output should never be be NA"))
#
#   unique_lineage = unique(lineage)
#
#   unique_lineage_list = strsplit(unique_lineage, split=">")
#
#   #Name each element with its parent (or NA if it doesnt have a parent)
#   unique_lineage_list <- lapply(unique_lineage_list, function(x){ names(x) <- c(NA_character_, head(x,n=-1)); return(x)})
#   unique_lineage_vec = unlist(unique_lineage_list)
#
#   inheritance_df <- dplyr::tibble(
#     Label= unique_lineage_vec,
#     Parent = names(unique_lineage_vec)
#   )
#
#
#   inheritance_df <- dplyr::filter(inheritance_df, !is.na(Parent))
#   return(inheritance_df)
# }




#' Lineage 2 sunburst
#'
#' Takes lineage strings e.g. 'Bacteria>Escherichia>Escherichia coli' and generates a sunburst plot.
#' Size of each segment in sunburst is based on lineage frequency.
#'
#' @param lineage e.g. 'Bacteria>Escherichia>Escherichia coli' (character). Can generate for microbes using [taxizedbextra] package
#' @param sep what character separates each parent-child in lineage strings (string)
#'
#' @return sunburst plot (plotly) or inheritance + count dataframe if return_dataframe is TRUE
#' @export
#'
#' @examples
#' \dontrun{
#' taxids = c(rep(562, each =  50), rep(28901, times = 20))
#'
#'  #Convert NCBI taxids to lineage strings
#'  lineage_strings = taxizedbextra::taxid2lineage(taxids)
#'  lineage2sunburst(lineage_strings, sep = ">")
#'
#' }
lineage2sunburst <- function(lineage, sep = ">", return_dataframe = FALSE){

  assertthat::assert_that(!any(is.na(lineage)), msg = utilitybeltfmt::fmterror("Lineage output should never be be NA"))

  lineage_table = table(lineage)
  unique_lineage = names(lineage_table)
  lineage_count = as.vector(lineage_table)
  unique_lineage_list = strsplit(unique_lineage, split=">")

  unique_lineage_list <- lapply(unique_lineage_list, function(x){ names(x) <- c(NA_character_, head(x,n=-1)); return(x)})
  unique_lineage_vec = unlist(unique_lineage_list)


  final_links = sapply(X = unique_lineage_list, function(x) {
    final_hit = tail(x, n=1)
    paste0(names(final_hit), ">", final_hit)
    })

  counts_df = dplyr::tibble(final_links = final_links, Value = lineage_count)

  inheritance_df <- dplyr::tibble(
    Label= unique_lineage_vec,
    Parent = names(unique_lineage_vec)
  )

  inheritance_df <- dplyr::filter(inheritance_df, !is.na(Parent))
  inheritance_df <- dplyr::mutate(
    .data = inheritance_df,
    Key = paste0(Parent,">", Label)
  )

  inheritance_df <- dplyr::distinct(inheritance_df)

  full_inheritance_df <- dplyr::left_join(
    x = inheritance_df,
    y = counts_df,
    by = list(x = "Key", y = "final_links"))

  full_inheritance_df <- dplyr::mutate(
    .data = full_inheritance_df,
    Value = ifelse(is.na(Value), 0, Value)
    )

  if(return_dataframe){
    return(full_inheritance_df)
  }
  else
    return(sunburst(full_inheritance_df))
}


#' Sunburst Plot
#'
#' @param data data.frame with three columns: Label, Parent and Value. See details for more information
#' @return plotly figure
#' @export
#'
#' @examples
#' data = data.frame(
#'   Label=c("E. coli","S. enterica", "L. monocytogenes", "Escherichia", "Salmonella", "Listeria"),
#'   Parent = c("Escherichia", "Salmonella", "Listeria",  "Bacteria", "Bacteria", "Bacteria"),
#'   Value = c(20, 10, 100,0, 0, 0)
#' )
#' sunburst(data)
#'
#' @details
#' | **Column** | **Description** | **Type** |
#' | --- | --- | --- |
#' | **Label** | All the terms to be represented in the sunburst plot | character
#' | **Parent** | Parent of Label | character
#' | **Value** | Value - will determine size of segment in plot | numeric
#'
sunburst <- function(data){
  required_columns <- c("Label", "Parent", "Value")
  assertthat::assert_that(is.data.frame(data))
  assertthat::assert_that(all(required_columns %in% colnames(data)),
    msg = utilitybeltfmt::fmterror("Missing required column/s: ",
    paste0(required_columns[! required_columns %in% colnames(data)], collapse = ", "))
  )

  fig = plotly::plot_ly(
    labels = data$Label,
    parents = data$Parent,
    values = data$Value,
    type = "sunburst"
    )
  return(fig)
}
data = data.frame(
  Label=c("E. coli","S. enterica", "L. monocytogenes", "Escherichia", "Salmonella", "Listeria"),
  Parent = c("Escherichia", "Salmonella", "Listeria",  "Bacteria", "Bacteria", "Bacteria"),
  Value = c(20, 10, 100,0, 0, 0)
)

#
# microbial_sunburst <- function(taxids, counts){
#
#   # Assertions
#   assertthat::assert_that(is.numeric(taxids))
#   assertthat::assert_that(is.numeric(counts))
#   assertthat::assert_that(all(!is.na(taxids)), msg = utilitybeltfmt::fmterror("microbialsunburst::microbial_sunburst\n\ntaxids argument includes NA. This function expects no NA's in input. If NAs represent an inability to classify sequences to a taxid, replace it with -1. Its lineage will then return 'unclassified'"))
#   assertthat::assert_that(length(taxids) == length(counts), msg = utilitybeltfmt::fmterror("taxids and counts are unequal lengths. \ntaxids [n=",length(taxids),"]", "\ncounts [n=",length(counts),"]"))
#
#   # Get Lineage
#   utilitybeltfmt::message_info("Getting taxid lineages")
#   lineage = taxid2lineage(taxids = taxids)
#
#   utilitybeltfmt::message_info("Constructing sunburst precurser dataframe")
#   sunburst_df <- dplyr::tibble(
#     taxids = taxids,
#     counts = counts,
#     scinames = taxid2name(taxids),
#     lineage = lineage
#     )
#   return(sunburst_df)
#   #browser()
# }
