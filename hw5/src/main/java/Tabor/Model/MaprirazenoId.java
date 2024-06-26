package Tabor.Model;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import org.hibernate.Hibernate;

import java.util.Objects;

@Embeddable
public class MaprirazenoId implements java.io.Serializable {
    private static final long serialVersionUID = 2904309341288169202L;
    @Column(name = "id_skupina", nullable = false)
    private Integer idSkupina;

    @Column(name = "id_vybaveni", nullable = false)
    private Integer idVybaveni;

    public Integer getIdSkupina() {
        return idSkupina;
    }

    public void setIdSkupina(Integer idSkupina) {
        this.idSkupina = idSkupina;
    }

    public Integer getIdVybaveni() {
        return idVybaveni;
    }

    public void setIdVybaveni(Integer idVybaveni) {
        this.idVybaveni = idVybaveni;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        MaprirazenoId entity = (MaprirazenoId) o;
        return Objects.equals(this.idSkupina, entity.idSkupina) &&
                Objects.equals(this.idVybaveni, entity.idVybaveni);
    }

    @Override
    public int hashCode() {
        return Objects.hash(idSkupina, idVybaveni);
    }

}