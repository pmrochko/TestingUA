package com.myproject.testingua.controllers.servlets.student;

import com.myproject.testingua.DataBase.DAO.impl.SubjectDAOImpl;
import com.myproject.testingua.DataBase.DAO.impl.TestDAOImpl;
import com.myproject.testingua.DataBase.DBException;
import com.myproject.testingua.controllers.Path;
import com.myproject.testingua.models.entity.Subject;
import com.myproject.testingua.models.entity.Test;
import com.myproject.testingua.models.sorting.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
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
            subjects = new SubjectDAOImpl().findAllSubjects();
            tests = new TestDAOImpl().findAllTests();

            String selectedSubject = request.getParameter("selectedSubject");
            if (selectedSubject == null) {
                selectedSubject = (String) session.getAttribute("selectedSubject");
            } else {
                session.setAttribute("selectedSubject", selectedSubject);
            }

            if (selectedSubject != null && !selectedSubject.isBlank() && !selectedSubject.equals("All")) {
                String finalSelectedSubject = selectedSubject;
                tests = tests.stream()
                        .filter(t -> t.getSubject().getName().equals(finalSelectedSubject))
                        .collect(Collectors.toList());
            }

            String selectedSort = request.getParameter("selectedSort");
            if (selectedSort == null) {
                selectedSort = (String) session.getAttribute("selectedSort");
            } else {
                session.setAttribute("selectedSort", selectedSort);
            }

            /*if (selectedSort != null && !selectedSort.isBlank()) {
                switch (selectedSort){
                    case "subjectUp": tests.sort(new SortByTestSubject()); break;
                    case "subjectDown": tests.sort(new SortByTestSubject().reversed()); break;
                    case "titleUp": tests.sort(new SortByTestTitle()); break;
                    case "titleDown": tests.sort(new SortByTestTitle().reversed()); break;
                    case "difficultyUp": tests.sort(new SortByTestDifficulty()); break;
                    case "difficultyDown": tests.sort(new SortByTestDifficulty().reversed()); break;
                    case "questionUp": tests.sort(new SortByTestQuestion()); break;
                    case "questionDown": tests.sort(new SortByTestQuestion().reversed()); break;
                    case "timeUp": tests.sort(new SortByTestTime()); break;
                    case "timeDown": tests.sort(new SortByTestTime().reversed()); break;
                }
            }*/
        } catch (DBException e) {
            session.setAttribute("errorMessage", e.getMessage());
            session.setAttribute("prevPage", getServletContext().getContextPath());
            response.sendRedirect("/error");
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
            List<Test> resultList;

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
            session.setAttribute("errorMessage", "tests or subjects = null");
            session.setAttribute("prevPage", getServletContext().getContextPath());
            response.sendRedirect("/error");
        }
    }

    private void sortingTests(List<Test> tests, String selectedSortBy) {

        if (selectedSortBy != null && !selectedSortBy.isBlank() && tests != null) {

            switch (selectedSortBy){
                case "subjectUp":
                    tests.sort(new SortByTestSubject());
                    break;
                case "subjectDown":
                    tests.sort(new SortByTestSubject().reversed());
                    break;
                case "titleUp":
                    tests.sort(new SortByTestTitle());
                    break;
                case "titleDown":
                    tests.sort(new SortByTestTitle().reversed());
                    break;
                case "difficultyUp":
                    tests.sort(new SortByTestDifficulty());
                    break;
                case "difficultyDown":
                    tests.sort(new SortByTestDifficulty().reversed());
                    break;
                case "questionUp":
                    tests.sort(new SortByTestQuestion());
                    break;
                case "questionDown":
                    tests.sort(new SortByTestQuestion().reversed());
                    break;
                case "timeUp":
                    tests.sort(new SortByTestTime());
                    break;
                case "timeDown":
                    tests.sort(new SortByTestTime().reversed());
                    break;
            }
        }
    }

}