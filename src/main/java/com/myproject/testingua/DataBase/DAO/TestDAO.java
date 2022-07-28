package com.myproject.testingua.DataBase.DAO;

import com.myproject.testingua.DataBase.DBException;
import com.myproject.testingua.models.entity.Test;

import java.sql.Time;
import java.util.List;

public interface TestDAO {

    boolean insertTest(int subjectID, String title, String description, String difficulty, Time time)
            throws DBException;

    void deleteTestByID(int id) throws DBException;

    void updateTest(int newSubjectID, String newTitle, String newDescription, String newDifficulty, Time newTime, int id)
            throws DBException;

    Test findTestByID(int id) throws DBException;

    List<Test> findAllTests() throws DBException;


}