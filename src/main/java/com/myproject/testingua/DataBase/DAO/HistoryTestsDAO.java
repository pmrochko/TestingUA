package com.myproject.testingua.DataBase.DAO;

import com.myproject.testingua.DataBase.DBException;
import com.myproject.testingua.models.entity.HistoryOfTest;
import com.myproject.testingua.models.enums.TestProgressStatus;

import java.util.List;

public interface HistoryTestsDAO {

    void insertRecordOfHistory(int studID, int testID, int resultScore, String progress) throws DBException;

    List<HistoryOfTest> findAllTestHistoryRecordsByStudID(int studID) throws DBException;

    void finishTest(int studID, int testID, int result, TestProgressStatus status) throws DBException;

}