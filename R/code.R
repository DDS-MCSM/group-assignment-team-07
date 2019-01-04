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
  domain <- "hotmail.es"
  url <- paste("https://www.sslshopper.com/assets/snippets/sslshopper/ajax/ajax_check_ssl.php?hostname=", domain, "&g-recaptcha-response=&rand=190", sep = "")
  htmlpage <- GET(url, add_headers("X-Requested-With" = "XMLHttpRequest"))
  html <- read_html(htmlpage)
  # xpath to server certificate organization name. if organization is empty will get Valid tag
  if (xml_text(xml_find_all(html,"//table[2]/tr[1]/td[2]/b[3]")) == "Organization:") {
    organization <- xml_text(xml_find_all(html,"//table[2]/tr[1]/td[2]/descendant::text()[6]"))
  } else if (xml_text(xml_find_all(html,"//table[2]/tr[3]/td[2]/b[2]")) == "Organization:") {
    # xpath to first chain certificate oranization (due to that the certificate is signed with his CA (e.g. Microsoft))
      organization <- xml_text(xml_find_all(html,"//table[2]/tr[3]/td[2]/descendant::text()[4]"))
  }
}
