package com.myproject.testingua.models.entity;

import com.myproject.testingua.DataBase.DAO.AnswerDAO;
import com.myproject.testingua.DataBase.DBException;
import com.myproject.testingua.models.enums.AnswerStatus;
import com.myproject.testingua.models.enums.QuestionStatus;
import com.myproject.testingua.models.enums.TestDifficulty;

import java.util.List;
import java.util.Map;
import java.util.Objects;

public class Test extends Entity{

    private static final long serialVersionUID = 1958075399770672261L;

    private Subject subject;
    private String title;
    private String description;
    private TestDifficulty difficulty;
    private double time;                        // in minutes
    private List<Question> questionsList;

    public Test() {
        super();
    }

    public Test(int id, Subject subject, String title, String description, TestDifficulty difficulty, double time) {
        super(id);
        this.subject = subject;
        this.title = title;
        this.description = description;
        this.difficulty = difficulty;
        this.time = time;
    }

    public Subject getSubject() {
        return subject;
    }
    public void setSubject(Subject subject) {
        this.subject = subject;
    }
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }
    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }
    public TestDifficulty getDifficulty() {
        return difficulty;
    }
    public void setDifficulty(TestDifficulty difficulty) {
        this.difficulty = difficulty;
    }
    public double getTime() {
        return time;
    }
    public void setTime(double time) {
        this.time = time;
    }
    public List<Question> getQuestionsList() {
        return questionsList;
    }
    public void setQuestionsList(List<Question> questionsList) {
        this.questionsList = questionsList;
    }

    public static String calculationResult(Map<Question, List<Integer>> answers) throws DBException {

        if (!answers.isEmpty()) {

            int countOfRightAnswers = 0;
            for (Question question : answers.keySet()) {

                if (question.getQuestionStatus() == QuestionStatus.SIMPLE) {

                    if (!answers.get(question).isEmpty()) {
                        int answerID = answers.get(question).get(0);
                        Answer answer = new AnswerDAO().findAnswerByID(answerID);
                        if (answer.getAnswerStatus() == AnswerStatus.RIGHT) countOfRightAnswers++;
                    }

                } else if (question.getQuestionStatus() == QuestionStatus.COMPLEX) {

                    List<Integer> currentSelectedAnswers = answers.get(question);
                    if (!currentSelectedAnswers.isEmpty()) {

                        long totalCountRightAnswersInQuestion = question.getAnswersList().stream()
                                .filter(a -> a.getAnswerStatus().equals(AnswerStatus.RIGHT))
                                .count();
                        long totalCountRightAnswersInCurrentList = currentSelectedAnswers.stream()
                                .map(Test::getAnswerByID).filter(Objects::nonNull)
                                .filter(a -> a.getAnswerStatus() == AnswerStatus.RIGHT)
                                .count();

                        if (totalCountRightAnswersInQuestion == totalCountRightAnswersInCurrentList &&
                                currentSelectedAnswers.size() == totalCountRightAnswersInQuestion)
                            countOfRightAnswers++;

                    }
                }
            }

            if (countOfRightAnswers != 0) {
                int totalCountQuestions = answers.keySet().size();
                long resultScoreInPercent = Math.round(countOfRightAnswers * 100.0 / totalCountQuestions);
                return resultScoreInPercent + "%";
            }
        }

        return "0%";
    }

    private static Answer getAnswerByID(int id) {
        try {
            return new AnswerDAO().findAnswerByID(id);
        } catch (DBException e) {
            e.printStackTrace();
            return null;
        }
    }
}