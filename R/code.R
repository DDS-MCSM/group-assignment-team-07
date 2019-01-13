if (!require(xml2)) (install.packages("xml2"))
library("xml2")
if (!require(httr)) (install.packages("httr"))
library("httr")
if (!require(reticulate)) (install.packages("reticulate"))
library("reticulate")
if (!require(curl)) (install.packages("curl"))
library("curl")
if (!require(magrittr)) (install.packages("magrittr"))
library("magrittr")
if (!require(tidyr)) (install.packages("tidyr"))
library("tidyr")
if (!require(dplyr)) (install.packages("dplyr"))
library("dplyr")

domains_df <<- data.frame(Domain = character(), Has_certificate = logical() , Organization = character(), Is_reliable = logical(), Resolves = logical())
non_domains_df <<- list()
reliable_organization <<- ""

#' domain_exists
#'
#' @details Check if a domain exists
#' @return logical value
#' @export
#'
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


#' main
#'
#' @details Main function of the program. Does the accquisition, the data manipulation and generates the view
#' @return .
#' @export
#'
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
   draw_pie(domains_df)
}


#' get_organization_certificate_info
#'
#' @details Gets the certificate information of a domain
#' @return Data frame with one row containing information of the domain certificate
#' @export
#'
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

#' draw_pie
#'
#' @details Generates the view of the data
#' @return .
#' @export
#'
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


  pie(x=not_resolving_domains,labels=not_resolving_domains, radius=1 , col=c("#cc0000"), main = "Some main")

  par(new=TRUE)

  r1 <- 1-(not_resolving_domains/number_of_domanis)
  pie(x=not_reliable_without_certificate_domains, labels=not_reliable_without_certificate_domains,radius=(r1),col=c("#e59400"), init.angle = 90)

  par(new=TRUE)

  r2 <- r1-(not_reliable_without_certificate_domains/number_of_domanis)
  pie(x=not_reliable_certificate_domains, labels= not_reliable_certificate_domains, radius=(r2), col=c("#e5e500"), init.angle=45)

  par(new=TRUE)

  r3 <- r2 - (not_reliable_certificate_domains/number_of_domanis)
  pie(x=reliable_domains,labels = reliable_domains, radius=(r3), col=c("#198c19"), init.angle = 180)

  legend(1.2, 1, c("Not resolved domains","Domains without certificate","Domains with certificate","Reliable domains"), cex = 1, fill = c("#cc0000","#e59400","#e5e500","#198c19"))

}
