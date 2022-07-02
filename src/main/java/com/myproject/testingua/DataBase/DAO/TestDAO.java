package com.myproject.testingua.DataBase.DAO;

import com.myproject.testingua.DataBase.ConnectionPool;
import com.myproject.testingua.DataBase.DBException;
import com.myproject.testingua.models.entity.Question;
import com.myproject.testingua.models.entity.Subject;
import com.myproject.testingua.models.entity.Test;
import com.myproject.testingua.models.enums.TestDifficulty;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TestDAO {

    private final ConnectionPool pool;

    public TestDAO() throws DBException {
        pool = ConnectionPool.getInstance();
    }

    private final static String SQL_INSERT_TEST = "INSERT INTO tests (subject_id, title, description, difficulty, time) " +
            "VALUES (?, ?, ?, ?, ?)";
    private static final String SQL_FIND_TEST_BY_ID = "SELECT * FROM tests WHERE \"ID\"=?";
    private static final String SQL_FIND_ALL_TESTS = "SELECT * FROM tests";

    private static final String SQL_UPDATE_TEST = "UPDATE tests " +
            "SET subject_id=?, title=?, description=?, difficulty=?, time=?" +
            "WHERE \"ID\"=?";

    public boolean insertTest(int subjectID, String title, String description, String difficulty, double time)
            throws DBException {
        Connection con = null;
        PreparedStatement pstmt = null;
        int check;

        try {
            con = pool.getConnection();
            con.setAutoCommit(false);

            pstmt = con.prepareStatement(SQL_INSERT_TEST);
            int c = 0;
            pstmt.setInt(++c, subjectID);
            pstmt.setString(++c, title);
            pstmt.setString(++c, description);
            pstmt.setString(++c, difficulty);
            pstmt.setDouble(++c, time);
            check = pstmt.executeUpdate();

            con.commit();
        } catch (SQLException ex) {
            ConnectionPool.rollback(con);
            throw new DBException("Cannot insert test", ex);
        } finally {
            ConnectionPool.close(pstmt);
            ConnectionPool.close(con);
        }

        return (check > 0);
    }

    public boolean updateTest(int newSubjectID, String newTitle, String newDescription, String newDifficulty, Double newTime, int id)
            throws DBException {
        Connection con = null;
        PreparedStatement pstmt = null;
        int check = 0;

        try {
            con = pool.getConnection();
            con.setAutoCommit(false);

            pstmt = con.prepareStatement(SQL_UPDATE_TEST);
            int c = 1;
            pstmt.setInt(c, newSubjectID);
            pstmt.setString(++c, newTitle);
            pstmt.setString(++c, newDescription);
            pstmt.setString(++c, newDifficulty);
            pstmt.setDouble(++c, newTime);
            pstmt.setInt(++c, id);

            check = pstmt.executeUpdate();
            con.commit();
        } catch (SQLException e) {
            ConnectionPool.rollback(con);
            throw new DBException("Cannot update test", e);
        } finally {
            ConnectionPool.close(pstmt);
            ConnectionPool.close(con);
        }

        return (check > 0);
    }

    public Test findTestByID(int id) throws DBException{
        Test test = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Connection con = null;
        try {
            con = pool.getConnection();
            con.setAutoCommit(false);

            pstmt = con.prepareStatement(SQL_FIND_TEST_BY_ID);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                test = extractTest(rs);
            }

        } catch (SQLException ex) {
            throw new DBException("Cannot find test by id", ex);
        } finally {
            ConnectionPool.close(rs, pstmt, con);
        }
        return test;
    }

    public List<Test> findAllTests() throws DBException {
        List<Test> testList = new ArrayList<>();
        Statement stmt = null;
        ResultSet rs = null;
        Connection con = null;

        try {
            con = pool.getConnection();
            con.setAutoCommit(false);

            stmt = con.createStatement();
            rs = stmt.executeQuery(SQL_FIND_ALL_TESTS);
            while (rs.next()) {
                testList.add(extractTest(rs));
            }

            con.commit();
        } catch (SQLException ex) {
            ConnectionPool.rollback(con);
            throw new DBException("Cannot find all users", ex);
        } finally {
            ConnectionPool.close(rs, stmt, con);
        }

        return testList;
    }

    private Test extractTest(ResultSet rs) throws SQLException, DBException {
        Test test = new Test();

        int id = rs.getInt("ID");
        Subject subject = new SubjectDAO().findSubjectByID(rs.getInt("subject_id"));
        test.setId(id);
        test.setSubject(subject);
        test.setTitle(rs.getString("title"));
        test.setDescription(rs.getString("description"));
        test.setDifficulty(TestDifficulty.valueOf(rs.getString("difficulty")));
        test.setTime(rs.getDouble("time"));
        test.setProgressStatus(null);

        List<Question> questions = new QuestionDAO().findAllQuestionsByTestID(id);
        test.setQuestionsList(questions);

        return test;
    }
}