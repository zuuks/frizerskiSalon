package com.example.salon.controller;

import com.example.salon.model.Termin;
import com.example.salon.model.Usluga;
import java.time.LocalTime;
import com.example.salon.model.Zaposleni;
import com.example.salon.model.Korisnik;
import com.example.salon.service.TerminService;
import com.example.salon.service.UslugaService;
import com.example.salon.service.ZaposleniService;
import com.example.salon.service.KorisnikService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import java.util.ArrayList;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/termini")
public class TerminController {

    private final TerminService terminService;
    private final ZaposleniService zaposleniService;
    private final UslugaService uslugaService;
    private final KorisnikService korisnikService;

    public TerminController(
            TerminService terminService,
            ZaposleniService zaposleniService,
            UslugaService uslugaService,
            KorisnikService korisnikService
    ) {
        this.terminService = terminService;
        this.zaposleniService = zaposleniService;
        this.uslugaService = uslugaService;
        this.korisnikService = korisnikService;
    }

    @GetMapping
    public String prikaziSve(Model model) {
        model.addAttribute("termini", terminService.findAll());
        return "termini/lista";
    }

    @GetMapping("/novi")
    public String formaNoviTermin(
            @RequestParam(required = false) Long uslugaId,
            Model model
    ) {
        model.addAttribute("termin", new Termin());
        model.addAttribute("zaposleniLista", zaposleniService.findAll());
        model.addAttribute("uslugeLista", uslugaService.findAll());
        model.addAttribute("korisniciLista", korisnikService.findAll());

        if (uslugaId != null) {
            Optional<Usluga> usluga = uslugaService.findById(uslugaId);
            List<LocalTime> vremena = generisiSlotove(usluga.orElseThrow().getTrajanjeMinuta());
            model.addAttribute("vremena", vremena);
            model.addAttribute("odabranaUslugaId", uslugaId);
        }

        return "termini/forma";
    }
    private List<LocalTime> generisiSlotove(int trajanjeMinuta) {
        List<LocalTime> slotovi = new ArrayList<>();
        LocalTime start = LocalTime.of(8, 0);
        LocalTime end = LocalTime.of(20, 0).minusMinutes(trajanjeMinuta);

        while (!start.isAfter(end)) {
            slotovi.add(start);
            start = start.plusMinutes(trajanjeMinuta);
        }

        return slotovi;
    }


    @PostMapping("/sacuvaj")
    public String sacuvajTermin(@ModelAttribute Termin termin, Model model) {
        if (terminService.postojiPreklapanje(termin)) {
            model.addAttribute("termin", termin);
            model.addAttribute("zaposleniLista", zaposleniService.findAll());
            model.addAttribute("uslugeLista", uslugaService.findAll());
            model.addAttribute("korisniciLista", korisnikService.findAll());
            model.addAttribute("vremena", List.of()); // ako zatreba
            model.addAttribute("greska", "Termin se preklapa sa postojećim!");
            return "termini/forma";
        }

        terminService.save(termin);
        return "redirect:/home";
    }


    @GetMapping("/izmeni/{id}")
    public String formaIzmeni(@PathVariable Long id, Model model) {
        Termin termin = terminService.findById(id).orElseThrow();
        model.addAttribute("termin", termin);
        model.addAttribute("zaposleniLista", zaposleniService.findAll());
        model.addAttribute("uslugeLista", uslugaService.findAll());
        model.addAttribute("korisniciLista", korisnikService.findAll());
        return "termini/forma";
    }

    @GetMapping("/obrisi/{id}")
    public String obrisi(@PathVariable Long id) {
        terminService.deleteById(id);
        return "redirect:/termini";
    }
}
