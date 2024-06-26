package Tabor.DAO;

import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.*;

import Tabor.App.Manager;
import Tabor.Model.Vybaveni;

import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.persistence.criteria.Root;

import java.util.List;

import Tabor.App.Manager;
import Tabor.Model.Vybaveni;


public class VybaveniDAO extends AbstractDAO<Vybaveni>{
	public VybaveniDAO() {
		super();
	}

	protected Class<Vybaveni> getEntityClass() {
		return Vybaveni.class;
	}

	public Vybaveni vybaveniByNazev (String nazev) {
		CriteriaBuilder cb = manager.getCriteriaBuilder();
		CriteriaQuery<Vybaveni> query = cb.createQuery(Vybaveni.class);
		Root<Vybaveni> root = query.from(Vybaveni.class);
		query.select(root).where(cb.equal(root.get("nazev"), nazev));
		Vybaveni result = manager.createQuery(query).getSingleResult();
		return result;
	}

	public Vybaveni vybaveniByInventarniCislo (String inventarniCislo) {
		CriteriaBuilder cb = manager.getCriteriaBuilder();
		CriteriaQuery<Vybaveni> query = cb.createQuery(Vybaveni.class);
		Root<Vybaveni> root = query.from(Vybaveni.class);
		query.select(root).where(cb.equal(root.get("inventarniCislo"), inventarniCislo));
		Vybaveni result = manager.createQuery(query).getSingleResult();
		return result;
	}
	
	public List<Vybaveni> getVybaveniSCenouVetsiNez (Double cena) {
		CriteriaBuilder cb = manager.getCriteriaBuilder();
		CriteriaQuery<Vybaveni> query = cb.createQuery(Vybaveni.class);
		Root<Vybaveni> root = query.from(Vybaveni.class);
		query.select(root).where(cb.greaterThan(root.get("cena"), cena));
		List<Vybaveni> result = manager.createQuery(query).getResultList();
		return result;
	}
}
