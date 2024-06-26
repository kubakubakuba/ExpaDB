package Tabor.App;

import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.EntityManager;

public class Manager {
    //create entity manager factory
    private static final EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("TaborPU");
    private static final EntityManager entityManager = entityManagerFactory.createEntityManager();

    public static EntityManagerFactory getEntityManagerFactory() {
        return entityManagerFactory;
    }

    public static void close() {
        entityManagerFactory.close();
    }

    public EntityManager getEntityManager() {
        return entityManager;
    }
}
