package com.myproject.testingua.models.sorting;

import com.myproject.testingua.models.entity.Test;

import java.util.Comparator;

public class SortByTestQuestion implements Comparator<Test> {
    @Override
    public int compare(Test o1, Test o2) {
        return o1.getQuestionsList().size()-o2.getQuestionsList().size();
    }

    @Override
    public Comparator<Test> reversed() {
        return Comparator.super.reversed();
    }
}

