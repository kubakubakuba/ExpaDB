package Tabor.DAO;

import jakarta.persistence.*;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.persistence.criteria.Root;

import Tabor.App.Manager;
import Tabor.Model.*;

import java.util.List;

public class PrednaskaDAO extends AkceDAO{
	public PrednaskaDAO() {
		super();
	}

	public List<Prednaska> getPrednaskyBySkupina(Skupina skupina) {
		CriteriaBuilder cb = manager.getCriteriaBuilder();
		CriteriaQuery<Prednaska> query = cb.createQuery(Prednaska.class);
		Root<Prednaska> root = query.from(Prednaska.class);
		query.select(root).where(cb.equal(root.get("skupina"), skupina));
		List<Prednaska> result = manager.createQuery(query).getResultList();
		return result;
	}

}
