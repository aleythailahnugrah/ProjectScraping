# Memuat paket yang diperlukan
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
    data <- data.frame(
        title = titles,
        authors_journal_date = authors_journal_date,
        link = paste0("https://scholar.google.com", links),
        stringsAsFactors = FALSE
    )
    return(data)
  } else {
    print("Gagal mengambil halaman")
    return(NULL)
  }
}
# Fungsi untuk memeriksa dan memasukkan data ke MongoDB
insert_to_mongo <- function(data, mongo_conn) {
  for (i in 1:nrow(data)) {
    article <- data[i, ]
    existing <- mongo_conn$find(paste0('{"link": "', article$link, '"}'))
    if (nrow(existing) == 0) {
      mongo_conn$insert(article)
    }
  }
}

# Membaca nomor halaman terakhir
last_page <- read_last_page()

# Batas maksimal halaman yang ingin diambil
max_pages <- 20 # Ubah sesuai kebutuhan

# Membuat koneksi ke MongoDB Atlas
atlas_conn <- mongo(
  collection = Sys.getenv("ATLAS_COLLECTION"),
  db         = Sys.getenv("ATLAS_DB"),
  url        = Sys.getenv("ATLAS_URL")
)
# Looping untuk mengambil beberapa halaman
for (i in last_page:(last_page + max_pages - 1)) {
  url <- paste0("https://scholar.google.com/scholar?hl=en&as_sdt=0%2C5&q=LSTM&btnG=&as_ylo=", i)
  Gscholar_data <- scrape_Gscholar(url)
  
  if (!is.null(Gscholar_data) && nrow(Gscholar_data) > 0) {
    insert_to_mongo(Gscholar_data, atlas_conn)
    write_last_page(i) # Update nomor halaman terakhir
  } else {
    print(paste("Tidak ada data pada halaman", i))
    break # Berhenti jika tidak ada data
  }
}

# Menutup koneksi setelah selesai
rm(atlas_conn)

# Membuang variabel yang tidak diperlukan
rm(url, GScholar_data, last_page, read_last_page, write_last_page)
