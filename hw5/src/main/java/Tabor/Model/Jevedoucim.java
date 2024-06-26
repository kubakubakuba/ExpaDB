package Tabor.Model;

import jakarta.persistence.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

@Entity
@Table(name = "jevedoucim")
public class Jevedoucim {
    @EmbeddedId
    private JevedoucimId id;

    @MapsId("nadrizeny")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "nadrizeny", nullable = false)
    private Vedouci nadrizeny;

    @MapsId("podrizeny")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "podrizeny", nullable = false)
    private Vedouci podrizeny;

    public JevedoucimId getId() {
        return id;
    }

    public void setId(JevedoucimId id) {
        this.id = id;
    }

    public Vedouci getNadrizeny() {
        return nadrizeny;
    }

    public void setNadrizeny(Vedouci nadrizeny) {
        this.nadrizeny = nadrizeny;
    }

    public Vedouci getPodrizeny() {
        return podrizeny;
    }

    public void setPodrizeny(Vedouci podrizeny) {
        this.podrizeny = podrizeny;
    }

}