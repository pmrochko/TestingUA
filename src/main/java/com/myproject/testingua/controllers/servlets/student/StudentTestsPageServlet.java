package com.myproject.testingua.controllers.servlets.student;

import com.myproject.testingua.DataBase.DAO.SubjectDAO;
import com.myproject.testingua.DataBase.DAO.TestDAO;
import com.myproject.testingua.DataBase.DBException;
import com.myproject.testingua.controllers.Path;
import com.myproject.testingua.models.entity.Subject;
import com.myproject.testingua.models.entity.Test;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "StudentTestsPageServlet", value = "/student/tests")
public class StudentTestsPageServlet extends HttpServlet {

    private static final long serialVersionUID = -5783386666661608242L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        List<Subject> subjects = null;
        List<Test> tests = null;

        try {
            SubjectDAO subjectDAO = new SubjectDAO();
            subjects = subjectDAO.findAllSubjects();
            TestDAO testDAO = new TestDAO();
            tests = testDAO.findAllTests();

            String selectedSubject = request.getParameter("selectedSubject");
            if (selectedSubject != null) {
                request.setAttribute("selectedSubject", selectedSubject);
                for (Subject subject : subjects) {
                    if (subject.getName().equals(selectedSubject)) {
                        tests = tests.stream()
                                .filter(t -> t.getSubject().equals(subject))
                                .collect(Collectors.toList());
                    }
                }
            }

        } catch (DBException e) {
            e.printStackTrace();
        }

        if (subjects != null && tests != null) {
            session.setAttribute("subjectsList", subjects);
            request.setAttribute("testsList", tests);
        }
        request.getRequestDispatcher(Path.STUDENT_TESTS_PAGE).forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String selectedSubject = request.getParameter("selectedSubject");
        if (selectedSubject != null && !selectedSubject.isBlank() && !selectedSubject.equals("All"))
            response.sendRedirect("/student/tests?selectedSubject=" + selectedSubject);
        else
            response.sendRedirect("/student/tests");

    }

}