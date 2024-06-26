package Tabor.Model;

import jakarta.persistence.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

@Entity
@Table(name = "pomahaorganizovat")
public class Pomahaorganizovat {
    @EmbeddedId
    private PomahaorganizovatId id;

    @MapsId("idUzivatel")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "id_uzivatel", nullable = false)
    private Ucastnik idUzivatel;

    @MapsId("idAkce")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "id_akce", nullable = false)
    private Workshop idAkce;

    public PomahaorganizovatId getId() {
        return id;
    }

    public void setId(PomahaorganizovatId id) {
        this.id = id;
    }

    public Ucastnik getIdUzivatel() {
        return idUzivatel;
    }

    public void setIdUzivatel(Ucastnik idUzivatel) {
        this.idUzivatel = idUzivatel;
    }

    public Workshop getIdAkce() {
        return idAkce;
    }

    public void setIdAkce(Workshop idAkce) {
        this.idAkce = idAkce;
    }

}