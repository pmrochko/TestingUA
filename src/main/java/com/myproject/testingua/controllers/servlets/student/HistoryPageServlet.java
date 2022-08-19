package com.myproject.testingua.controllers.servlets.student;

import com.myproject.testingua.DataBase.DAO.impl.HistoryTestsDAOImpl;
import com.myproject.testingua.DataBase.DBException;
import com.myproject.testingua.controllers.Path;
import com.myproject.testingua.models.entity.HistoryOfTest;
import com.myproject.testingua.models.entity.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "HistoryPageServlet", value = "/student/history")
public class HistoryPageServlet extends HttpServlet {

    private static final long serialVersionUID = -269797006319406625L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        try {
            List<HistoryOfTest> records = new HistoryTestsDAOImpl().findAllTestHistoryRecordsByStudID(currentUser.getId());
            request.setAttribute("historyOfTests", records);
        } catch (DBException e) {
            session.setAttribute("errorMessage", e.getMessage());
            session.setAttribute("prevPage", getServletContext().getContextPath());
            response.sendRedirect("/error");
        }

        request.getRequestDispatcher(Path.STUDENT_HISTORY_PAGE).forward(request, response);
    }
}