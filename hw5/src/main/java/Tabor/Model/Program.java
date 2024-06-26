package Tabor.Model;

import jakarta.persistence.*;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.time.Instant;

@Entity
@Table(name = "program")
public class Program {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_program", nullable = false)
    private Integer id;

    @Column(name = "cas_polozky", nullable = false)
    private Instant casPolozky;

    @Column(name = "nazev", nullable = false, length = 64)
    private String nazev;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "id_akce", nullable = false)
    private Workshop idAkce;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Instant getCasPolozky() {
        return casPolozky;
    }

    public void setCasPolozky(Instant casPolozky) {
        this.casPolozky = casPolozky;
    }

    public String getNazev() {
        return nazev;
    }

    public void setNazev(String nazev) {
        this.nazev = nazev;
    }

    public Workshop getIdAkce() {
        return idAkce;
    }

    public void setIdAkce(Workshop idAkce) {
        this.idAkce = idAkce;
    }

}