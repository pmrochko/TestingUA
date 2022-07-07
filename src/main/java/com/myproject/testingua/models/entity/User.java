package com.myproject.testingua.models.entity;

import com.myproject.testingua.DataBase.DAO.HistoryTestsDAO;
import com.myproject.testingua.DataBase.DBException;
import com.myproject.testingua.models.enums.UserRoles;

public class User extends Entity{

    private static final long serialVersionUID = 8393561819133940282L;

    private String login;
    private String email;
    private UserRoles role;
    private String password;
    private String name;
    private String surname;
    private String tel;
    private boolean blocked;

    public User() {
        super();
    }

    public User(int id, String login, String email, UserRoles role, String password, String name, String surname) {
        super(id);
        this.login = login;
        this.email = email;
        this.role = role;
        this.password = password;
        this.name = name;
        this.surname = surname;
    }

    public String getLogin() {
        return login;
    }
    public void setLogin(String login) {
        this.login = login;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public UserRoles getRole() {
        return role;
    }
    public void setRole(UserRoles role) {
        this.role = role;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getSurname() {
        return surname;
    }
    public void setSurname(String surname) {
        this.surname = surname;
    }
    public String getTel() {
        return tel;
    }
    public void setTel(String tel) {
        this.tel = tel;
    }
    public void setBlocked(boolean blocked) {
        this.blocked = blocked;
    }
    public boolean isBlocked() {
        return blocked;
    }

    public boolean historyContainRecordedTest(Test test) throws DBException {

        return HistoryOfTest.historyContainRecordedTest(test, getId());

    }
    public int countOfPassedTests() {
        try {
            HistoryTestsDAO historyTestsDAO = new HistoryTestsDAO();
            return historyTestsDAO.findAllTestHistoryRecordsByStudID(getId()).size();
        } catch (DBException e) {
            e.printStackTrace();
            //error - page
        }
        return 0;
    }
}