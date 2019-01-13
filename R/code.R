 #' Title
#'
#' @details This are the details
#' @return
#' @export
#'
#' @examples
sample_function <- function() {
  print("Hello world")
}
library("xml2")
library("httr")
library("reticulate")
library("curl")
library("magrittr")
library("tidyr")
library("dplyr")

domains_df <<- data.frame(Domain = character(), Has_certificate = logical() , Organization = character(), Is_reliable = logical(), Resolves = logical())
non_domains_df <<- list()
reliable_organization <<- ""

domain_exists <- function(domain_to_check){
  tryCatch({
    print(paste("Checking if ", domain_to_check, " exists..." ,sep = ""))
    response <- GET(domain_to_check, timeout(5))
    return(TRUE)
  },
  error = function(err){
    print(err)
    return(FALSE)
  })
}

main <- function(domain){
  domains_df <<- data.frame(Domain = character(), Has_certificate = logical() , Organization = character(), Is_reliable = logical(), Resolves = logical())
  non_domains_df <<- list()
  reliable_organization <<- ""

  #Get reliable domain data (Organiation)
  if (!domain_exists(domain)) {
    stop()
  }
  # Get Organization from the certificate
  sslshopper_url <- paste("https://www.sslshopper.com/assets/snippets/sslshopper/ajax/ajax_check_ssl.php?hostname=", domain, "&g-recaptcha-response=&rand=190", sep = "")
  sslshopper_htmlpage <- GET(sslshopper_url, add_headers("X-Requested-With" = "XMLHttpRequest"))
  df <- get_organization_certificate_info(sslshopper_htmlpage, known_as_reliable = TRUE)
  reliable_organization <<- df$Organization

  #get similar domains list
  source_python("/home/test/Master/DDS/group-assignment-team-07/python_scripts/edit_domain.py")
  similar_domains <- edit_domain(domain)

  pool <- new_pool()
  cb <- function(req){
    print("Entered done function")
    domains_df <<- rbind(domains_df, get_organization_certificate_info(req$content,known_as_reliable = FALSE))
    print(domains_df)
  }

  # Getting data from every similar domain
  for (i in 1:length(similar_domains)) {
    if (domain_exists(similar_domains[i])) {
      curl_fetch_multi(paste("https://www.sslshopper.com/assets/snippets/sslshopper/ajax/ajax_check_ssl.php?hostname=", similar_domains[i], "&g-recaptcha-response=&rand=190", sep = ""),pool = pool, handle = new_handle() %>% handle_setheaders("X-Requested-With" = "XMLHttpRequest"), done = cb)
    } else {
      non_domains_df <<- c(non_domains_df, similar_domains[i])
      domains_df <<- data.frame(Domain = similar_domains[i], Has_certificate = FALSE , Organization = "None", Is_reliable = FALSE, Resolves = FALSE)
    }
  }
   out <- multi_run(pool = pool)
   out
}


## FUNCTION get_sslshopper certficate info -----------------------------------------------------

get_organization_certificate_info <- function(response, known_as_reliable){
  organization <- character(0)
  sslshopper_html <- read_html(response)

  resolve_text <- xml_text(xml_find_all(sslshopper_html, "//h3[contains(.,'resolves')]"))
  html_domain <- regmatches(resolve_text, gregexpr("^[a-zA-Z0-9][a-zA-Z0-9-]{1,61}[a-zA-Z0-9]\\.[a-zA-Z]{2,}",resolve_text))[[1]] # Desde cuan s'accedeix aixi a una llista?????????????????? WTF

  print(paste("Looking for ", html_domain," organization", sep = ""))

    #has certificate?
    has_certificate <- !identical(xml_text(xml_find_all(sslshopper_html, "//table[contains(@class, 'checker_certs')]")),character(0))
    if (has_certificate) {
      #Get cert info
      has_organization_field <- (xml_text(xml_find_all(sslshopper_html,"//table[2]/tr[1]/td[2]/b[3]")) == "Organization:")
      if (has_organization_field) {
        organization <- xml_text(xml_find_all(sslshopper_html,"//table[2]/tr[1]/td[2]/descendant::text()[6]"))
      }
    }
    if (identical(organization,character(0))){

      #don't have organization field -> get organization from https://www.ultratools.com/tools/ipWhoisLookupResult with ip
      resolve_text <- xml_text(xml_find_all(sslshopper_html, "//h3[contains(.,'resolves')]"))
      domain_ip <- regmatches(resolve_text, gregexpr("\\b\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\b",resolve_text))[1]
      ultratools_url <- "https://www.ultratools.com/tools/ipWhoisLookupResult"
      ultratools_htmlpage <- httr::POST(ultratools_url,add_headers("Content-Type" = "application/x-www-form-urlencoded"), body = paste("ipAddress=",domain_ip, sep = ""))
      ultratools_html <- read_html(ultratools_htmlpage)
      organization <- xml_text(xml_find_all(ultratools_html,"//div[contains(./span,'Org:')]/span[2]"))
      if (identical(organization,character(0))) {
        organization <- "None"
      }

    }

    result <- data.frame(Domain = html_domain, Has_certificate = has_certificate, Organization = organization, Is_reliable = ((gsub("\\s","",tolower(organization)) == gsub("\\s","",tolower(reliable_organization))) | known_as_reliable), Resolves = TRUE)
  return(result)
}

