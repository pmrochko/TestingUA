package com.myproject.testingua.controllers.filters;

import com.myproject.testingua.controllers.Path;
import com.myproject.testingua.models.entity.User;
import com.myproject.testingua.models.enums.UserRole;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.net.http.HttpRequest;

@WebFilter(filterName = "AdminSecurityFilter")
public class AdminSecurityFilter implements Filter {

    public void init(FilterConfig config) throws ServletException {
    }

    public void destroy() {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {

        HttpServletRequest httpServletRequest = (HttpServletRequest) request;
        HttpSession session = httpServletRequest.getSession();

        if (accessAllowed(request)) {
            chain.doFilter(request, response);
        } else {
            session.setAttribute("errorMessage", "You are not admin");
            request.getRequestDispatcher(Path.ERROR_PAGE).forward(request, response);
        }

    }

    private boolean accessAllowed(ServletRequest request) {

        HttpServletRequest httpServletRequest = (HttpServletRequest) request;
        HttpSession session = httpServletRequest.getSession();
        User user = (User) session.getAttribute("currentUser");

        if (user != null) {

            UserRole role = user.getRole();
            return role == UserRole.ADMIN;

        }

        return false;
    }

}