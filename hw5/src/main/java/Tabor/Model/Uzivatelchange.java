package Tabor.Model;

import jakarta.persistence.*;
import org.hibernate.annotations.ColumnDefault;

import java.time.Instant;

@Entity
@Table(name = "uzivatelchanges")
public class Uzivatelchange {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "changes_id", nullable = false)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "id_uzivatel", nullable = false)
    private Uzivatel idUzivatel;

    @Column(name = "old_login", length = 64)
    private String oldLogin;

    @Column(name = "new_login", length = 64)
    private String newLogin;

    @Column(name = "old_email", length = 64)
    private String oldEmail;

    @Column(name = "new_email", length = 64)
    private String newEmail;

    @Column(name = "old_telefon", length = 23)
    private String oldTelefon;

    @Column(name = "new_telefon", length = 23)
    private String newTelefon;

    @ColumnDefault("CURRENT_TIMESTAMP")
    @Column(name = "change_timestamp")
    private Instant changeTimestamp;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Uzivatel getIdUzivatel() {
        return idUzivatel;
    }

    public void setIdUzivatel(Uzivatel idUzivatel) {
        this.idUzivatel = idUzivatel;
    }

    public String getOldLogin() {
        return oldLogin;
    }

    public void setOldLogin(String oldLogin) {
        this.oldLogin = oldLogin;
    }

    public String getNewLogin() {
        return newLogin;
    }

    public void setNewLogin(String newLogin) {
        this.newLogin = newLogin;
    }

    public String getOldEmail() {
        return oldEmail;
    }

    public void setOldEmail(String oldEmail) {
        this.oldEmail = oldEmail;
    }

    public String getNewEmail() {
        return newEmail;
    }

    public void setNewEmail(String newEmail) {
        this.newEmail = newEmail;
    }

    public String getOldTelefon() {
        return oldTelefon;
    }

    public void setOldTelefon(String oldTelefon) {
        this.oldTelefon = oldTelefon;
    }

    public String getNewTelefon() {
        return newTelefon;
    }

    public void setNewTelefon(String newTelefon) {
        this.newTelefon = newTelefon;
    }

    public Instant getChangeTimestamp() {
        return changeTimestamp;
    }

    public void setChangeTimestamp(Instant changeTimestamp) {
        this.changeTimestamp = changeTimestamp;
    }

}