package Tabor.Model;

import jakarta.persistence.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

@Entity
@Table(name = "vedouci")
public class Vedouci {
    @Id
    @Column(name = "id_uzivatel", nullable = false)
    private Integer id;

    @MapsId
    @OneToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "id_uzivatel", nullable = false)
    private Uzivatel uzivatel;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "vede")
    private Skupina vede;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Uzivatel getUzivatel() {
        return uzivatel;
    }

    public void setUzivatel(Uzivatel uzivatel) {
        this.uzivatel = uzivatel;
    }

    public Skupina getVede() {
        return vede;
    }

    public void setVede(Skupina vede) {
        this.vede = vede;
    }

}