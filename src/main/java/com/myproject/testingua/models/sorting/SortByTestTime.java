package com.myproject.testingua.models.sorting;

import com.myproject.testingua.models.entity.Test;

import java.util.Comparator;

public class SortByTestTime implements Comparator<Test> {
    @Override
    public int compare(Test o1, Test o2) {
        return o1.getTime().compareTo(o2.getTime());
    }

    @Override
    public Comparator<Test> reversed() {
        return Comparator.super.reversed();
    }
}
