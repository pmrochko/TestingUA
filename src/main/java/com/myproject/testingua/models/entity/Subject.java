package com.myproject.testingua.models.entity;

import java.util.List;

public class Subject extends Entity{

    private static final long serialVersionUID = 7699623103868830552L;

    private String name;
    private List<Test> testsList;

    public Subject() {
        super();
    }

    public Subject(int id, String name) {
        super(id);
        this.name = name;
    }

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public List<Test> getTestsList() {
        return testsList;
    }
    public void setTestsList(List<Test> testsList) {
        this.testsList = testsList;
    }
}