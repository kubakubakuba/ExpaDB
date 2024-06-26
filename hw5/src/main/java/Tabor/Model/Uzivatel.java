package Tabor.Model;

import jakarta.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "uzivatel")
@Inheritance(strategy = InheritanceType.JOINED)
public class Uzivatel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_uzivatel", nullable = false)
    private Integer id;

    @Column(name = "login", nullable = false, length = 64)
    private String login;

    @Column(name = "heslo", nullable = false, length = 128)
    private String heslo;

    @Column(name = "salt", nullable = false, length = 32)
    private String salt;

    @Column(name = "jmeno", length = 64)
    private String jmeno;

    @Column(name = "email", length = 64)
    private String email;

    @Column(name = "telefon", length = 23)
    private String telefon;

    @Column(name = "psc")
    private Integer psc;

    @Column(name = "mesto", length = 64)
    private String mesto;

    @Column(name = "ulice", length = 64)
    private String ulice;

    @Column(name = "cislo", length = 16)
    private String cislo;

    @ManyToMany
    @JoinTable(
        name = "pouziva",
        joinColumns = @JoinColumn(name = "id_uzivatel"),
        inverseJoinColumns = @JoinColumn(name = "id_vybaveni")
    )
    private Set<Vybaveni> vybaveni = new HashSet<>();

    // Getters and setters...

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getHeslo() {
        return heslo;
    }

    public void setHeslo(String heslo) {
        this.heslo = heslo;
    }

    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt;
    }

    public String getJmeno() {
        return jmeno;
    }

    public void setJmeno(String jmeno) {
        this.jmeno = jmeno;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTelefon() {
        return telefon;
    }

    public void setTelefon(String telefon) {
        this.telefon = telefon;
    }

    public Integer getPsc() {
        return psc;
    }

    public void setPsc(Integer psc) {
        this.psc = psc;
    }

    public String getMesto() {
        return mesto;
    }

    public void setMesto(String mesto) {
        this.mesto = mesto;
    }

    public String getUlice() {
        return ulice;
    }

    public void setUlice(String ulice) {
        this.ulice = ulice;
    }

    public String getCislo() {
        return cislo;
    }

    public void setCislo(String cislo) {
        this.cislo = cislo;
    }

    public Set<Vybaveni> getVybaveni() {
        return vybaveni;
    }

    public void setVybaveni(Set<Vybaveni> vybaveni) {
        this.vybaveni = vybaveni;
    }
}
