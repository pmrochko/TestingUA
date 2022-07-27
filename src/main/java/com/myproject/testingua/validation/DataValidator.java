package com.myproject.testingua.validation;

import javax.servlet.http.HttpSession;

public class DataValidator {

    public static boolean isValidName(String value) {
        String nameRegex = "^[A-ZА-ЯІЇЄ]([a-zа-яіїє]{2,15})";
        return value.matches(nameRegex);
    }
    public static boolean isValidSurname(String value) {
        String surnameRegex = "^[A-ZА-ЯІЇЄ]([a-zа-яіїє]{2,15})";
        return value.matches(surnameRegex);
    }
    public static boolean isValidLogin(String value) {
        String loginRegex = "^[a-zA-Z0-9]([._-](?![._-])|[a-zA-Z0-9]){2,18}[a-zA-Z0-9]$";
        return value.matches(loginRegex);
    }
    public static boolean isValidEmail(String value) {
        String emailRegex = "^[a-z0-9](\\.?[a-z0-9]){5,}@g(oogle)?mail\\.com$";
        return value.matches(emailRegex);
    }
    public static boolean isValidPassword(String value) {
        String passwordRegex = "(^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$)|([a-fA-F0-9]{32})";
        return value.matches(passwordRegex);
    }
    public static boolean isValidTel(String value) {
        String telRegex = "[0-9]{3}-[0-9]{3}-[0-9]{4}";
        return value.matches(telRegex);
    }

    /////////////////////////////////////////////////////////////////////////////////

    public static boolean isValidRegistrationForm(HttpSession session,
                                                  String name, String surname, String login,
                                                  String email, String password) {
        if (!isValidName(name)) {
            session.setAttribute("invalidInput", "name");
            return false;
        }
        if (!isValidSurname(surname)) {
            session.setAttribute("invalidInput", "surname");
            return false;
        }
        if (!isValidLogin(login)) {
            session.setAttribute("invalidInput", "login");
            return false;
        }
        if (!isValidEmail(email)) {
            session.setAttribute("invalidInput", "email");
            return false;
        }
        if (!isValidPassword(password)) {
            session.setAttribute("invalidInput", "password");
            return false;
        }

        return true;
    }
}