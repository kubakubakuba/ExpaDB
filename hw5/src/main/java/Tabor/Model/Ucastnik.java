package Tabor.Model;

import jakarta.persistence.*;

@Entity
@Table(name = "ucastnik")
@Inheritance(strategy = InheritanceType.JOINED)
public class Ucastnik extends Uzivatel {

	@ManyToOne(fetch = FetchType.LAZY, optional = false)
	@JoinColumn(name = "soucasti_skupiny", nullable = false)
	private Skupina soucastiSkupiny;

	public Skupina getSoucastiSkupiny() {
		return soucastiSkupiny;
	}

	public void setSoucastiSkupiny(Skupina soucastiSkupiny) {
		this.soucastiSkupiny = soucastiSkupiny;
	}
}
