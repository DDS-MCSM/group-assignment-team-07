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

# get_sslshopper_certificate_html <- function(domain){
#   #domain <- "hotmail.com"
#   url <- paste("https://www.sslshopper.com/assets/snippets/sslshopper/ajax/ajax_check_ssl.php?hostname=", domain, top_level_domain,"&g-recaptcha-response=&rand=190", sep = "")
#   htmlpage <- GET(url, add_headers("X-Requested-With" = "XMLHttpRequest"))
#   html <- read_html(htmlpage)
#   organisation <- "none"
#   # xpath to server certificate organization name. if organization is empty will get Valid tag
#   if (xml_text(xml_find_all(html,"//table[2]/tr[1]/td[2]/b[3]")) == "Organization:") {
#     organization <- xml_text(xml_find_all(html,"//table[2]/tr[1]/td[2]/descendant::text()[6]"))
#   } else if (xml_text(xml_find_all(html,"//table[2]/tr[3]/td[2]/b[2]")) == "Organization:") {
#     # xpath to first chain certificate oranization (due to that the certificate is signed with his CA (e.g. Microsoft))
#       organization <- xml_text(xml_find_all(html,"//table[2]/tr[3]/td[2]/descendant::text()[4]"))
#   }
#   return(organization)
# }
#
# get_sslshopper_certificate_info_html <- function(domain){
#   url <- paste("https://www.sslshopper.com/assets/snippets/sslshopper/ajax/ajax_check_ssl.php?hostname=", domain, ".com&g-recaptcha-response=&rand=190", sep = "")
#   htmlpage <- GET(url, add_headers("X-Requested-With" = "XMLHttpRequest"))
#   html <- read_html(htmlpage)
# }
#
# main <- function(domain){
#   domains_with_certificate <- ""
#   domains_without_certificate <- ""
#   non_existing_domains <- ""
#   domain <- "hotmail.com"
#   #Get reliable domain data (Organiation)
#   organization <- get_sslshopper_certificate_html(domain)
#
#   #get similar domains list
#   source_python("/home/test/Master/DDS/group-assignment-team-07/python_scripts/edit_domain.py")
#   similar_domains <- edit_domain("hotmail")
#
#   #get similar domains data (Organiation) and compare it with legitimate domain
#   results <- logical()
#   for (i in 1:length(similar_domains)) {
#     results <- c(results,(organization == get_sslshopper_certificate_html(similar_domains[i])))
#   }
#
# }
domain <- "amazon.com"
url <- paste("https://www.sslshopper.com/assets/snippets/sslshopper/ajax/ajax_check_ssl.php?hostname=", domain, "&g-recaptcha-response=&rand=190", sep = "")
htmlpage <- GET(url, add_headers("X-Requested-With" = "XMLHttpRequest"))
html <- read_html(htmlpage)

domain_resolves <- !identical(xml_text(xml_find_all(html, "//table[1]/tr[1]/td[1][contains(@class, 'passed')]")),character(0))
if (domain_resolves) {
  #has certificate?
  has_certificate <- !identical(xml_text(xml_find_all(html, "//table[contains(@class, 'checker_certs')]")),character(0))
  if (has_certificate) {
    #Get cert info
    has_organization_field <- (xml_text(xml_find_all(html,"//table[2]/tr[1]/td[2]/b[3]")) == "Organization:")
    if (has_organization_field) {
      organization <- xml_text(xml_find_all(html,"//table[2]/tr[1]/td[2]/descendant::text()[6]"))
      }
  } else {
    #No certificate
  }
} else {
  #don't resolve
}

# else {
#   #resolves
#
#   if (identical(xml_text(xml_find_all(html, "//table[1]/tr[3]/td[1][contains(@class, 'failed')]/following-sibling::td[1]/h3[1]")),character(0))) {
#     #Has no server type and no certificate
#   }
#   has_server_type <- startsWith(xml_text(xml_find_all(html, "//table[1]/tr[3]/td[1][contains(@class, 'passed')]/following-sibling::td[1]/h3[1]")),"Server Type:")
#   if (has_server_type & !has_certificate) {
#     #Has server type
#   }
# }



