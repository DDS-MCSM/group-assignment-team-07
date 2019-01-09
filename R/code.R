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

get_organization_certificate_info <- function(response){
  organization <- "None"
  sslshopper_html <- read_html(response)

  domain_resolves <- !identical(xml_text(xml_find_all(sslshopper_html, "//table[1]/tr[1]/td[1][contains(@class, 'passed')]")),character(0))
  if (domain_resolves) {
    #has certificate?
    has_certificate <- !identical(xml_text(xml_find_all(sslshopper_html, "//table[contains(@class, 'checker_certs')]")),character(0))
    if (has_certificate) {
      #Get cert info
      has_organization_field <- (xml_text(xml_find_all(sslshopper_html,"//table[2]/tr[1]/td[2]/b[3]")) == "Organization:")
      if (has_organization_field) {
        organization <- xml_text(xml_find_all(sslshopper_html,"//table[2]/tr[1]/td[2]/descendant::text()[6]"))
      }
      else{
        #don't have organization field -> get organization from https://www.ultratools.com/tools/ipWhoisLookupResult with ip
        ultratools_url <- "https://www.ultratools.com/tools/ipWhoisLookupResult"
        ultratools_htmlpage <- httr::POST(ultratools_url,add_headers("Content-Type" = "application/x-www-form-urlencoded"), body = "ipAddress=40.113.200.201")
        ultratools_html <- read_html(ultratools_htmlpage)
        organization <- xml_text(xml_find_all(ultratools_html,"//div[contains(./span,'Org:')]/span[2]"))
        if (identical(organization,character(0))) {
          organization <- "None"
        }
      }
      #Compare organization field with the legitimate one
    } else {
      #No certificate
    }
  } else {
    #don't resolve
  }
  return(organization)
}


main <- function(domain){
  domains_with_certificate <- ""
  domains_without_certificate <- ""
  non_existing_domains <- ""
  results <- character(0)
  #Get reliable domain data (Organiation)
  sslshopper_url <- paste("https://www.sslshopper.com/assets/snippets/sslshopper/ajax/ajax_check_ssl.php?hostname=", domain, "&g-recaptcha-response=&rand=190", sep = "")
  sslshopper_htmlpage <- GET(sslshopper_url, add_headers("X-Requested-With" = "XMLHttpRequest"))
  organization <- get_organization_certificate_info(domain)

  #get similar domains list
  source_python("/home/test/Master/DDS/group-assignment-team-07/python_scripts/edit_domain.py")
  similar_domains <- edit_domain(domain)

  #get similar domains data (Organiation) and compare it with legitimate domain
  pool <- new_pool()
  cb <- function(req){ results <- c(results,get_organization_certificate_info(req$content))}
  for (i in 1:length(similar_domains)) {
    curl_fetch_multi("https://www.sslshopper.com/assets/snippets/sslshopper/ajax/ajax_check_ssl.php?hostname=" + similar_domains[i] + "&g-recaptcha-response=&rand=190",pool = pool, handle = new_handle() %>% handle_setheaders("X-Requested-With" = "XMLHttpRequest"), done = cb)
  }
  out <- multi_run(pool = pool)
}


