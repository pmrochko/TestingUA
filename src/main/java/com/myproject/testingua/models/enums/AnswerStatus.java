package com.myproject.testingua.models.enums;

public enum AnswerStatus {

    RIGHT, WRONG;

    public static boolean isValidEnum(String test) {

        for (AnswerStatus status : AnswerStatus.values()) {
            if (status.name().equals(test)) {
                return true;
            }
        }

        return false;
    }
}