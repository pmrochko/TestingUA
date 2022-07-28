package com.myproject.testingua.DataBase.DAO;

import com.myproject.testingua.DataBase.DBException;
import com.myproject.testingua.models.entity.Answer;

import java.util.List;

public interface AnswerDAO {

    boolean insertAnswer(int questionID, String answerStatus, String answerText) throws DBException;

    void deleteAnswerByID(int id) throws DBException;

    void updateAnswer(String newAnswer, String newStatus, int answerID) throws DBException;

    Answer findAnswerByID(int id) throws DBException;

    List<Answer> findAllAnswersByQuestionID(int questionID) throws DBException;

}