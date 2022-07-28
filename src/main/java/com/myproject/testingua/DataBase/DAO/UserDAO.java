package com.myproject.testingua.DataBase.DAO;

import com.myproject.testingua.DataBase.DBException;
import com.myproject.testingua.models.entity.User;

import java.util.List;

public interface UserDAO {

    boolean insertUser(String login, String email, String password, String name, String surname) throws DBException;

    boolean updateUserSurname(String newSurname, int id) throws DBException;
    boolean updateUserName(String newName, int id) throws DBException;
    boolean updateUserEmail(String newEmail, int id) throws DBException;
    boolean updateUserTel(String newTel, int id) throws DBException;
    boolean updateUserLogin(String newLogin, int id) throws DBException;
    boolean updateUserPassword(String newPassword, int id) throws DBException;
    void updateUserBanStatus(boolean newStatus, int id) throws DBException;

    User findUserByEmail(String email) throws DBException;
    User findUserByLogin(String login) throws DBException;
    User findUserByID(int id) throws DBException;
    List<User> findAllUsers() throws DBException;

}