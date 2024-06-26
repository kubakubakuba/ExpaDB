package Tabor.DAO;

import jakarta.persistence.*;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.persistence.criteria.Root;

import Tabor.App.Manager;
import Tabor.Model.*;

import java.util.List;

public class VedouciDAO extends UzivatelDAO{
	public VedouciDAO() {
		super();
	}

	public List<Vedouci> getVedouciBySkupina(Skupina skupina) {
		CriteriaBuilder cb = manager.getCriteriaBuilder();
		CriteriaQuery<Vedouci> query = cb.createQuery(Vedouci.class);
		Root<Vedouci> root = query.from(Vedouci.class);
		query.select(root).where(cb.equal(root.get("soucastiSkupiny"), skupina));
		List<Vedouci> result = manager.createQuery(query).getResultList();
		return result;
	}

	public Vedouci vedouciByLogin (String login) {
		CriteriaBuilder cb = manager.getCriteriaBuilder();
		CriteriaQuery<Vedouci> query = cb.createQuery(Vedouci.class);
		Root<Vedouci> root = query.from(Vedouci.class);
		query.select(root).where(cb.equal(root.get("login"), login));
		Vedouci result = manager.createQuery(query).getSingleResult();
		return result;
	}
}
