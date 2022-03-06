package com.example.storehouse;

import java.util.Random;

public class Mineral{
    public static int count = 0;
	private int id;
	private String name;
	private String classification;
	private String condition;
	private String solid;
	private String internalProperties;
	private String chemical;
	private String origin;
	
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
	
	public Mineral(String name,String classification,String condition,String solid,String internalProperties,String chemical,String origin){
		this.id=++count;
		this.name=name;
		this.classification=classification;
		this.condition=condition;
		this.solid=solid;
		this.internalProperties=internalProperties;
		this.chemical=chemical;
		this.origin=origin;
	}
	
	public Mineral(){

		id=++count;
		name=randomSymbols();
		classification=randomSymbols();
		condition=(Math.random()>(0.5))?"Твёрдое":"Жидкое";
		solid=randomSymbols();
		internalProperties=randomSymbols();
		chemical=randomSymbols();
		origin=randomSymbols();
	}
	
	public int getId(){
		return id;
	}
	
	public String getName(){
		return name;
	}
	
	public String getClassification(){
		return classification;
	}
	
	public String getCondition(){
		return condition;
	}
	
	public String getSolid(){
		return solid;
	}
	
	public String getInternalProperties(){
		return internalProperties;
	}
	
	public String getChemical(){
		return chemical;
	}
	
	public String getOrigin(){
		return origin;
	}
}
