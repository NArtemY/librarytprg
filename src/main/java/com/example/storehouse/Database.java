package com.example.storehouse;

import java.util.ArrayList;

public class Database {
    public static ArrayList<Mineral> mineralList = new ArrayList<>();
    public static ArrayList<Sample> sampleList = new ArrayList<>();
    public static ArrayList<Expedition> expeditionList = new ArrayList<>();
    public static ArrayList<Geologist> geologList = new ArrayList<>();
	public static ArrayList<Account> accountList = new ArrayList<>();
    public static boolean isEnable = false;
	public static boolean stat=false;

    public static void Init (int mineralNum, int sampleNum, int expeditionNum,int geologNum){
//        productList = new ArrayList<>();
//        clientList = new ArrayList<>();
//        orderList = new ArrayList<>();
		
        for(int i = 0; i < mineralNum; i++){
            Database.mineralList.add(new Mineral());
        }
        for(int i = 0; i < sampleNum; i++){
            Database.sampleList.add(new Sample());
        }
		for(int i = 0; i < geologNum; i++){
            Database.geologList.add(new Geologist());
        }
        for(int i = 0; i < expeditionNum; i++){
            Database.expeditionList.add(new Expedition());
        }
		int k=0;
		for(Expedition expedition:expeditionList){
			expedition.geologists=Database.geologList.get(k);
			expedition.samples=Database.sampleList.get(k);
			k++;
		}
		k=0;
		for(Sample sample:sampleList){
			sample.minerals=Database.mineralList.get(k);
			k++;
		}
		isEnable = true;
    }
	
    public static Mineral getMineralByID(int id){
        for (Mineral mineral : mineralList) {
            int mineralId = mineral.getId();
            if (id == mineralId) {
                return mineral;
            }
        }
        return null;
    }
	
    public static Mineral getMineralByName(String name){
        for (Mineral mineral : mineralList) {
            String mineralName = mineral.getName();
            if (mineralName.equals(name)) {
                return mineral;
            }
        }
        return null;
    }
	
    public static Sample getSampleByID(int id){
        for (Sample sample : sampleList) {
            int sampleId = sample.getId();
            if (id == sampleId) {
                return sample;
            }
        }
        return null;
    }

    public static Expedition getExpeditionByID(int id){
        for (Expedition expedition : expeditionList) {
            int expeditionId = expedition.getId();
            if (id == expeditionId) {
                return expedition;
            }
        }
        return null;
    }
	
	public static Geologist getGeologByID(int id){
        for (Geologist geolog : geologList) {
            int geologId = geolog.getId();
            if (id == geologId) {
                return geolog;
            }
        }
        return null;
    }
	
	public static Geologist getGeologByName(String name){
        for (Geologist geolog : geologList) {
            String geologName = geolog.getName();
            if (geologName.equals(name)) {
                return geolog;
            }
        }
        return null;
    }

    public static Account getAccountByLogin(String login) {
        for (Account account : accountList) {
            String accountLogin = account.getLogin();
            if (accountLogin.equals(login)) {
                return account;
            }
        }
        return null;
    }
}
