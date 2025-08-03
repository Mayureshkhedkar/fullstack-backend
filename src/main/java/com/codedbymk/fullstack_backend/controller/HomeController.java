package com.codedbymk.fullstack_backend.controller;

import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/")
public class HomeController {

    public String greetings(){
        return "Hello the application is running";
    }
}
