package Tabor.Model;

import jakarta.persistence.Embeddable;
import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class PouzivaId implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer idUzivatel;
    private Integer idVybaveni;

    public PouzivaId() {
        
    }

    public PouzivaId(Integer idUzivatel, Integer idVybaveni) {
        this.idUzivatel = idUzivatel;
        this.idVybaveni = idVybaveni;
    }

    public Integer getIdUzivatel() {
        return idUzivatel;
    }

    public void setIdUzivatel(Integer idUzivatel) {
        this.idUzivatel = idUzivatel;
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
        if (o == null || getClass() != o.getClass()) return false;
        PouzivaId that = (PouzivaId) o;
        return Objects.equals(idUzivatel, that.idUzivatel) && Objects.equals(idVybaveni, that.idVybaveni);
    }

    @Override
    public int hashCode() {
        return Objects.hash(idUzivatel, idVybaveni);
    }
}
