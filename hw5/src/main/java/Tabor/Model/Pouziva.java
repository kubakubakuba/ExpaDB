package Tabor.Model;

import jakarta.persistence.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

@Entity
@Table(name = "pouziva")
public class Pouziva {

    @EmbeddedId
    private PouzivaId id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @MapsId("idUzivatel")
    @JoinColumn(name = "id_uzivatel", nullable = false)
    private Uzivatel uzivatel;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @MapsId("idVybaveni")
    @JoinColumn(name = "id_vybaveni", nullable = false)
    private Vybaveni vybaveni;

    public PouzivaId getId() {
        return id;
    }

    public void setId(PouzivaId id) {
        this.id = id;
    }

    public Uzivatel getUzivatel() {
        return uzivatel;
    }

    public void setUzivatel(Uzivatel uzivatel) {
        this.uzivatel = uzivatel;
    }

    public Vybaveni getVybaveni() {
        return vybaveni;
    }

    public void setVybaveni(Vybaveni vybaveni) {
        this.vybaveni = vybaveni;
    }
}
