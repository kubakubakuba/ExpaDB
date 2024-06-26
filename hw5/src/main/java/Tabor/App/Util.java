package Tabor.App;

import java.util.Random;

import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import static java.lang.String.format;

import Tabor.Model.*;

public class Util {
	public Util () {
	
	}

	public String getRandomHexString(int numchars){
		//https://stackoverflow.com/questions/14622622/generating-a-random-hex-string-of-length-50-in-java-me-j2me
		Random r = new Random();
		StringBuffer sb = new StringBuffer();
		while(sb.length() < numchars){
			sb.append(Integer.toHexString(r.nextInt()));
		}

		return sb.toString().substring(0, numchars);
	}

	private static byte[] getSHA(String input) throws NoSuchAlgorithmException
	{
		//https://www.geeksforgeeks.org/sha-256-hash-in-java/
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		return md.digest(input.getBytes(StandardCharsets.UTF_8));
	}
	
	private static String toHexString(byte[] hash)
	{
		BigInteger number = new BigInteger(1, hash);
		StringBuilder hexString = new StringBuilder(number.toString(16));
		while (hexString.length() < 64)
		{
			hexString.insert(0, '0');
		}
		return hexString.toString();
	}

	public String hashPassword(String password, String salt){
		//hash using sha256
		try {
			return toHexString(getSHA(password + salt));
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}

		return null;

	}

	public void print(Uzivatel u){
		System.out.println("Uživatel:");
		System.out.println(u.getLogin() + " " + u.getJmeno() + " " + u.getEmail() + " " + u.getCislo() + " " + u.getPsc() + " " + u.getMesto() + " " + u.getUlice() + " " + u.getSalt() + " " + u.getHeslo());
	}

	public void print(Vybaveni v){
		System.out.println("Vybavení:");
		System.out.println(v.getInventarniCislo() + " " + v.getNazev() + " " + v.getMajitel() + " " + v.getCena());
	}

	public void print(Skupina s){
		System.out.println(s.getJmeno());
	}

	public void printName(Uzivatel u){
		System.out.println(format("Login %s, Jméno %s", u.getLogin(), u.getJmeno()));
	}

	public void print(Akce a){
		System.out.println(format("Akce %s, Popis %s, Čas: %s", a.getNazev(), a.getPopis(), a.getCas()));
	}
}
