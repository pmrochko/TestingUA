package com.myproject.testingua.DataBase.DAO;

import com.myproject.testingua.DataBase.DBException;
import com.myproject.testingua.models.entity.Subject;

import java.util.List;

public interface SubjectDAO {

    List<Subject> findAllSubjects() throws DBException;

    Subject findSubjectByID(long id) throws DBException;

}