package com.myproject.testingua.DataBase.DAO.impl;

import com.myproject.testingua.DataBase.DAO.UserDAO;
import com.myproject.testingua.DataBase.DBException;
import com.myproject.testingua.DataBase.ConnectionPool;
import com.myproject.testingua.models.entity.User;
import com.myproject.testingua.models.enums.UserRole;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAOImpl implements UserDAO {

    private final ConnectionPool pool;

    public UserDAOImpl() throws DBException {
        pool = ConnectionPool.getInstance();
    }

    private static final String SQL_FIND_ALL_USERS = "SELECT * FROM users";
    private static final String SQL_FIND_USER_BY_EMAIL = "SELECT * FROM users WHERE email=?";
    private static final String SQL_FIND_USER_BY_LOGIN = "SELECT * FROM users WHERE login=?";
    private static final String SQL_FIND_USER_BY_ID = "SELECT * FROM users WHERE \"ID\"=?";
    private static final String SQL_INSERT_USER = "INSERT INTO users (login, email, role, password, name, surname) " +
            "VALUES (?, ?, 'STUDENT', ?, ?, ?)";

    private static final String SQL_UPDATE_USER_SURNAME = "UPDATE users SET surname=? WHERE \"ID\"=?";
    private static final String SQL_UPDATE_USER_NAME = "UPDATE users SET name=? WHERE \"ID\"=?";
    private static final String SQL_UPDATE_USER_EMAIL = "UPDATE users SET email=? WHERE \"ID\"=?";
    private static final String SQL_UPDATE_USER_TEL = "UPDATE users SET tel=? WHERE \"ID\"=?";
    private static final String SQL_UPDATE_USER_LOGIN = "UPDATE users SET login=? WHERE \"ID\"=?";
    private static final String SQL_UPDATE_USER_PASSWORD = "UPDATE users SET password=? WHERE \"ID\"=?";
    private static final String SQL_UPDATE_BANSTATUS = "UPDATE users SET \"banStatus\"=? WHERE \"ID\"=?";

    @Override
    public boolean updateUserSurname(String newSurname, int id) throws DBException {
        return updateUserValue(newSurname, id, SQL_UPDATE_USER_SURNAME);
    }
    @Override
    public boolean updateUserName(String newName, int id) throws DBException {
        return updateUserValue(newName, id, SQL_UPDATE_USER_NAME);
    }
    @Override
    public boolean updateUserEmail(String newEmail, int id) throws DBException {
        return updateUserValue(newEmail, id, SQL_UPDATE_USER_EMAIL);
    }
    @Override
    public boolean updateUserTel(String newTel, int id) throws DBException {
        return updateUserValue(newTel, id, SQL_UPDATE_USER_TEL);
    }
    @Override
    public boolean updateUserLogin(String newLogin, int id) throws DBException {
        return updateUserValue(newLogin, id, SQL_UPDATE_USER_LOGIN);
    }
    @Override
    public boolean updateUserPassword(String newPassword, int id) throws DBException {
        return updateUserValue(newPassword, id, SQL_UPDATE_USER_PASSWORD);
    }
    @Override
    public void updateUserBanStatus(boolean newStatus, int id) throws DBException {
        Connection con = null;
        PreparedStatement pstmt = null;
        int check = 0;

        try {
            con = pool.getConnection();

            pstmt = con.prepareStatement(SQL_UPDATE_BANSTATUS);
            pstmt.setBoolean(1, newStatus);
            pstmt.setInt(2, id);

            check = pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionPool.close(pstmt);
            ConnectionPool.close(con);
        }

    }

    @Override
    public boolean insertUser(String login, String email, String password, String name, String surname) throws DBException {
        Connection con = null;
        PreparedStatement pstmt = null;
        int check;

        try {
            con = pool.getConnection();
            con.setAutoCommit(false);

            pstmt = con.prepareStatement(SQL_INSERT_USER);
            pstmt.setString(1, login);
            pstmt.setString(2, email);
            pstmt.setString(3, password);
            pstmt.setString(4, name);
            pstmt.setString(5, surname);
            check = pstmt.executeUpdate();

            con.commit();
        } catch (SQLException ex) {
            ConnectionPool.rollback(con);
            throw new DBException("Cannot insert user", ex);
        } finally {
            ConnectionPool.close(pstmt);
            ConnectionPool.close(con);
        }

        return (check > 0);
    }

    @Override
    public User findUserByEmail(String email) throws DBException {
        User user = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Connection con = null;
        try {
            con = pool.getConnection();

            pstmt = con.prepareStatement(SQL_FIND_USER_BY_EMAIL);
            pstmt.setString(1, email);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                user = extractUser(rs);
            }

        } catch (SQLException ex) {
            throw new DBException("Cannot find user by email", ex);
        } finally {
            ConnectionPool.close(rs, pstmt, con);
        }
        return user;
    }
    @Override
    public User findUserByLogin(String login) throws DBException {
        User user = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Connection con = null;
        try {
            con = pool.getConnection();

            pstmt = con.prepareStatement(SQL_FIND_USER_BY_LOGIN);
            pstmt.setString(1, login);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                user = extractUser(rs);
            }

        } catch (SQLException ex) {
            throw new DBException("Cannot find user by login", ex);
        } finally {
            ConnectionPool.close(rs, pstmt, con);
        }
        return user;
    }
    @Override
    public User findUserByID(int id) throws DBException {
        User user = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Connection con = null;
        try {
            con = pool.getConnection();

            pstmt = con.prepareStatement(SQL_FIND_USER_BY_ID);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                user = extractUser(rs);
            }

        } catch (SQLException ex) {
            throw new DBException("Cannot find user by id", ex);
        } finally {
            ConnectionPool.close(rs, pstmt, con);
        }
        return user;
    }

    @Override
    public List<User> findAllUsers() throws DBException {
        List<User> userList = new ArrayList<>();
        Statement stmt = null;
        ResultSet rs = null;
        Connection con = null;

        try {
            con = pool.getConnection();
            con.setAutoCommit(false);

            stmt = con.createStatement();
            rs = stmt.executeQuery(SQL_FIND_ALL_USERS);
            while (rs.next()) {
                userList.add(extractUser(rs));
            }

            con.commit();
        } catch (SQLException ex) {
            ConnectionPool.rollback(con);
            throw new DBException("Cannot find all users", ex);
        } finally {
            ConnectionPool.close(rs, stmt, con);
        }

        return userList;
    }

    private boolean updateUserValue(String newValue, int id, String sqlUpdateQuery) throws DBException {
        Connection con = null;
        PreparedStatement pstmt = null;
        int check = 0;

        try {
            con = pool.getConnection();

            pstmt = con.prepareStatement(sqlUpdateQuery);
            pstmt.setString(1, newValue);
            pstmt.setInt(2, id);

            check = pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionPool.close(pstmt);
            ConnectionPool.close(con);
        }

        return (check > 0);
    }

    private User extractUser(ResultSet rs) throws SQLException {
        User user = new User();

        user.setId(rs.getInt("ID"));
        user.setLogin(rs.getString("login"));
        user.setEmail(rs.getString("email"));
        user.setRole(UserRole.valueOf(rs.getString("role")));
        user.setPassword(rs.getString("password"));
        user.setName(rs.getString("name"));
        user.setSurname(rs.getString("surname"));
        if (rs.getString("tel") != null)
            user.setTel(rs.getString("tel"));
        user.setBlocked(rs.getBoolean("banStatus"));

        return user;
    }
}