package by.bsuir.runets.runetwork.core.database.dao;

import javax.transaction.Transactional;
import java.io.Serializable;
import java.util.List;

public interface DAO<T> {

    /**
     * Finds entity by it id
     * @param id the id of entity
     * @return found entity otherwise {@code null}
     */
    T findById(Serializable id);

    /**
     * Returns all entities found in database
     * @return list found entity otherwise empty list
     */
    List<T> findAll();

    /**
     * Saves entity into database
     */
    void save (T entity);

    /**
     * Removes entity from database
     */
    void delete (T entity);
}
