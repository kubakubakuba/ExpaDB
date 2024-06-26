package Tabor.Model;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "vybaveni")
public class Vybaveni {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_vybaveni", nullable = false)
    private Integer id;

    @Column(name = "inventarni_cislo", nullable = false, length = 64)
    private String inventarniCislo;

    @Column(name = "nazev", nullable = false, length = 64)
    private String nazev;

    @Column(name = "majitel", nullable = false, length = 64)
    private String majitel;

    @Column(name = "cena", precision = 10, scale = 2)
    private BigDecimal cena;

    @ManyToMany(mappedBy = "vybaveni")
    private Set<Uzivatel> uzivatelSet = new HashSet<>();

    // Getters and setters...

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getInventarniCislo() {
        return inventarniCislo;
    }

    public void setInventarniCislo(String inventarniCislo) {
        this.inventarniCislo = inventarniCislo;
    }

    public String getNazev() {
        return nazev;
    }

    public void setNazev(String nazev) {
        this.nazev = nazev;
    }

    public String getMajitel() {
        return majitel;
    }

    public void setMajitel(String majitel) {
        this.majitel = majitel;
    }

    public BigDecimal getCena() {
        return cena;
    }

    public void setCena(BigDecimal cena) {
        this.cena = cena;
    }

    public Set<Uzivatel> getUzivatelSet() {
        return uzivatelSet;
    }

    public void setUzivatelSet(Set<Uzivatel> uzivatelSet) {
        this.uzivatelSet = uzivatelSet;
    }
}
