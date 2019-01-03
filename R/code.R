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
  domain <- "apple.com"
  url <- paste("https://www.sslshopper.com/assets/snippets/sslshopper/ajax/ajax_check_ssl.php?hostname=", domain, "&g-recaptcha-response=&rand=190", sep = "")
  htmlpage <- GET(url, add_headers("X-Requested-With" = "XMLHttpRequest"))
  html <- read_html(htmlpage)
  # xpath to server certificate organization name. if organization is empty will get Valid tag
  if (xml_text(xml_find_all(html,"//table[2]/tr[1]/td[2]/b[3]")) == "Organization:") {
    # works with Organization name without <br> tag xml_text(xml_find_all(html,"//table[2]/tr[1]/td[2]/descendant::text()[6]"))
    organization <- xml_text(xml_find_all(html,"//table[2]/tr[1]/td[2]/text()[preceding-sibling]"))
  } else if (xml_text(xml_find_all(html,"//table[2]/tr[3]/td[2]/b[2]")) == "Organization:") {
    # xpath to first chain certificate oranization (signed with his CA (Microsoft))
      organization <- xml_text(xml_find_all(html,"//table[2]/tr[3]/td[2]/b[2]/text()[preceding-sibling::br][2]"))
  }
}

.checker_certs > tbody:nth-child(1) > tr:nth-child(3) > td:nth-child(2) > b:nth-child(3)
