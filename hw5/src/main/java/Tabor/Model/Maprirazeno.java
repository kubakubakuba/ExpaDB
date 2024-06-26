package Tabor.Model;

import jakarta.persistence.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

@Entity
@Table(name = "maprirazeno")
public class Maprirazeno {
    @EmbeddedId
    private MaprirazenoId id;

    @MapsId("idSkupina")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "id_skupina", nullable = false)
    private Skupina idSkupina;

    @MapsId("idVybaveni")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "id_vybaveni", nullable = false)
    private Vybaveni idVybaveni;

    public MaprirazenoId getId() {
        return id;
    }

    public void setId(MaprirazenoId id) {
        this.id = id;
    }

    public Skupina getIdSkupina() {
        return idSkupina;
    }

    public void setIdSkupina(Skupina idSkupina) {
        this.idSkupina = idSkupina;
    }

    public Vybaveni getIdVybaveni() {
        return idVybaveni;
    }

    public void setIdVybaveni(Vybaveni idVybaveni) {
        this.idVybaveni = idVybaveni;
    }

}