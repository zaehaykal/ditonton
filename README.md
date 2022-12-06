[![Codemagic build status](https://api.codemagic.io/apps/638b0f4eb1716042e261135e/default-workflow/status_badge.svg)](https://codemagic.io/apps/638b0f4eb1716042e261135e/default-workflow/latest_build)

# a199-flutter-expert-project

Repository ini merupakan starter project submission kelas Flutter Expert Dicoding Indonesia.

---

## Tips Submission Awal

Pastikan untuk memeriksa kembali seluruh hasil testing pada submissionmu sebelum dikirimkan. Karena kriteria pada submission ini akan diperiksa setelah seluruh berkas testing berhasil dijalankan.


## Tips Submission Akhir

Jika kamu menerapkan modular pada project, Anda dapat memanfaatkan berkas `test.sh` pada repository ini. Berkas tersebut dapat mempermudah proses testing melalui *terminal* atau *command prompt*. Sebelumnya menjalankan berkas tersebut, ikuti beberapa langkah berikut:
1. Install terlebih dahulu aplikasi sesuai dengan Operating System (OS) yang Anda gunakan.
    - Bagi pengguna **Linux**, jalankan perintah berikut pada terminal.
        ```
        sudo apt-get update -qq -y
        sudo apt-get install lcov -y
        ```
    
    - Bagi pengguna **Mac**, jalankan perintah berikut pada terminal.
        ```
        brew install lcov
        ```
    - Bagi pengguna **Windows**, ikuti langkah berikut.
        - Install [Chocolatey](https://chocolatey.org/install) pada komputermu.
        - Setelah berhasil, install [lcov](https://community.chocolatey.org/packages/lcov) dengan menjalankan perintah berikut.
            ```
            choco install lcov
            ```
        - Kemudian cek **Environtment Variabel** pada kolom **System variabels** terdapat variabel GENTHTML dan LCOV_HOME. Jika tidak tersedia, Anda bisa menambahkan variabel baru dengan nilai seperti berikut.
            | Variable | Value|
            | ----------- | ----------- |
            | GENTHTML | C:\ProgramData\chocolatey\lib\lcov\tools\bin\genhtml |
            | LCOV_HOME | C:\ProgramData\chocolatey\lib\lcov\tools |
        
2. Untuk mempermudah proses verifikasi testing, jalankan perintah berikut.
    ```
    git init
    ```
3. Kemudian jalankan berkas `test.sh` dengan perintah berikut pada *terminal* atau *powershell*.
    ```
    test.sh
    ```
    atau
    ```
    ./test.sh
    ```
    Proses ini akan men-*generate* berkas `lcov.info` dan folder `coverage` terkait dengan laporan coverage.
4. Tunggu proses testing selesai hingga muncul web terkait laporan coverage.

## Test Coverage
![Screenshot (72)](https://user-images.githubusercontent.com/110841646/205654427-12c2d75b-1257-4a6a-a231-f2adbf6f6292.png)

## Mendeteksi push kode lalu men-trigger build baru
![Screenshot (81)](https://user-images.githubusercontent.com/110841646/205946856-565fd6fc-9c51-4d43-8e1f-119511e472fd.png)


## Code Magic Build OverView
![Screenshot (80)](https://user-images.githubusercontent.com/110841646/205946720-d0bb463b-a48b-41dd-aa7a-12c29b8a4667.png)


## Firebase Analytics
![Screenshot (71)](https://user-images.githubusercontent.com/110841646/205654495-67ae4abc-b754-4721-a485-5adcf88bf040.png)


## Firebase Crashlytics
![Screenshot (74)](https://user-images.githubusercontent.com/110841646/205654924-0ccf9a2f-a035-47ef-9040-1f44a2689baf.png)


