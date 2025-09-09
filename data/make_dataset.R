library(digest)

fetch_file <- function(
    url,
    dest_dir = "data/raw",
    fname = "consumos_3810_2023.xlsx",
    expected_hash = "511c3fec852c7e2f3f89de1739e31b09"
) {
  if (!dir.exists(dest_dir)) {
    dir.create(dest_dir, recursive = TRUE)
  }
  
  dest_path <- file.path(dest_dir, fname)
  
  if (file.exists(dest_path)) {
    message("File exists. Verifying checksum...")
    file_hash <- digest(dest_path, file = TRUE)
    
    if (!is.null(expected_hash) && file_hash == expected_hash) {
      message("Checksum matches. Using cached file.")
      return(dest_path)
    } else {
      message("Checksum mismatch or not provided. Re-downloading...")
    }
  } else {
    message("File not found. Downloading...")
  }
  
  download.file(url, dest_path, mode = "wb", cacheOK = FALSE)
  
  if (!is.null(expected_hash)) {
    file_hash <- digest(dest_path, file = TRUE)
    if (file_hash != expected_hash) {
      stop("Downloaded file checksum does not match expected hash.")
    } else {
      message("Downloaded file verified successfully.")
    }
  }
  
  return(dest_path)
}

url <- "https://e-redes.opendatasoft.com/api/explore/v2.1/catalog/datasets/consumos_horario_codigo_postal/exports/xlsx?lang=en&refine=codigo_postal%3A%223810%22&refine=datahora%3A%222023%22&timezone=Europe%2FLisbon&use_labels=true"

expected_hash <- "511c3fec852c7e2f3f89de1739e31b09"

file_path <- fetch_file(url, expected_hash = expected_hash)
