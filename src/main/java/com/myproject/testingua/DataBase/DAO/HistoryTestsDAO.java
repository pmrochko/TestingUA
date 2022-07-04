package com.myproject.testingua.DataBase.DAO;

import com.myproject.testingua.DataBase.ConnectionPool;
import com.myproject.testingua.DataBase.DBException;

public class HistoryTestsDAO {

    private final ConnectionPool pool;

    public HistoryTestsDAO() throws DBException {
        pool = ConnectionPool.getInstance();
    }



}