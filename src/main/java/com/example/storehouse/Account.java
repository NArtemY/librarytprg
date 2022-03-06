package com.example.storehouse;

import jakarta.servlet.http.Cookie;

public class Account {
    private String login;
    private String password;
    private Geologist geolog;

    public Account(String login, String password, Geologist geolog){
        this.login = login;
        this.password = password;
        this.geolog = geolog;
        Admin.addGeolog(geolog.getName(), geolog.getAddress(), geolog.getPhone(), geolog.getEmail());
    }

    public String getLogin() {
        return login;
    }

    public String getPassword() {
        return password;
    }

    public Geologist getGeolog() {
        return geolog;
    }
}
