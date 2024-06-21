<p align="center" width="80%">
    <img width="60%" src="https://github.com/aleythailahnugrah/ProjectScraping/blob/main/Logo.jpg">
</p>

<div align="center">
    
[![scrape_hashtag](https://github.com/aleythailahnugrah/ProjectScraping/actions/workflows/main.yml/badge.svg)](https://github.com/aleythailahnugrah/ProjectScraping/actions/workflows/main.yml)

<p align="center">
# Menu:

</p>

[Tentang](#Tentang)
•
[Deskripsi](#Deskripsi)
•
[MongoDB](#MongoDB)
•
[PPT](#PPT)
•
[Pengembang](#Pengembang)

</div>

## Tentang  

**Apa itu Google Scholar?**

<p align="justify">
Google Scholar adalah layanan web yang disediakan oleh Google yang memungkinkan pengguna untuk mencari materi-materi akademis dalam berbagai format dan bidang ilmu. Layanan ini dirancang khusus untuk membantu peneliti, mahasiswa, dan akademisi menemukan artikel ilmiah, tesis, buku, konferensi, dan dokumen-dokumen ilmiah lainnya. 

Pencarian Spesifik: Mencari berdasarkan penulis, judul, atau kata kunci.
Sitasi: Melihat jumlah sitasi sebuah artikel.
Profil Penulis: Penulis bisa membuat profil untuk menampilkan karya dan metrik penelitian.
Akses Artikel: Menyediakan tautan ke artikel, beberapa gratis dan lainnya berbayar.
Pemberitahuan: Mengatur notifikasi untuk topik tertentu.

Google Scholar berfungsi sebagai alat yang sangat berguna untuk akademisi dan peneliti dalam menemukan, mengakses, dan melacak literatur ilmiah yang relevan dengan bidang studi mereka.
</p>

## Deskripsi

<p align="justify">
Dalam proyek ini, saya melakukan scraping di situs web https://scholar.google.com/ untuk mengumpulkan artikel jurnal yang membahas penggunaan LSTM (Long Short-Term Memory). LSTM adalah jenis jaringan saraf tiruan dalam kategori Recurrent Neural Networks (RNNs), yang dirancang untuk mengatasi masalah vanishing gradient. LSTM sangat efektif untuk memproses dan memprediksi data sekuensial karena memiliki unit memori yang dapat menyimpan informasi dalam jangka waktu panjang. LSTM banyak diterapkan dalam pemrosesan teks, pengenalan suara, dan analisis deret waktu. Tujuan utama dari scraping ini adalah mengumpulkan artikel penelitian yang menerapkan metode LSTM guna memudahkan analisis data dari berbagai studi yang telah dipublikasikan.
</p>

<p align="justify">
Dengan melakukan scraping data dari Google Scholar, kita bisa mendapatkan berbagai informasi penting seperti id, judul artikel, nama jurnal, nama penulis, tahun terbit, dan link. Data ini sangat berguna untuk keperluan penelitian, review literatur, dan analisis tren penggunaan LSTM dalam berbagai bidang. Dengan data yang terkumpul, kita dapat mengidentifikasi pola-pola penelitian, mengevaluasi perkembangan metode LSTM, dan menemukan gap atau peluang baru dalam penelitian yang belum banyak dieksplorasi. Selain itu, data ini juga membantu dalam membangun basis referensi yang lebih komprehensif untuk peneliti lain yang tertarik dengan topik serupa.
</p>
</div>

## MongoDB

Berikut adalah salah satu contoh dokumen di MongoDB untuk artikel yang tersedia di Google Scholar dengan metode LSTM:
```mongodb
{
  "_id": {
    "$oid": "6663ba274010ba4eb809bd71"
  },
  "title": "Read-First LSTM model: A new variant of long short term memory neural network for predicting solar radiation data",
  "authors_journal_date": "M Ehteram, MA Nia, F Panahi, A Farrokhi - Energy Conversion and …, 2024 - Elsevier",
  "link": "https://scholar.google.comhttps://www.sciencedirect.com/science/article/pii/S0196890424002085"
}
```

## PPT
Berikut adalah link PPT:
https://ppt-scraping-aleytha.my.canva.site/
## Pengembang
[Aleytha Ilahnugrah Kurnadipare](https://github.com/aleythailahnugrah) - G1501231067
