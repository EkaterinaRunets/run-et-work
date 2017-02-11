package by.bsuir.runets.runetwork.filter;

import org.springframework.util.StringUtils;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


public class AuthorizationFilter extends OncePerRequestFilter {

    public static final String HEADER_AUTH_KEY = "Authkey";
    public static final String COOKIE_AUTH_KEY = "Authkey";

    @Override
    protected void doFilterInternal(HttpServletRequest httpServletRequest,
                                    HttpServletResponse httpServletResponse,
                                    FilterChain filterChain)

            throws ServletException, IOException {

        boolean loginRequest = isLoginRequest(httpServletRequest);
        String token = extractAuthToken(httpServletRequest);
        if (loginRequest == false && StringUtils.isEmpty(token)) {
            httpServletResponse.sendRedirect("/ui/login.html");
            return;
        }
        filterChain.doFilter(httpServletRequest, httpServletResponse);

    }

    private boolean isLoginRequest(HttpServletRequest httpServletRequest) {
        return httpServletRequest.getRequestURI().startsWith("/ui/login.html") ||
                httpServletRequest.getRequestURI().startsWith("/ui/dologin");
    }

    protected String extractAuthToken(HttpServletRequest httpServletRequest) {
        String header = httpServletRequest.getHeader(HEADER_AUTH_KEY);
        if (StringUtils.isEmpty(header) == false) {
            return header;
        }
        Cookie[] cookies = httpServletRequest.getCookies();
        if (cookies == null || cookies.length == 0) {
            return null;
        }
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals(COOKIE_AUTH_KEY) == false) {
                continue;
            }
            return cookie.getValue();
        }
        return header;
    }
}
