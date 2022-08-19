package com.myproject.testingua.models.sorting;

import com.myproject.testingua.models.entity.Test;

import java.util.Comparator;

public class SortByTestTitle implements Comparator<Test> {
    @Override
    public int compare(Test o1, Test o2) {
        return o1.getTitle().compareTo(o2.getTitle());
    }

    @Override
    public Comparator<Test> reversed() {
        return Comparator.super.reversed();
    }
}

