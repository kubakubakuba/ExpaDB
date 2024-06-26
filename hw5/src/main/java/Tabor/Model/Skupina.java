package Tabor.Model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import org.hibernate.annotations.ColumnDefault;

@Entity
@Table(name = "skupina")
public class Skupina {
    @Id
    @ColumnDefault("nextval('skupina_id_skupina_seq'::regclass)")
    @Column(name = "id_skupina", nullable = false)
    private Integer id;

    @Column(name = "jmeno", nullable = false, length = 64)
    private String jmeno;

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

}