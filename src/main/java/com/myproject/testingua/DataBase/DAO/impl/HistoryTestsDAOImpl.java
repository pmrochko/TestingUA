package com.myproject.testingua.DataBase.DAO.impl;

import com.myproject.testingua.DataBase.ConnectionPool;
import com.myproject.testingua.DataBase.DAO.HistoryTestsDAO;
import com.myproject.testingua.DataBase.DBException;
import com.myproject.testingua.models.entity.HistoryOfTest;
import com.myproject.testingua.models.entity.Test;
import com.myproject.testingua.models.enums.TestProgressStatus;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class HistoryTestsDAOImpl implements HistoryTestsDAO {

    private final ConnectionPool pool;

    public HistoryTestsDAOImpl() throws DBException {
        pool = ConnectionPool.getInstance();
    }

    private static final String SQL_FIND_ALL_TEST_HISTORY_RECORDS_BY_STUD_ID = "SELECT * FROM history WHERE stud_id=?";
    private static final String SQL_INSERT_RECORD_OF_HISTORY = "INSERT INTO history (stud_id, test_id, result_score, progress) " +
            "VALUES (?, ?, ?, ?)";
    private static final String SQL_DELETE_HISTORY_RECORDS_BY_TEST_ID = "DELETE FROM history WHERE test_id=?";
    private static final String SQL_UPDATE_RESULT_TEST = "UPDATE history SET result_score=?, progress=?, date_time=DEFAULT " +
            "WHERE stud_id=? AND test_id=?";

    @Override
    public void insertRecordOfHistory(int studID, int testID, int resultScore, String progress) throws DBException {
        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            con = pool.getConnection();
            con.setAutoCommit(false);

            pstmt = con.prepareStatement(SQL_INSERT_RECORD_OF_HISTORY);
            int index = 1;
            pstmt.setInt(index, studID);
            pstmt.setInt(++index, testID);
            pstmt.setInt(++index, resultScore);
            pstmt.setString(++index, progress);
            pstmt.executeUpdate();

            con.commit();
        } catch (SQLException e) {
            ConnectionPool.rollback(con);
            throw new DBException("Cannot insert record to history of tests", e);
        } finally {
            ConnectionPool.close(pstmt);
            ConnectionPool.close(con);
        }
    }
    @Override
    public List<HistoryOfTest> findAllTestHistoryRecordsByStudID(int studID) throws DBException {

        List<HistoryOfTest> records = new ArrayList<>();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            con = pool.getConnection();
            con.setAutoCommit(false);

            pstmt = con.prepareStatement(SQL_FIND_ALL_TEST_HISTORY_RECORDS_BY_STUD_ID);
            pstmt.setInt(1, studID);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                records.add(extractRecordOfHistory(rs));
            }

            con.commit();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new DBException("Cannot find all test history records by student id", e);
        } finally {
            ConnectionPool.close(rs, pstmt, con);
        }

        return records;
    }
    @Override
    public void finishTest(int studID, int testID, int result, TestProgressStatus status) throws DBException {

        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            con = pool.getConnection();
            con.setAutoCommit(false);

            pstmt = con.prepareStatement(SQL_UPDATE_RESULT_TEST);
            int index = 1;
            pstmt.setInt(index, result);
            pstmt.setString(++index, status.name());
            pstmt.setInt(++index, studID);
            pstmt.setInt(++index, testID);
            pstmt.executeUpdate();

            con.commit();
        } catch (SQLException e) {
            ConnectionPool.rollback(con);
            throw new DBException("Cannot update result of test", e);
        } finally {
            ConnectionPool.close(pstmt);
            ConnectionPool.close(con);
        }

    }

    public static void deleteRecordsOfHistoryByTestID(Connection con, int testID) throws DBException {
        try {
            PreparedStatement pstmt = con.prepareStatement(SQL_DELETE_HISTORY_RECORDS_BY_TEST_ID);
            pstmt.setInt(1, testID);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            throw new DBException("Cannot delete history records by test id", ex);
        }
    }

    private HistoryOfTest extractRecordOfHistory(ResultSet rs) throws SQLException, DBException {
        HistoryOfTest record = new HistoryOfTest();

        int testID = rs.getInt("test_id");
        Test test = new TestDAOImpl().findTestByID(testID);
        record.setTest(test);
        record.setStatus(TestProgressStatus.valueOf(rs.getString("progress")));
        record.setDateTime(rs.getTimestamp("date_time"));
        record.setResult(rs.getInt("result_score"));

        return record;
    }
}