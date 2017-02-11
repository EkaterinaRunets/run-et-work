package by.bsuir.runets.runetwork.core.database.dao;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.util.List;

@Transactional
public abstract class AbstractDao<T> implements DAO<T> {

    private static final Logger logger = LoggerFactory.getLogger(AbstractDao.class);

    protected SessionFactory sessionFactory;
    protected final Class<T> entityClass;

    public AbstractDao(SessionFactory sessionFactory, Class<T> entityClass) {
        this.sessionFactory = sessionFactory;
        this.entityClass = entityClass;
    }

    @Override
    public T findById(Serializable id) {
        try {
            return sessionFactory.getCurrentSession().load(entityClass, id);
        } catch (Throwable e) {
            logger.error("Could not find entity {} by id {} ", entityClass, id);
            return null;
        }
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<T> findAll() {
        try {
            Criteria criteria = sessionFactory.getCurrentSession().createCriteria(entityClass);
            List list = criteria.list();
            return list;
        } catch (Throwable e) {
            logger.error("Could not find entities of type {} ", entityClass);
            return null;
        }
    }

    @Override
    public void save(T entity) {
        try {
            sessionFactory.getCurrentSession().save(entity);
        } catch (Throwable e) {
            logger.error("Could not save entity {}", entityClass);
        }
    }

    @Override
    public void delete(T entity) {
        try {
            sessionFactory.getCurrentSession().delete(entity);
        } catch (Throwable e) {
            logger.error("Could not delete entity {}", entityClass);
        }
    }
}
