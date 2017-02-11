package by.bsuir.runets.runetwork.core.database.dao;

import by.bsuir.runets.runetwork.core.database.model.User;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public class UserDao extends AbstractDao<User> {

    @Autowired
    public UserDao(SessionFactory sessionFactory) {
        super(sessionFactory, User.class);
    }

    @Override
    public List<User> findAll() {
        List<User> users = super.findAll();
        for (User user : users) {
            user.getContacts().isEmpty();
        }
        return users;
    }
}
