package Tabor.Model;

import jakarta.persistence.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

@Entity
@Table(name = "seucastni")
public class Seucastni {
    @EmbeddedId
    private SeucastniId id;

    @MapsId("idUzivatel")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "id_uzivatel", nullable = false)
    private Ucastnik idUzivatel;

    @MapsId("idAkce")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "id_akce", nullable = false)
    private Akce idAkce;

    public SeucastniId getId() {
        return id;
    }

    public void setId(SeucastniId id) {
        this.id = id;
    }

    public Ucastnik getIdUzivatel() {
        return idUzivatel;
    }

    public void setIdUzivatel(Ucastnik idUzivatel) {
        this.idUzivatel = idUzivatel;
    }

    public Akce getIdAkce() {
        return idAkce;
    }

    public void setIdAkce(Akce idAkce) {
        this.idAkce = idAkce;
    }

}