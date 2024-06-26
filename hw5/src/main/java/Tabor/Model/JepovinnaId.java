package Tabor.Model;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import org.hibernate.Hibernate;

import java.util.Objects;

@Embeddable
public class JepovinnaId implements java.io.Serializable {
    private static final long serialVersionUID = 1755633730311413912L;
    @Column(name = "id_akce", nullable = false)
    private Integer idAkce;

    @Column(name = "id_skupina", nullable = false)
    private Integer idSkupina;

    public Integer getIdAkce() {
        return idAkce;
    }

    public void setIdAkce(Integer idAkce) {
        this.idAkce = idAkce;
    }

    public Integer getIdSkupina() {
        return idSkupina;
    }

    public void setIdSkupina(Integer idSkupina) {
        this.idSkupina = idSkupina;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        JepovinnaId entity = (JepovinnaId) o;
        return Objects.equals(this.idSkupina, entity.idSkupina) &&
                Objects.equals(this.idAkce, entity.idAkce);
    }

    @Override
    public int hashCode() {
        return Objects.hash(idSkupina, idAkce);
    }

}