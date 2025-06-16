# 💇‍♂️ Frizerski Salon - Web Aplikacija

Sistem za upravljanje zakazivanjem termina u frizerskom salonu sa korisničkom i administrativnom stranom.

---

## 🧰 Tehnologije

- **Backend**: Spring Boot, Spring Security, Spring Data JPA  
- **Frontend**: Thymeleaf, HTML, CSS  
- **Baza**: MySQL  
- **Ostalo**: BCrypt za šifrovanje lozinki

---

## 🏗️ Struktura projekta

- ├── model/ # Entiteti (Korisnik, Termin, Zaposleni...)
- ├── repository/ # Spring Data JPA repozitorijumi
- ├── service/ # Poslovna logika
- ├── controller/ # HTTP rutiranje
- ├── config/ # Security konfiguracija
- ├── templates/ # Thymeleaf HTML fajlovi
- └── static/css/ # Stilovi

---

## 🗃️ Baza podataka

- **Entiteti**: `Korisnik`, `Rola`, `Zaposleni`, `Usluga`, `Termin`
- **Veze**:
  - `Korisnik` → `Rola` *(ManyToOne)*
  - `Termin` → `Zaposleni`, `Korisnik` *(ManyToOne)*
  - `Termin` ↔ `Usluga` *(ManyToMany)*

---

## ✅ Funkcionalnosti

- ✅ Registracija korisnika (automatski dobija rolu `KORISNIK`)
- ✅ Login / logout
- ✅ Zakazivanje termina (korisnik za sebe, admin za bilo koga)
- ✅ Pregled svojih termina (`/termini/moji`)
- ✅ Admin panel za upravljanje:
  - zaposlenima
  - uslugama
  - svim terminima

---

## 🔐 Bezbednost

- BCrypt enkripcija lozinki
- Role-based autorizacija:
  - `KORISNIK`: može samo svoje termine
  - `ADMIN`: može sve
- Automatsko logovanje korisnika nakon registracije
- Custom error handler (`/error` → redirect na `/home?greska=...`)

---

## 🎨 UI/UX

- Responsive forme i tabele
- Navigacija (navbar) i podnožje (footer) kao Thymeleaf fragmenti
- Moderno dizajnirani admin panel sa sidebar navigacijom + iframe sadržajem

---

## ▶️ Pokretanje aplikacije

1. Kloniraj repozitorijum:
   ```bash
   git clone https://github.com/ime-korisnika/salon-app.git
   cd salon-app
2. Konfiguriši application.properties
    spring.datasource.url=jdbc:mysql://localhost:3306/salon
    spring.datasource.username=root
    spring.datasource.password=lozinka
3. Pokreni aplikaciju:
    ./mvnw spring-boot:run
