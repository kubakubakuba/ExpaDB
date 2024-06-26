package Tabor.Model;

import jakarta.persistence.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

@Entity
@Table(name = "organizuje")
public class Organizuje {
    @EmbeddedId
    private OrganizujeId id;

    @MapsId("idUzivatel")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "id_uzivatel", nullable = false)
    private Vedouci idUzivatel;

    @MapsId("idAkce")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "id_akce", nullable = false)
    private Workshop idAkce;

    public OrganizujeId getId() {
        return id;
    }

    public void setId(OrganizujeId id) {
        this.id = id;
    }

    public Vedouci getIdUzivatel() {
        return idUzivatel;
    }

    public void setIdUzivatel(Vedouci idUzivatel) {
        this.idUzivatel = idUzivatel;
    }

    public Workshop getIdAkce() {
        return idAkce;
    }

    public void setIdAkce(Workshop idAkce) {
        this.idAkce = idAkce;
    }

}