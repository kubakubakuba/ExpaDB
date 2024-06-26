package Tabor.Model;

import jakarta.persistence.*;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

@Entity
@Table(name = "prednasejici")
public class Prednasejici {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_prednasejici", nullable = false)
    private Integer id;

    @Column(name = "jmeno", nullable = false, length = 64)
    private String jmeno;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "id_akce", nullable = false)
    private Prednaska idAkce;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getJmeno() {
        return jmeno;
    }

    public void setJmeno(String jmeno) {
        this.jmeno = jmeno;
    }

    public Prednaska getIdAkce() {
        return idAkce;
    }

    public void setIdAkce(Prednaska idAkce) {
        this.idAkce = idAkce;
    }

}