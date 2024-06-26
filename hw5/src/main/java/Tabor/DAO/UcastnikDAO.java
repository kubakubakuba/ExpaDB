package Tabor.DAO;
import Tabor.Model.*;

import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.Root;

import java.util.List;

public class UcastnikDAO extends UzivatelDAO{
	public UcastnikDAO() {
		super();
	}

	protected Class<Uzivatel> getEntityClass() {
		return Uzivatel.class;
	}

	public List<Ucastnik> getUcastnikBySkupina(Skupina skupina) {
		CriteriaBuilder cb = manager.getCriteriaBuilder();
		CriteriaQuery<Ucastnik> query = cb.createQuery(Ucastnik.class);
		Root<Ucastnik> root = query.from(Ucastnik.class);
		query.select(root).where(cb.equal(root.get("soucastiSkupiny"), skupina));
		List<Ucastnik> result = manager.createQuery(query).getResultList();
		return result;
	}
}
