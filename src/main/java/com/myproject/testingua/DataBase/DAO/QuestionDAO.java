package com.myproject.testingua.DataBase.DAO;

import com.myproject.testingua.DataBase.ConnectionPool;
import com.myproject.testingua.DataBase.DBException;
import com.myproject.testingua.models.entity.Answer;
import com.myproject.testingua.models.entity.Question;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class QuestionDAO {

    private final ConnectionPool pool;

    public QuestionDAO() throws DBException {
        pool = ConnectionPool.getInstance();
    }

    private static final String SQL_INSERT_QUESTION = "INSERT INTO questions (question_text, test_id) " +
            "VALUES (?, ?)";
    private static final String SQL_FIND_QUESTION_BY_ID = "SELECT * FROM questions WHERE \"ID\"=?";
    private static final String SQL_FIND_ALL_QUESTIONS_BY_TEST_ID = "SELECT * FROM questions WHERE test_id=?";
    private static final String SQL_UPDATE_QUESTION = "UPDATE questions SET question_text=? WHERE \"ID\"=?";
    private static final String SQL_DELETE_QUESTION_BY_ID = "DELETE FROM questions WHERE \"ID\"=?";
    private static final String SQL_DELETE_QUESTIONS_BY_TEST_ID =
            "WITH q AS (" +
                    "DELETE FROM questions WHERE test_id=? " +
                    "RETURNING \"ID\"" +
                    ")" +
            "DELETE FROM answers " +
            "USING q " +
            "WHERE question_id = q.\"ID\"";

    public boolean insertQuestion(String questionText, int testID) throws DBException {
        Connection con = null;
        PreparedStatement pstmt = null;
        int check;

        try {
            con = pool.getConnection();
            con.setAutoCommit(false);

            pstmt = con.prepareStatement(SQL_INSERT_QUESTION);
            int c = 0;
            pstmt.setString(++c, questionText);
            pstmt.setInt(++c, testID);
            check = pstmt.executeUpdate();

            con.commit();
        } catch (SQLException ex) {
            ConnectionPool.rollback(con);
            throw new DBException("Cannot insert question", ex);
        } finally {
            ConnectionPool.close(pstmt);
            ConnectionPool.close(con);
        }
        return (check > 0);
    }
    public void deleteQuestionByID(int id) throws DBException {
        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            con = pool.getConnection();
            con.setAutoCommit(false);

            AnswerDAO.deleteAnswersByQuestionID(con, id);

            pstmt = con.prepareStatement(SQL_DELETE_QUESTION_BY_ID);
            pstmt.setInt(1, id);
            pstmt.executeUpdate();

            con.commit();
        } catch (SQLException ex) {
            ConnectionPool.rollback(con);
            throw new DBException("Cannot delete question by id", ex);
        } finally {
            ConnectionPool.close(pstmt);
            ConnectionPool.close(con);
        }
    }
    public static void deleteQuestionsByTestID(Connection con, int testID) throws DBException {
        try {
            PreparedStatement pstmt = con.prepareStatement(SQL_DELETE_QUESTIONS_BY_TEST_ID);
            pstmt.setInt(1, testID);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            throw new DBException("Cannot delete question by test id", ex);
        }
    }

    public void updateQuestion(String newQuestion, int questionID) throws DBException {
        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            con = pool.getConnection();
            con.setAutoCommit(false);

            pstmt = con.prepareStatement(SQL_UPDATE_QUESTION);
            int c = 0;
            pstmt.setString(++c, newQuestion);
            pstmt.setInt(++c, questionID);
            pstmt.executeUpdate();

            con.commit();
        } catch (SQLException ex) {
            ConnectionPool.rollback(con);
            throw new DBException("Cannot update question", ex);
        } finally {
            ConnectionPool.close(pstmt);
            ConnectionPool.close(con);
        }
    }

    public Question findQuestionByID(int id) throws DBException{
        Question question = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Connection con = null;

        try {
            con = pool.getConnection();
            con.setAutoCommit(false);

            pstmt = con.prepareStatement(SQL_FIND_QUESTION_BY_ID);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                question = extractQuestion(rs);
            }

            con.commit();
        } catch (SQLException ex) {
            ConnectionPool.rollback(con);
            throw new DBException("Cannot find question by id", ex);
        } finally {
            ConnectionPool.close(rs, pstmt, con);
        }
        return question;
    }

    public List<Question> findAllQuestionsByTestID(int testID) throws DBException {
        List<Question> questionsList = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Connection con = null;

        try {
            con = pool.getConnection();
            con.setAutoCommit(false);

            pstmt = con.prepareStatement(SQL_FIND_ALL_QUESTIONS_BY_TEST_ID);
            pstmt.setInt(1, testID);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                questionsList.add(extractQuestion(rs));
            }

            con.commit();
        } catch (SQLException ex) {
            ConnectionPool.rollback(con);
            throw new DBException("Cannot find all questions by test id", ex);
        } finally {
            ConnectionPool.close(rs, pstmt, con);
        }

        return questionsList;
    }

    private Question extractQuestion(ResultSet rs) throws SQLException, DBException {
        Question question = new Question();

        int id = rs.getInt("ID");
        question.setId(id);
        question.setQuestionText(rs.getString("question_text"));
        question.setTestID(rs.getInt("test_id"));

        AnswerDAO answerDAO = new AnswerDAO();
        List<Answer> answers = answerDAO.findAllAnswersByQuestionID(id);
        question.setAnswersList(answers);

        return question;
    }
}