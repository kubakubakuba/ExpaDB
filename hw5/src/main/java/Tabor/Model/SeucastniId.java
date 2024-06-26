package Tabor.Model;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import org.hibernate.Hibernate;

import java.util.Objects;

@Embeddable
public class SeucastniId implements java.io.Serializable {
    private static final long serialVersionUID = 5147144323507636038L;
    @Column(name = "id_uzivatel", nullable = false)
    private Integer idUzivatel;

    @Column(name = "id_akce", nullable = false)
    private Integer idAkce;

    public Integer getIdUzivatel() {
        return idUzivatel;
    }

    public void setIdUzivatel(Integer idUzivatel) {
        this.idUzivatel = idUzivatel;
    }

    public Integer getIdAkce() {
        return idAkce;
    }

    public void setIdAkce(Integer idAkce) {
        this.idAkce = idAkce;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        SeucastniId entity = (SeucastniId) o;
        return Objects.equals(this.idUzivatel, entity.idUzivatel) &&
                Objects.equals(this.idAkce, entity.idAkce);
    }

    @Override
    public int hashCode() {
        return Objects.hash(idUzivatel, idAkce);
    }

}