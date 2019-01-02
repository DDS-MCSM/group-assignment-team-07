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

get_sslshopper_certificate_html <- function(domain){
  domain <- "google.com"
  url <- paste("https://www.sslshopper.com/assets/snippets/sslshopper/ajax/ajax_check_ssl.php?hostname=", domain, "&g-recaptcha-response=&rand=190", sep = "")
  htmlpage <- GET(url, add_headers("X-Requested-With" = "XMLHttpRequest"))
  html <- read_html(htmlpage)
  # xpath to organization name. if organization is empty will get Valid tag
  if (xml_text(xml_find_all(html,"//table[2]/tr[1]/td[2]/b[3]")) == "Organization:") {
    organization <- xml_text(xml_find_all(html,"//table[2]/tr[1]/td[2]/text()[preceding-sibling::br][2]"))
  }
  else{
    organization <- "None"
  }

}

library("xml2")
library("httr")
