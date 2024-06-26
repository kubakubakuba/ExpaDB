package Tabor.Model;

import jakarta.persistence.*;

@Entity
@Table(name = "prednaska")
public class Prednaska extends Akce {
	
	@Column(name = "misto", nullable = false, length = 64)
	private String misto;

	public String getMisto() {
		return misto;
	}

	public void setMisto(String misto) {
		this.misto = misto;
	}
}
