package Tabor.DAO;

import Tabor.Model.Vybaveni;
import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.Join;
import jakarta.persistence.criteria.Root;
import jakarta.persistence.*;
import java.util.List;
import Tabor.Model.Uzivatel;

public class UzivatelDAO extends AbstractDAO<Uzivatel>{
	public UzivatelDAO() {
		super();
	}

	protected Class<Uzivatel> getEntityClass() {
		return Uzivatel.class;
	}

	public List<Vybaveni> getVybaveniUzivatele(String login) {
		CriteriaBuilder cb = manager.getCriteriaBuilder();
		CriteriaQuery<Vybaveni> query = cb.createQuery(Vybaveni.class);
		Root<Uzivatel> uzivatelRoot = query.from(Uzivatel.class);
		Join<Uzivatel, Vybaveni> vybaveniJoin = uzivatelRoot.join("vybaveni");

		query.select(vybaveniJoin).where(cb.equal(uzivatelRoot.get("login"), login));

		TypedQuery<Vybaveni> typedQuery = manager.createQuery(query);
		return typedQuery.getResultList();
	}

	public Uzivatel uzivatelByLogin (String login) {
		CriteriaBuilder cb = manager.getCriteriaBuilder();
		CriteriaQuery<Uzivatel> query = cb.createQuery(Uzivatel.class);
		Root<Uzivatel> root = query.from(Uzivatel.class);
		query.select(root).where(cb.equal(root.get("login"), login));
		TypedQuery<Uzivatel> typedQuery = manager.createQuery(query);
		return typedQuery.getSingleResult();
	}
}
