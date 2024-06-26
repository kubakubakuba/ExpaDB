package Tabor.App;

import Tabor.Model.*;
import java.math.BigDecimal;
import java.time.Instant;

import Tabor.App.Util;

public class EntityFactory {
	private static Util util = new Util();

	public EntityFactory() {
	}

	public Uzivatel __Uzivatel__(String login, String jmeno, String email, String heslo, Integer psc, String tel, String mesto, String ulice) {
		Uzivatel u = new Uzivatel();
		u.setLogin(login);
		u.setJmeno(jmeno);
		u.setEmail(email);
		u.setCislo(tel);
		u.setPsc(psc);
		u.setMesto(mesto);
		u.setUlice(ulice);
		
		//hash sha256 the password
		u.setSalt(util.getRandomHexString(16));
		u.setHeslo(util.hashPassword(heslo, u.getSalt()));
		
		return u;
	}

	public Ucastnik __Ucastnik__(String login, String jmeno, String email, String heslo, Integer psc, String tel, String mesto, String ulice) {
		Ucastnik u = new Ucastnik();
		u.setLogin(login);
		u.setJmeno(jmeno);
		u.setEmail(email);
		u.setCislo(tel);
		u.setPsc(psc);
		u.setMesto(mesto);
		u.setUlice(ulice);
		
		//hash sha256 the password
		u.setSalt(util.getRandomHexString(16));
		u.setHeslo(util.hashPassword(heslo, u.getSalt()));
		
		return u;
	}

	public Vedouci __Vedouci__(){
		Vedouci v = new Vedouci();
		
		return v;
	}

	public Vybaveni __Vybaveni__(String inventarniCislo, String nazev, BigDecimal cena, String majitel) {
		Vybaveni v = new Vybaveni();
		v.setInventarniCislo(inventarniCislo);
		v.setNazev(nazev);
		v.setCena(cena);
		v.setMajitel(majitel);
		
		return v;
	}

	public Program __Program__(Instant cas_polozky, String nazev){
		Program p = new Program();
		p.setCasPolozky(cas_polozky);
		p.setNazev(nazev);
		return p;	
	}

	public Workshop __Workshop__(String nazev, String popis, Instant cas){
		Workshop w = new Workshop();
		w.setNazev(nazev);
		w.setPopis(popis);
		w.setCas(cas);
		return w;
	}

	public Vedouci __Vedouci__(Uzivatel u){
		Vedouci v = new Vedouci();
		v.setUzivatel(u);
		return v;
	}
}
