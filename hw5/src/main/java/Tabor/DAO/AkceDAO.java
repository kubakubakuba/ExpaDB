package Tabor.DAO;

import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.persistence.criteria.Root;

import Tabor.Model.*;

import java.util.List;


public class AkceDAO extends AbstractDAO<Akce>{
	public AkceDAO() {
		super();
	}

	public Class<Akce> getEntityClass() {
		return Akce.class;
	}

	public List<Akce> getAkceBySkupina(Skupina skupina) {
		CriteriaBuilder cb = manager.getCriteriaBuilder();
		CriteriaQuery<Akce> query = cb.createQuery(Akce.class);
		Root<Akce> root = query.from(Akce.class);
		query.select(root).where(cb.equal(root.get("skupina"), skupina));
		List<Akce> result = manager.createQuery(query).getResultList();
		return result;
	}

	public List<Akce> getAkceByUzivatel(Uzivatel uzivatel) {
		CriteriaBuilder cb = manager.getCriteriaBuilder();
		CriteriaQuery<Akce> query = cb.createQuery(Akce.class);
		Root<Akce> root = query.from(Akce.class);
		query.select(root).where(cb.equal(root.get("uzivatel"), uzivatel));
		List<Akce> result = manager.createQuery(query).getResultList();
		return result;
	}
}
