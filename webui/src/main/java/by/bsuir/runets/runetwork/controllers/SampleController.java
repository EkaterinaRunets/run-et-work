package by.bsuir.runets.runetwork.controllers;

import by.bsuir.runets.runetwork.configuration.WebAppConfiguration;
import by.bsuir.runets.runetwork.core.Core;
import by.bsuir.runets.runetwork.core.database.dao.UserDao;
import by.bsuir.runets.runetwork.core.database.model.User;
import by.bsuir.runets.runetwork.filter.AuthorizationFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.annotation.Import;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.UUID;

@Import({
        Core.class,
        WebAppConfiguration.class
})
@Controller
@EnableAutoConfiguration
public class SampleController {

    @Autowired
    protected UserDao userDao;

    // TODO: remove me. Temporal for testing
    private Set<String> tokens = new HashSet<String>();

    @RequestMapping("/")
    public void home(HttpServletResponse response) {
        try {
            response.sendRedirect("/index.html");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "/ui/dologin", method = RequestMethod.POST)
    public void uiLogin(@RequestParam("username") String username,
                        @RequestParam("password") String password,
                        HttpServletResponse response) throws IOException {

        if (username.equals("test") && password.equals("test")) {
            String token = UUID.randomUUID().toString();
            tokens.add(token);
            Cookie cookie = new Cookie(AuthorizationFilter.COOKIE_AUTH_KEY, token);
            response.addCookie(cookie);
            response.sendRedirect("/ui/home.html");
            return;
        }
        response.sendRedirect("/ui/login.html");
    }

    @RequestMapping(value = "/get-users", method = RequestMethod.GET)
    public @ResponseBody List<User> getUsers() {
        return userDao.findAll();
    }

    public static void main(String[] args) throws Exception {
        SpringApplication.run(SampleController.class, args);
    }
}