draw_pie <- function(df) {

  number_of_domanis = nrow(df)
  # Reliable domains, with a correct certificate and Organization == Reliable Organization
  reliable_domains <- (df %>% filter(Is_reliable == TRUE) %>% count())[[1]]
  print(reliable_domains)
  # Not Reliable domains with certificate of organization != Reliable organization
  not_reliable_certificate_domains <- (df %>% filter(Has_certificate == TRUE & Is_reliable == FALSE) %>% count())[[1]]
  print(not_reliable_certificate_domains)
  # Not Reliable domains wothout certificate that resolves

  not_reliable_without_certificate_domains <- (df %>% filter(Has_certificate == FALSE & Is_reliable == FALSE & Resolves == TRUE) %>% count())[[1]]
  print(not_reliable_without_certificate_domains)
  # Not resolving domains
  not_resolving_domains <- as.data.frame(df %>% filter(Resolves == FALSE) %>% count())[[1]]
  print(not_resolving_domains)

  y1_2 <- 1 - (not_resolving_domains/number_of_domanis)
  y1_1 <- (not_resolving_domains/number_of_domanis)
  y2_2 <- y1_2 - (not_reliable_without_certificate_domains/number_of_domanis)
  y2_1 <- y1_1 + (not_reliable_without_certificate_domains/number_of_domanis)
  y3_2 <- y2_2 - (not_reliable_certificate_domains/number_of_domanis)
  y3_1 <- y2_1 + (not_reliable_certificate_domains/number_of_domanis)
  y4_2 <- y3_2 - (reliable_domains/number_of_domanis)
  y4_1 <- y3_1 + (reliable_domains/number_of_domanis)


  plot_ly(df,labels = c("not_resolving_domains"), values = c(not_resolving_domains),
          showlegend = FALSE,
          name = "Continent Data0"
  ) %>%

    add_pie(hole = 0.6,
            textinfo = 'label',
            textposition = 'inside',
            insidetextfont = list(color = '#FFFFFF'),
            marker = list(line = list(color = '#FFFFFF', width = 1)),
            direction = 'clockwise',
            sort = FALSE,
            text = ~paste(c("not_resolving_domains"), c(not_resolving_domains)),
            hoverinfo = 'text + percent') %>%


    add_pie(df,labels = c("not_reliable_without_certificate_domains"), values = c(not_reliable_without_certificate_domains),
            textinfo = 'label',
            textposition = 'inside',
            direction = 'clockwise',
            sort = FALSE,
            name = "Continent Data1",
            marker = list(line = list(color = '#FFFFFF', width = 1)),
            domain = list(x = c(.2, 0.8), y = c(y1_1,y1_2))) %>%

    add_pie(df,labels = c("not_reliable_certificate_domains"), values = c(not_reliable_certificate_domains),
            textinfo = 'label',
            textposition = 'inside',
            direction = 'clockwise',
            sort = FALSE,
            name = "Continent Data1",
            marker = list(line = list(color = '#FFFFFF', width = 1)),
            domain = list(x = c(.2, 0.8), y = c(y2_1,y2_2))) %>%

    # add_pie(df,labels = c("Reliable domains"), values = c(1),
    #         textinfo = 'label',
    #         textposition = 'inside',
    #         direction = 'clockwise',
    #         sort = FALSE,
    #         name = "Continent Data1",
    #         marker = list(line = list(color = '#FFFFFF', width = 1)),
    #         domain = list(x = c(.2, 0.8), y = c(y3_1,y3_2))) %>%


    config(collaborate = FALSE, displaylogo = FALSE ) %>%

    layout(title = "Band Locations",
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           autosize = FALSE)

  # pie(x=c(1),labels=, radius=1 , col=c("#cc0000"), main = "Some main")
  #
  #
  # par(new=TRUE)
  # y1_2 <- 1-(not_resolving_domains/number_of_domanis)
  # y1_1 <- not_resolving_domains/number_of_domanis
  # pie(x=c(1),radius=(r1),
  #     col=c("#e59400"))
  #
  # y2_2 <- y1_2-(not_reliable_without_certificate_domains/number_of_domanis)
  # y2_1 <- y1_1 + (not_reliable_without_certificate_domains/number_of_domanis)
  # par(new=TRUE)
  # pie(x=c(1),radius=(r2),
  #     col=c("#e5e500"))
  #
  # y3_2 <- y2_2 - (not_reliable_certificate_domains/number_of_domanis)
  # y3_1 <- y2_1 + (not_reliable_certificate_domains/number_of_domanis)
  # par(new=TRUE)
  # pie(x=c(1),radius=(r3),
  #     col=c("#198c19"))
  #
  # legend(1, .4, c("DH"), cex = 1, fill = c("#198c19"))
}
