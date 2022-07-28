package com.myproject.testingua.DataBase.DAO.impl;

import com.myproject.testingua.DataBase.ConnectionPool;
import com.myproject.testingua.DataBase.DAO.AnswerDAO;
import com.myproject.testingua.DataBase.DBException;
import com.myproject.testingua.models.entity.Answer;
import com.myproject.testingua.models.enums.AnswerStatus;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AnswerDAOImpl implements AnswerDAO {

    private final ConnectionPool pool;

    public AnswerDAOImpl() throws DBException {
        pool = ConnectionPool.getInstance();
    }

    private static final String SQL_INSERT_ANSWER = "INSERT INTO answers (question_id, answer_status, answer_text) " +
            "VALUES (?, ?, ?)";
    private static final String SQL_FIND_ANSWER_BY_ID = "SELECT * FROM answers WHERE \"ID\"=?";
    private static final String SQL_FIND_ALL_ANSWERS_BY_QUESTION_ID = "SELECT * FROM answers WHERE question_id=?";
    private static final String SQL_UPDATE_ANSWER = "UPDATE answers SET answer_status=?, answer_text=? WHERE \"ID\"=?";
    private static final String SQL_DELETE_ANSWER_BY_ID = "DELETE FROM answers WHERE \"ID\"=?";
    private static final String SQL_DELETE_ANSWERS_BY_QUESTION_ID = "DELETE FROM answers WHERE question_id=?";

    @Override
    public boolean insertAnswer(int questionID, String answerStatus, String answerText) throws DBException {
        Connection con = null;
        PreparedStatement pstmt = null;
        int check;

        try {
            con = pool.getConnection();
            con.setAutoCommit(false);

            pstmt = con.prepareStatement(SQL_INSERT_ANSWER);
            int c = 0;
            pstmt.setInt(++c, questionID);
            pstmt.setString(++c, answerStatus);
            pstmt.setString(++c, answerText);
            check = pstmt.executeUpdate();

            con.commit();
        } catch (SQLException ex) {
            ConnectionPool.rollback(con);
            throw new DBException("Cannot insert answer", ex);
        } finally {
            ConnectionPool.close(pstmt);
            ConnectionPool.close(con);
        }
        return (check > 0);
    }
    @Override
    public void deleteAnswerByID(int id) throws DBException {
        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            con = pool.getConnection();
            con.setAutoCommit(false);

            pstmt = con.prepareStatement(SQL_DELETE_ANSWER_BY_ID);
            pstmt.setInt(1, id);
            pstmt.executeUpdate();

            con.commit();
        } catch (SQLException e) {
            ConnectionPool.rollback(con);
            throw new DBException("Cannot delete answer by id", e);
        } finally {
            ConnectionPool.close(pstmt);
            ConnectionPool.close(con);
        }
    }
    @Override
    public void updateAnswer(String newAnswer, String newStatus, int answerID) throws DBException {
        Connection con = null;
        PreparedStatement pstmt = null;
        int check;

        try {
            con = pool.getConnection();
            con.setAutoCommit(false);

            pstmt = con.prepareStatement(SQL_UPDATE_ANSWER);
            int c = 0;
            pstmt.setString(++c, newStatus);
            pstmt.setString(++c, newAnswer);
            pstmt.setInt(++c, answerID);
            check = pstmt.executeUpdate();

            con.commit();
        } catch (SQLException ex) {
            ConnectionPool.rollback(con);
            throw new DBException("Cannot update answer", ex);
        } finally {
            ConnectionPool.close(pstmt);
            ConnectionPool.close(con);
        }
    }
    @Override
    public Answer findAnswerByID(int id) throws DBException{
        Answer answer = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Connection con = null;

        try {
            con = pool.getConnection();

            pstmt = con.prepareStatement(SQL_FIND_ANSWER_BY_ID);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                answer = extractAnswer(rs);
            }

        } catch (SQLException ex) {
            throw new DBException("Cannot find answer by id", ex);
        } finally {
            ConnectionPool.close(rs, pstmt, con);
        }
        return answer;
    }
    @Override
    public List<Answer> findAllAnswersByQuestionID(int questionID) throws DBException {
        List<Answer> answersList = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Connection con = null;

        try {
            con = pool.getConnection();
            con.setAutoCommit(false);

            pstmt = con.prepareStatement(SQL_FIND_ALL_ANSWERS_BY_QUESTION_ID);
            pstmt.setInt(1, questionID);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                answersList.add(extractAnswer(rs));
            }

            con.commit();
        } catch (SQLException ex) {
            ConnectionPool.rollback(con);
            throw new DBException("Cannot find all answers by question id", ex);
        } finally {
            ConnectionPool.close(rs, pstmt, con);
        }

        return answersList;
    }

    public static void deleteAnswersByQuestionID(Connection con, int questionID) throws DBException {
        try {
            PreparedStatement pstmt = con.prepareStatement(SQL_DELETE_ANSWERS_BY_QUESTION_ID);
            pstmt.setInt(1, questionID);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new DBException("Cannot delete answers by question id", e);
        }
    }

    private Answer extractAnswer(ResultSet rs) throws SQLException {
        return new Answer(
                rs.getInt("ID"),
                rs.getInt("question_id"),
                AnswerStatus.valueOf(rs.getString("answer_status")),
                rs.getString("answer_text")
                );
    }
}