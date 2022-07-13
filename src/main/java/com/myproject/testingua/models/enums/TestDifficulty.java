package com.myproject.testingua.models.enums;

public enum TestDifficulty {

    EASY, MEDIUM, DIFFICULT;

    public static boolean isValidEnum(String test) {

        for (TestDifficulty difficulty : TestDifficulty.values()) {
            if (difficulty.name().equals(test)) {
                return true;
            }
        }

        return false;
    }

}