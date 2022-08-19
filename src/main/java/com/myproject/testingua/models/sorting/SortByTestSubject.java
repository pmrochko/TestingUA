package com.myproject.testingua.models.sorting;

import com.myproject.testingua.models.entity.Test;

import java.util.Comparator;

public class SortByTestSubject implements Comparator<Test> {
    @Override
    public int compare(Test o1, Test o2) {
        return o1.getSubject().getName().compareTo(o2.getSubject().getName());
    }

    @Override
    public Comparator<Test> reversed() {
        return Comparator.super.reversed();
    }
}

