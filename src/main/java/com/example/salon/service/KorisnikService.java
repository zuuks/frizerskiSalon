package com.example.salon.service;

import com.example.salon.model.Korisnik;
import com.example.salon.repository.KorisnikRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class KorisnikService {

    private final KorisnikRepository korisnikRepository;

    public KorisnikService(KorisnikRepository korisnikRepository) {
        this.korisnikRepository = korisnikRepository;
    }

    public List<Korisnik> findAll() {
        return korisnikRepository.findAll();
    }
}
