package com.myproject.testingua.models.entity;

import com.myproject.testingua.DataBase.DAO.HistoryTestsDAO;
import com.myproject.testingua.DataBase.DBException;
import com.myproject.testingua.models.enums.TestProgressStatus;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;

public class HistoryOfTest extends Entity {

    private static final long serialVersionUID = -8414197881824252333L;

    private Test test;
    private Timestamp dateTime;
    private TestProgressStatus status;
    private int result;

    public Test getTest() {
        return test;
    }
    public void setTest(Test test) {
        this.test = test;
    }
    public String getDateTime() {
        return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(dateTime);
    }
    public void setDateTime(Timestamp timestamp) {
        this.dateTime = timestamp;
    }
    public TestProgressStatus getStatus() {
        return status;
    }
    public void setStatus(TestProgressStatus status) {
        this.status = status;
    }
    public int getResult() {
        return result;
    }
    public void setResult(int result) {
        this.result = result;
    }

    public String getDate() {
        String full = getDateTime();
        String[] dateAndTime = full.split("\\s");
        return dateAndTime[0];
    }
    public String getTime() {
        String full = getDateTime();
        String[] dateAndTime = full.split("\\s");
        return dateAndTime[1];
    }

    public static boolean historyContainRecordedTest(Test test, int studID) throws DBException {

        boolean check = false;
        List<HistoryOfTest> history = new HistoryTestsDAO().findAllTestHistoryRecordsByStudID(studID);

        if (history != null) {
            for (HistoryOfTest record : history) {
                if (record.getTest().equals(test)) {
                    check = true;
                    break;
                }
            }
        }

        return check;
    }
}