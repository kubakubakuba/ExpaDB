package Tabor.DAO;

import jakarta.persistence.*;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.persistence.criteria.Root;

import Tabor.App.Manager;
import Tabor.Model.*;

import java.util.List;

public class ProgramDAO extends AbstractDAO<Program>{
	public ProgramDAO() {
		super();
	}

	protected Class<Program> getEntityClass() {
		return Program.class;
	}

	
}
