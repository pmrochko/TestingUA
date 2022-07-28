package com.myproject.testingua.DataBase.DAO.impl;

import com.myproject.testingua.DataBase.ConnectionPool;
import com.myproject.testingua.DataBase.DAO.SubjectDAO;
import com.myproject.testingua.DataBase.DBException;
import com.myproject.testingua.models.entity.Subject;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SubjectDAOImpl implements SubjectDAO {

    private final ConnectionPool pool;

    public SubjectDAOImpl() throws DBException {
        pool = ConnectionPool.getInstance();
    }

    private static final String SQL_FIND_ALL_SUBJECTS = "SELECT * FROM subjects";
    private static final String SQL_FIND_SUBJECT_BY_ID = "SELECT * FROM subjects WHERE \"ID\"=?";

    @Override
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
    @Override
    public Subject findSubjectByID(long id) throws DBException {
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

    private Subject extractSubject(ResultSet rs) throws SQLException {
        return new Subject(
                rs.getInt("ID"), rs.getString("name")
        );
    }
}