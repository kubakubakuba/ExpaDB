package Tabor.Model;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import org.hibernate.Hibernate;

import java.util.Objects;

@Embeddable
public class JevedoucimId implements java.io.Serializable {
    private static final long serialVersionUID = -821417692928466280L;
    @Column(name = "nadrizeny", nullable = false)
    private Integer nadrizeny;

    @Column(name = "podrizeny", nullable = false)
    private Integer podrizeny;

    public Integer getNadrizeny() {
        return nadrizeny;
    }

    public void setNadrizeny(Integer nadrizeny) {
        this.nadrizeny = nadrizeny;
    }

    public Integer getPodrizeny() {
        return podrizeny;
    }

    public void setPodrizeny(Integer podrizeny) {
        this.podrizeny = podrizeny;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        JevedoucimId entity = (JevedoucimId) o;
        return Objects.equals(this.podrizeny, entity.podrizeny) &&
                Objects.equals(this.nadrizeny, entity.nadrizeny);
    }

    @Override
    public int hashCode() {
        return Objects.hash(podrizeny, nadrizeny);
    }

}