package com.example.salon.controller;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CustomErrorHandler implements ErrorController {

    @RequestMapping("/error")
    public String handleError(HttpServletRequest request) {
        return "redirect:/home?greska=true";
    }
}
