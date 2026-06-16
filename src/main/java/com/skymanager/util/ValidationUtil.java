/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.skymanager.util;

/**
 *
 * @author maick
 */

public class ValidationUtil {
    
    public static boolean isValidEmail(String email) {
        return email != null && email.matches("^[A-Za-z0-9+_.-]+@(.+)$");
    }
    
    public static boolean isNotEmpty(String... values) {
        for (String value : values) {
            if (value == null || value.trim().isEmpty()) return false;
        }
        return true;
    }
    
    public static String sanitize(String input) {
        if (input == null) return "";
        return input.replaceAll("<", "&lt;")
                    .replaceAll(">", "&gt;")
                    .replaceAll("\"", "&quot;")
                    .replaceAll("'", "&#x27;");
    }
}