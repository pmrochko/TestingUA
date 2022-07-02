package com.myproject.testingua.models.entity;

import com.myproject.testingua.models.enums.AnswerStatus;

public class Answer extends Entity{

    private static final long serialVersionUID = 8887442520553155003L;

    private int questionID;
    private AnswerStatus answerStatus;
    private String answerText;

    public Answer() { super(); }

    public Answer(int id, int questionID, AnswerStatus answerStatus, String answerText) {
        super(id);
        this.questionID = questionID;
        this.answerStatus = answerStatus;
        this.answerText = answerText;
    }

    public int getQuestionID() {
        return questionID;
    }
    public void setQuestionID(int questionID) {
        this.questionID = questionID;
    }
    public AnswerStatus getAnswerStatus() {
        return answerStatus;
    }
    public void setAnswerStatus(AnswerStatus answerStatus) {
        this.answerStatus = answerStatus;
    }
    public String getAnswerText() {
        return answerText;
    }
    public void setAnswerText(String answerText) {
        this.answerText = answerText;
    }
}