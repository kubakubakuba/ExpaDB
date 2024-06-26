package Tabor.Model;

import jakarta.persistence.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

@Entity
@Table(name = "jepovinna")
public class Jepovinna {
    @EmbeddedId
    private JepovinnaId id;

    @MapsId("idAkce")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "id_akce", nullable = false)
    private Akce idAkce;

    @MapsId("idSkupina")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "id_skupina", nullable = false)
    private Skupina idSkupina;

    public JepovinnaId getId() {
        return id;
    }

    public void setId(JepovinnaId id) {
        this.id = id;
    }

    public Akce getIdAkce() {
        return idAkce;
    }

    public void setIdAkce(Akce idAkce) {
        this.idAkce = idAkce;
    }

    public Skupina getIdSkupina() {
        return idSkupina;
    }

    public void setIdSkupina(Skupina idSkupina) {
        this.idSkupina = idSkupina;
    }

}