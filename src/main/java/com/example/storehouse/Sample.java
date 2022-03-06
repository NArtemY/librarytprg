package com.example.storehouse;

import java.util.Random;

public class Sample{
	private static int count = 0;
	private int id;
	public Mineral minerals;
	private String origin;
	private String detection;
	private String source;
	
	private String randomSymbols()
	{
		int leftLimit = 97;
        int rightLimit = 123;
        Random randStr = new Random();
        return randStr.ints(leftLimit, rightLimit)
                .limit(15)
                .collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append)
                .toString();
	}
	
	public Sample(Mineral minerals,String origin,String detection,String source){
		this.id=++count;
		this.minerals=minerals;
		this.origin=origin;
		this.detection=detection;
		this.source=source;
	}
	
	public Sample(){
		id=++count;
		origin=randomSymbols();
		detection=randomSymbols();
		source=randomSymbols();
	}
	
	public int getId(){
		return id;
	}
	
	public Mineral getMinerals(){
		return minerals;
	}
	
	public String getOrigin(){
		return origin;
	}
	
	public String getDetection(){
		return detection;
	}
	
	public String getSource(){
		return source;
	}
}