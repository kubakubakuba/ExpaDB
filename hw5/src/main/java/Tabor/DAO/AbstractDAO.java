package Tabor.DAO;

import jakarta.persistence.*;
import jakarta.persistence.criteria.CriteriaQuery;

import Tabor.App.Manager;

import java.util.List;

public abstract class AbstractDAO<T> {
	public EntityManager manager;

	public AbstractDAO() {
		this.manager = new Manager().getEntityManager();
	}

	protected abstract Class<T> getEntityClass();

	public List<T> getAll() {
		CriteriaQuery<T> query = manager.getCriteriaBuilder().createQuery(getEntityClass());
		query.select(query.from(getEntityClass()));
		List<T> result = manager.createQuery(query).getResultList();
		return result;
	}

	public List<T> getNumOf(int num) {
		CriteriaQuery<T> query = manager.getCriteriaBuilder().createQuery(getEntityClass());
		query.select(query.from(getEntityClass()));
		List<T> result = manager.createQuery(query).setMaxResults(num).getResultList();
		return result;
	}

	public List<T> getRandomNumOf(int num) {
		CriteriaQuery<Long> countQuery = manager.getCriteriaBuilder().createQuery(Long.class);
		countQuery.select(manager.getCriteriaBuilder().count(countQuery.from(getEntityClass())));
		Long count = manager.createQuery(countQuery).getSingleResult();

		CriteriaQuery<T> query = manager.getCriteriaBuilder().createQuery(getEntityClass());
		query.select(query.from(getEntityClass()));
		return manager.createQuery(query).setFirstResult((int) (Math.random() * count)).setMaxResults(num).getResultList();
	}

	public void create(T entity) {
		EntityTransaction transaction = manager.getTransaction();
		boolean isNewTransaction = false;
		
		try {
			if (!transaction.isActive()) {
				transaction.begin();
				isNewTransaction = true;
			}
			manager.persist(entity);
			if (isNewTransaction) {
				transaction.commit();
			}
		} catch (Exception e) {
			if (isNewTransaction && transaction.isActive()) {
				transaction.rollback();
			}
			throw e;
		}
	}

	public void update(T entity) {
		EntityTransaction transaction = manager.getTransaction();
		boolean isNewTransaction = false;
		
		try {
			if (!transaction.isActive()) {
				transaction.begin();
				isNewTransaction = true;
			}
			manager.merge(entity);
			if (isNewTransaction) {
				transaction.commit();
			}
		} catch (Exception e) {
			if (isNewTransaction && transaction.isActive()) {
				transaction.rollback();
			}
			throw e;
		}
	}

	public void delete(T entity) {
		EntityTransaction transaction = manager.getTransaction();
		boolean isNewTransaction = false;
		
		try {
			if (!transaction.isActive()) {
				transaction.begin();
				isNewTransaction = true;
			}
			manager.remove(entity);
			if (isNewTransaction) {
				transaction.commit();
			}
		} catch (Exception e) {
			if (isNewTransaction && transaction.isActive()) {
				transaction.rollback();
			}
			throw e;
		}
	}
}
