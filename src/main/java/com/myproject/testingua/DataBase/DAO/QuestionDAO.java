package com.myproject.testingua.DataBase.DAO;

import com.myproject.testingua.DataBase.DBException;
import com.myproject.testingua.models.entity.Question;

import java.util.List;

public interface QuestionDAO {

    boolean insertQuestion(String questionText, int testID) throws DBException;

    void deleteQuestionByID(int id) throws DBException;

    void updateQuestion(String newQuestion, int questionID) throws DBException;

    List<Question> findAllQuestionsByTestID(int testID) throws DBException;

}