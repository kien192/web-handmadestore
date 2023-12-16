package model.service;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import java.io.IOException;

@WebFilter(urlPatterns = "/*")
public class CounterFilter implements Filter {
    private boolean first_access = true;
    private int counnt;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        counnt = 0;
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        if (first_access == true) {
            counnt++;
            first_access = false;

        }
        filterChain.doFilter(servletRequest, servletResponse);
    }

    @Override
    public void destroy() {

    }
}
