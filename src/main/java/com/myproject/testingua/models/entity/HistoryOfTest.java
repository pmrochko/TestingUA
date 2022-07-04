package com.myproject.testingua.models.entity;

import com.myproject.testingua.models.enums.TestProgressStatus;

import java.sql.Date;

public class HistoryOfTest extends Entity {

    private static final long serialVersionUID = -8414197881824252333L;

    private Test test;
    private Date date;
    private TestProgressStatus status;

    public Test getTest() {
        return test;
    }
    public void setTest(Test test) {
        this.test = test;
    }
    public Date getDate() {
        return date;
    }
    public void setDate(Date date) {
        this.date = date;
    }
    public TestProgressStatus getStatus() {
        return status;
    }
    public void setStatus(TestProgressStatus status) {
        this.status = status;
    }
}