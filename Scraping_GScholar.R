library(rvest)
library(httr)
library(mongolite)

# Fungsi untuk membaca nomor halaman terakhir dari file
read_last_page <- function() {
  if (file.exists("last_page.txt")) {
    return(as.integer(readLines("last_page.txt")))
  } else {
    return(1)
  }
}

# Fungsi untuk menyimpan nomor halaman terakhir ke file
write_last_page <- function(page_number) {
  writeLines(as.character(page_number), "last_page.txt")
}

# Fungsi untuk melakukan scraping
scrape_Gscholar <- function(url) {
  page <- GET(url)
  if (status_code(page) == 200) {
    page_content <- read_html(content(page, "text"))
    titles <- page_content %>% html_nodes('.gs_rt a') %>% html_text(trim = TRUE)
    links <- page_content %>% html_nodes('.gs_rt a') %>% html_attr('href')
    authors_journal_date <- page_content %>% html_nodes('.gs_a') %>% html_text(trim = TRUE)
    
    if (length(titles) > 0 && length(links) > 0 && length(authors_journal_date) > 0) {
      data <- data.frame(
        title = titles,
        authors_journal_date = authors_journal_date,
        link = paste0("https://scholar.google.com", links),
        stringsAsFactors = FALSE
      )
      return(data)
    } else {
      return(NULL)
    }
  } else {
    print("Gagal mengambil halaman")
    return(NULL)
  }
}

# Membaca nomor halaman terakhir
last_page <- read_last_page()

# URL halaman Google Scholar dengan pencarian "LSTM" dan halaman tertentu
url <- paste0("https://scholar.google.com/scholar?hl=en&as_sdt=0%2C5&q=LSTM&btnG=")

# Memanggil fungsi untuk melakukan scraping
GScholar_data <- scrape_Gscholar(url)
if (!is.null(GScholar_data)) {
  print(GScholar_data)
  
  # MONGODB
  message('Input Data to MongoDB Atlas')
  
  # Mengecek variabel lingkungan
  atlas_collection <- Sys.getenv("ATLAS_COLLECTION")
  atlas_db <- Sys.getenv("ATLAS_DB")
  atlas_url <- Sys.getenv("ATLAS_URL")
  
  if (nzchar(atlas_collection) && nzchar(atlas_db) && nzchar(atlas_url)) {
    # Membuat koneksi ke MongoDB Atlas
    atlas_conn <- mongo(
      collection = atlas_collection,
      db         = atlas_db,
      url        = atlas_url
    )
    
    if (!is.null(atlas_conn)) {
      # Memasukkan data ke MongoDB Atlas
      atlas_conn$insert(GScholar_data)
      
      # Menutup koneksi setelah selesai
      rm(atlas_conn)
      
      # Memperbarui nomor halaman terakhir
      write_last_page(last_page + 1)
    } else {
      print("Gagal membuat koneksi ke MongoDB.")
    }
  } else {
    print("Variabel lingkungan untuk MongoDB tidak lengkap.")
  }
} else {
  print("Tidak ada data untuk dimasukkan ke MongoDB.")
}

# Membuang variabel yang tidak diperlukan
rm(url, GScholar_data, last_page, read_last_page, write_last_page)
