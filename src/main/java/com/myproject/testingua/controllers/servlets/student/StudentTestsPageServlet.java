package com.myproject.testingua.controllers.servlets.student;

import com.myproject.testingua.DataBase.DAO.impl.SubjectDAOImpl;
import com.myproject.testingua.DataBase.DAO.impl.TestDAOImpl;
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
import java.util.ArrayList;
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
            SubjectDAOImpl subjectDAOImpl = new SubjectDAOImpl();
            subjects = subjectDAOImpl.findAllSubjects();
            TestDAOImpl testDAOImpl = new TestDAOImpl();
            tests = testDAOImpl.findAllTests();

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

            // pagination
            int page = 1;
            int recordsPerPage = 7;
            int totalCountOfPages = (int) Math.ceil(tests.size() * 1.0 / recordsPerPage);

            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }

            int fromIndex = (page - 1) * recordsPerPage;
            int toIndex = fromIndex + recordsPerPage;
            List<Test> resultList = new ArrayList<>();

            if (toIndex <= tests.size()) {
                resultList = tests.subList(fromIndex, toIndex);
            } else {
                resultList = tests.subList(fromIndex, tests.size());
            }

            request.setAttribute("currentPage", page);
            request.setAttribute("totalCountOfPages", totalCountOfPages);
            request.setAttribute("testsList", resultList);
            request.getRequestDispatcher(Path.STUDENT_TESTS_PAGE).forward(request, response);
        } else {
            //error-page
        }
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