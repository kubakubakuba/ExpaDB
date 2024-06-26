package Tabor.App;
import Tabor.DAO.*;
import Tabor.Model.*;

import java.util.List;
import java.math.BigDecimal;
import java.time.Instant;

import org.hibernate.annotations.ColumnDefault;

import jakarta.persistence.Column;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToMany;
import Tabor.App.Util;


import static java.lang.String.format;

public class Main {
	private static Util util = new Util();
	private static EntityFactory ef = new EntityFactory();

	private static void vybaveniByUsername(String username){
		System.out.println("Vybavení uživatele: " + username);
		UcastnikDAO ucastnik = new UcastnikDAO();
		List<Vybaveni> vybaveni = ucastnik.getVybaveniUzivatele(username);
		
		vybaveni.forEach(v -> {
			BigDecimal cena = v.getCena();
			String majitel = v.getMajitel();
			String nazev = v.getNazev();

			System.out.println(format("používá vybavení: %s, s cenou %s, od %s", nazev, cena ==  null ? "-" : cena, majitel == null ? "-" : majitel));
		});
	}

	private static void ucastniciVybaveni(Integer num) {
		UcastnikDAO ucastnik = new UcastnikDAO();

		List<Uzivatel> uzivatele = ucastnik.getRandomNumOf(num);

		uzivatele.forEach(u -> {
			//System.out.println(format("Uživatel: %s", u.getLogin()));
			//System.out.println(u.getLogin());
			vybaveniByUsername(u.getLogin());
		});
	}

	private static void createUserWithToolTransaction(Uzivatel u, Vybaveni v) {
		UzivatelDAO uzivatelDAO = new UzivatelDAO();
		VybaveniDAO vybaveniDAO = new VybaveniDAO();
		EntityTransaction transaction = null;
	
		try {
			transaction = uzivatelDAO.manager.getTransaction();
			transaction.begin();
	
			uzivatelDAO.create(u);
			vybaveniDAO.create(v);
	
			Pouziva pouziva = new Pouziva();
			pouziva.setUzivatel(u);
			pouziva.setVybaveni(v);
			pouziva.setId(new PouzivaId(u.getId(), v.getId()));
	
			uzivatelDAO.manager.persist(pouziva);
	
			transaction.commit();
		} catch (Exception e) {
			if (transaction != null && transaction.isActive()) {
				transaction.rollback();
			}
			System.err.println("Vytvoření uživatele selhalo: " + e.getMessage());
		}
	}
	
	//create a group an uzivatel and a leader, a workshop and assign the workshop as mandantory to the group
	//assign the leader as the organiser, assign the user as the helper when organising
	//create n polozky programu

	public static void deleteVybaveni(String inventarniCislo){
		VybaveniDAO vybaveniDAO = new VybaveniDAO();
		Vybaveni v = vybaveniDAO.vybaveniByInventarniCislo(inventarniCislo);
		vybaveniDAO.delete(v);
	}

	public static void printVybaveniByNazev(String nazev){
		try {
			VybaveniDAO vybaveniDAO = new VybaveniDAO();
			Vybaveni v = vybaveniDAO.vybaveniByNazev(nazev);
			util.print(v);
		} catch (Exception e) {
			System.out.println("Vybaveni s nazvem " + nazev + " neexistuje.");
		}
	}

	public static void printVybaveniByInventarniCislo(String inventarniCislo){
		try {
			VybaveniDAO vybaveniDAO = new VybaveniDAO();
			Vybaveni v = vybaveniDAO.vybaveniByInventarniCislo(inventarniCislo);
			util.print(v);
		} catch (Exception e) {
			System.out.println("Vybaveni s inventarnim cislem " + inventarniCislo + " neexistuje.");
		}
	}

	public static void createVybaveni(String inventarniCislo, String nazev, BigDecimal cena, String majitel){
		VybaveniDAO vybaveniDAO = new VybaveniDAO();
		Vybaveni v = ef.__Vybaveni__(inventarniCislo, nazev, cena, majitel);
		vybaveniDAO.create(v);
	}

	public static void renameVybaveni(String inventarniCislo, String nazev){
		VybaveniDAO vybaveniDAO = new VybaveniDAO();
		Vybaveni v = vybaveniDAO.vybaveniByInventarniCislo(inventarniCislo);
		v.setNazev(nazev);
		vybaveniDAO.update(v);
	}

	public static void printAllGroups(){
		SkupinaDAO skupinaDAO = new SkupinaDAO();
		List<Skupina> skupiny = skupinaDAO.getAll();
		skupiny.forEach(s -> {
			util.print(s);
		});
	}

	public static void printUsersInGroup(String groupName){
		System.out.println(format("Uživatelé ve skupině %s:", groupName));
		SkupinaDAO skupinaDAO = new SkupinaDAO();
		Skupina s = skupinaDAO.skupinaByJmeno(groupName);
		List<Uzivatel> uzivatele = skupinaDAO.getUzivateleSkupiny(s);
		uzivatele.forEach(u -> {
			util.printName(u);
		});
	}

	public static void printPovineAkceProSkupiny(String groupName){
		System.out.println(format("Povinné akce pro skupinu %s:", groupName));
		SkupinaDAO skupinaDAO = new SkupinaDAO();
		Skupina s = skupinaDAO.skupinaByJmeno(groupName);
		List<Akce> akce = skupinaDAO.getPovinneAkceSkupiny(s);
		akce.forEach(a -> {
			util.print(a);
		});
	
	}

	public static void listVybaveniSCenouVetsiNez(Double cena){
		VybaveniDAO vybaveniDAO = new VybaveniDAO();
		List<Vybaveni> vybaveni = vybaveniDAO.getVybaveniSCenouVetsiNez(cena);
		vybaveni.forEach(v -> {
			util.print(v);
		});
	
	}

	public static void main(String[] args) {
		
			ucastniciVybaveni(2);
			vybaveniByUsername("svetlanajarosova_558i");

		
			Uzivatel u = ef.__Uzivatel__("asdasdtest1", "Tester 1", "test@email.com", "heslo", 12345, "123456789", "Mesto", "Ulice");
			Vybaveni v = ef.__Vybaveni__("A123456", "Testovaci vybaveni", new BigDecimal(1000), "asdasdtest1");

			createUserWithToolTransaction(u, v);

			vybaveniByUsername("asdasdtest1");
		
			UzivatelDAO uzivatelDAO = new UzivatelDAO();
			Uzivatel u2 = uzivatelDAO.uzivatelByLogin("asdasdtest1");
			util.print(u2);

		//create and delete
		
			createVybaveni("TEST123", "Testovaci vybaveni 123", new BigDecimal(100000), "testing");
			printVybaveniByInventarniCislo("TEST123");
			deleteVybaveni("TEST123");
			printVybaveniByInventarniCislo("TEST123");

		//change name
		
			createVybaveni("TEST456", "Testovaci vybaveni 456", new BigDecimal(100000), "testing");
			printVybaveniByInventarniCislo("TEST456");
			renameVybaveni("TEST456", "Testovaci vybaveni 456 - upraveno");
			printVybaveniByInventarniCislo("TEST456");
			deleteVybaveni("TEST456");
			printVybaveniByInventarniCislo("TEST456");

		//groups
		
			printAllGroups();
			printUsersInGroup("Začátečníci");
			printPovineAkceProSkupiny("Začátečníci");

		//price bigger than
		
			listVybaveniSCenouVetsiNez(49950.0);
	}
}
