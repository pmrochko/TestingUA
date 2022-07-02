package com.myproject.testingua.models.entity;

import com.myproject.testingua.models.enums.AnswerStatus;
import com.myproject.testingua.models.enums.QuestionStatus;

import java.util.List;
import java.util.stream.Collectors;

public class Question extends Entity{

    private static final long serialVersionUID = -4682558146985628494L;
    private int testID;
    private String questionText;
    private List<Answer> answersList;

    public Question() {
        super();
    }

    public Question(int id, int testID, String questionText) {
        super(id);
        this.testID = testID;
        this.questionText = questionText;
    }

    public int getTestID() {
        return testID;
    }
    public void setTestID(int testID) {
        this.testID = testID;
    }
    public String getQuestionText() {
        return questionText;
    }
    public void setQuestionText(String questionText) {
        this.questionText = questionText;
    }
    public List<Answer> getAnswersList() {
        return answersList;
    }
    public void setAnswersList(List<Answer> answersList) {
        this.answersList = answersList;
    }

    public QuestionStatus getQuestionStatus() {

        List<Answer> rightAnswers = answersList.stream()
                .filter(a -> a.getAnswerStatus() == AnswerStatus.RIGHT)
                .collect(Collectors.toList());

        int countOfRightAnswers = rightAnswers.size();

        if (countOfRightAnswers >= 2) {
            return QuestionStatus.COMPLEX;
        } else if (countOfRightAnswers == 1) {
            return QuestionStatus.SIMPLE;
        } else {
            return null;
        }
    }
}