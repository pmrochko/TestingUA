package com.myproject.testingua.models.entity;

public class TestHistory extends Entity {

    private static final long serialVersionUID = 2867229465156690908L;

    private int studID;
    private int testID;
    private int resultScore;

    public TestHistory() {
        super();
    }

    public TestHistory(int id, int studID, int testID, int resultScore) {
        super(id);
        this.studID = studID;
        this.testID = testID;
        this.resultScore = resultScore;
    }

    public int getStudID() {
        return studID;
    }
    public void setStudID(int studID) {
        this.studID = studID;
    }
    public int getTestID() {
        return testID;
    }
    public void setTestID(int testID) {
        this.testID = testID;
    }
    public int getResultScore() {
        return resultScore;
    }
    public void setResultScore(int resultScore) {
        this.resultScore = resultScore;
    }
}