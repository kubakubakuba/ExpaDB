package Tabor.DAO;

import jakarta.persistence.*;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.persistence.criteria.Root;

import Tabor.App.Manager;
import Tabor.Model.*;

import java.util.List;

public class SkupinaDAO extends AbstractDAO<Skupina>{
	public SkupinaDAO() {
		super();
	}

	protected Class<Skupina> getEntityClass() {
		return Skupina.class;
	}

	public Skupina skupinaByJmeno(String jmeno) {
		CriteriaBuilder cb = manager.getCriteriaBuilder();
		CriteriaQuery<Skupina> query = cb.createQuery(Skupina.class);
		Root<Skupina> root = query.from(Skupina.class);
		query.select(root).where(cb.equal(root.get("jmeno"), jmeno));
		Skupina result = manager.createQuery(query).getSingleResult();
		return result;
	}

	public List<Uzivatel> getUzivateleSkupiny (Skupina skupina) {
		CriteriaBuilder cb = manager.getCriteriaBuilder();
		CriteriaQuery<Uzivatel> query = cb.createQuery(Uzivatel.class);
		Root<Uzivatel> root = query.from(Uzivatel.class);
		query.select(root).where(cb.equal(root.get("soucastiSkupiny"), skupina));
		List<Uzivatel> result = manager.createQuery(query).getResultList();
		return result;
	}

	public List<Akce> getPovinneAkceSkupiny (Skupina skupina) {
		CriteriaBuilder cb = manager.getCriteriaBuilder();
		CriteriaQuery<Akce> query = cb.createQuery(Akce.class);
		Root<Jepovinna> root = query.from(Jepovinna.class);
		query.select(root.get("idAkce")).where(cb.equal(root.get("idSkupina"), skupina));
		List<Akce> result = manager.createQuery(query).getResultList();
		return result;
	}
}
