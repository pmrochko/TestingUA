package com.myproject.testingua.DataBase.DAO;

import com.myproject.testingua.DataBase.ConnectionPool;
import com.myproject.testingua.DataBase.DBException;
import com.myproject.testingua.models.entity.Subject;
import com.myproject.testingua.models.entity.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SubjectDAO {

    private final ConnectionPool pool;

    public SubjectDAO() throws DBException {
        pool = ConnectionPool.getInstance();
    }

    private final static String SQL_FIND_ALL_SUBJECTS = "SELECT * FROM subjects";
    private static final String SQL_FIND_SUBJECT_BY_NAME = "SELECT * FROM subjects WHERE name=?";
    private static final String SQL_FIND_SUBJECT_BY_ID = "SELECT * FROM subjects WHERE \"ID\"=?";

    public List<Subject> findAllSubjects() throws DBException {
        List<Subject> subjectList = new ArrayList<>();
        Statement stmt = null;
        ResultSet rs = null;
        Connection con = null;

        try {
            con = pool.getConnection();
            con.setAutoCommit(false);

            stmt = con.createStatement();
            rs = stmt.executeQuery(SQL_FIND_ALL_SUBJECTS);
            while (rs.next()) {
                subjectList.add(extractSubject(rs));
            }

            con.commit();
        } catch (SQLException ex) {
            ConnectionPool.rollback(con);
            throw new DBException("Cannot find all subjects", ex);
        } finally {
            ConnectionPool.close(rs, stmt, con);
        }

        return subjectList;
    }
    public Subject findSubjectByID(long id) throws DBException{
        Subject subject = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Connection con = null;
        try {
            con = pool.getConnection();

            pstmt = con.prepareStatement(SQL_FIND_SUBJECT_BY_ID);
            pstmt.setLong(1, id);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                subject = extractSubject(rs);
            }

        } catch (SQLException ex) {
            throw new DBException("Cannot find subject by id", ex);
        } finally {
            ConnectionPool.close(rs, pstmt, con);
        }
        return subject;
    }
    public Subject findSubjectByName(String name) throws DBException{
        Subject subject = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Connection con = null;
        try {
            con = pool.getConnection();

            pstmt = con.prepareStatement(SQL_FIND_SUBJECT_BY_NAME);
            pstmt.setString(1, name);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                subject = extractSubject(rs);
            }

        } catch (SQLException ex) {
            throw new DBException("Cannot find subject by name", ex);
        } finally {
            ConnectionPool.close(rs, pstmt, con);
        }
        return subject;
    }

    private Subject extractSubject(ResultSet rs) throws SQLException {
        return new Subject(
                rs.getInt("ID"), rs.getString("name")
        );
    }
}