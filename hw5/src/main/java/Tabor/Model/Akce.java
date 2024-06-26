package Tabor.Model;

import jakarta.persistence.*;
import org.hibernate.annotations.ColumnDefault;

import java.time.Instant;

@Entity
@Table(name = "akce")
@Inheritance(strategy = InheritanceType.JOINED)
public class Akce {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id_akce", nullable = false)
	private Integer id;

	@ManyToOne(fetch = FetchType.LAZY, optional = false)
	@JoinColumn(name = "created_by", nullable = false)
	private Vedouci createdBy;

	@Column(name = "nazev", nullable = false, length = 64)
	private String nazev;

	@Column(name = "cas", nullable = false)
	private Instant cas;

	@Column(name = "popis", length = Integer.MAX_VALUE)
	private String popis;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Vedouci getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(Vedouci createdBy) {
		this.createdBy = createdBy;
	}

	public String getNazev() {
		return nazev;
	}

	public void setNazev(String nazev) {
		this.nazev = nazev;
	}

	public Instant getCas() {
		return cas;
	}

	public void setCas(Instant cas) {
		this.cas = cas;
	}

	public String getPopis() {
		return popis;
	}

	public void setPopis(String popis) {
		this.popis = popis;
	}
}
