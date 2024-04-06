import java.util.HashMap;

class AirportLocations {
  private HashMap<String, Location> airportMap;

  public AirportLocations() {
    airportMap = new HashMap<String, Location>();

    airportMap.put("LAX", LAX);
    airportMap.put("JFK", JFK);
    airportMap.put("DCA", DCA);
    airportMap.put("FLL", FLL);
    airportMap.put("SEA", SEA);
    airportMap.put("HNL", HNL);
    airportMap.put("ORD", ORD);
    airportMap.put("DAL", DAL);
    airportMap.put("MCI", MCI);
    airportMap.put("HOU", HOU);
    airportMap.put("ABQ", ABQ);
    airportMap.put("ADQ", ADQ);
    airportMap.put("ALB", ALB);
    airportMap.put("ANC", ANC);
    airportMap.put("ATL", ATL);
    airportMap.put("ATW", ATW);
    airportMap.put("AUS", AUS);
    airportMap.put("AZA", AZA);
    airportMap.put("BDL", BDL);
    airportMap.put("BET", BET);
    airportMap.put("BHM", BHM);
    airportMap.put("BIL", BIL);
    airportMap.put("BIS", BIS);
    airportMap.put("BLI", BLI);
    airportMap.put("BLV", BLV);
    airportMap.put("BNA", BNA);
    airportMap.put("BOI", BOI);
    airportMap.put("BOS", BOS);
    airportMap.put("BRW", BRW);
    airportMap.put("BUF", BUF);
    airportMap.put("BUR", BUR);
    airportMap.put("BWI", BWI);
    airportMap.put("BZN", BZN);
    airportMap.put("CDV", CDV);
    airportMap.put("CHS", CHS);
    airportMap.put("CID", CID);
    airportMap.put("CLE", CLE);
    airportMap.put("CLT", CLT);
    airportMap.put("CMH", CMH);
    airportMap.put("CRP", CRP);
    airportMap.put("CVG", CVG);
    airportMap.put("DEN", DEN);
    airportMap.put("DFW", DFW);
    airportMap.put("DTW", DTW);
    airportMap.put("ELP", ELP);
    airportMap.put("EUG", EUG);
    airportMap.put("EWR", EWR);
    airportMap.put("FAI", FAI);
    airportMap.put("FAR", FAR);
    airportMap.put("FAT", FAT);
    airportMap.put("GEG", GEG);
    airportMap.put("GTF", GTF);
    airportMap.put("GJT", GJT);
    airportMap.put("GSP", GSP);
    airportMap.put("HPN", HPN);
    airportMap.put("IAH", IAH);
    airportMap.put("IDA", IDA);
    airportMap.put("IND", IND);
    airportMap.put("ITO", ITO);
    airportMap.put("JAN", JAN);
    airportMap.put("JAX", JAX);
    airportMap.put("JNU", JNU);
    airportMap.put("KOA", KOA);
    airportMap.put("KTN", KTN);
    airportMap.put("LAS", LAS);
    airportMap.put("LGA", LGA);
    airportMap.put("LGB", LGB);
    airportMap.put("LIH", LIH);
    airportMap.put("MAF", MAF);
    airportMap.put("MCO", MCO);
    airportMap.put("MDW", MDW);
    airportMap.put("MEM", MEM);
    airportMap.put("MFE", MFE);
    airportMap.put("MFR", MFR);
    airportMap.put("MIA", MIA);
    airportMap.put("MKE", MKE);
    airportMap.put("MOT", MOT);
    airportMap.put("MSO", MSO);
    airportMap.put("MSP", MSP);
    airportMap.put("MSY", MSY);
    airportMap.put("MYR", MYR);
    airportMap.put("OAK", OAK);
    airportMap.put("OGG", OGG);
    airportMap.put("OKC", OKC);
    airportMap.put("ONT", ONT);
    airportMap.put("PBI", PBI);
    airportMap.put("PDX", PDX);
    airportMap.put("PHL", PHL);
    airportMap.put("PHX", PHX);
    airportMap.put("PIA", PIA);
    airportMap.put("PIT", PIT);
    airportMap.put("PSG", PSG);
    airportMap.put("PSP", PSP);
    airportMap.put("RAP", RAP);
    airportMap.put("RDU", RDU);
    airportMap.put("RFD", RFD);
    airportMap.put("RNO", RNO);
    airportMap.put("RSW", RSW);
    airportMap.put("SAN", SAN);
    airportMap.put("SAT", SAT);
    airportMap.put("SAV", SAV);
    airportMap.put("SCC", SCC);
    airportMap.put("SCK", SCK);
    airportMap.put("SDF", SDF);
    airportMap.put("SFO", SFO);
    airportMap.put("SGF", SGF);
    airportMap.put("SIT", SIT);
    airportMap.put("SJC", SJC);
    airportMap.put("SJU", SJU);
    airportMap.put("SLC", SLC);
    airportMap.put("SMF", SMF);
    airportMap.put("SMX", SMX);
    airportMap.put("SNA", SNA);
    airportMap.put("SRQ", SRQ);
    airportMap.put("STL", STL);
    airportMap.put("TPA", TPA);
    airportMap.put("TUL", TUL);
    airportMap.put("VPS", VPS);
    airportMap.put("WRG", WRG);
    airportMap.put("XNA", XNA);
    airportMap.put("YAK", YAK);

    airportMap.put("ABE", ABE);
    airportMap.put("ABI", ABI);
    airportMap.put("ABR", ABR);
    airportMap.put("ABY", ABY);
    airportMap.put("ACT", ACT);
    airportMap.put("ACV", ACV);
    airportMap.put("ACY", ACY);
    airportMap.put("ADK", ADK);
    airportMap.put("AEX", AEX);
    airportMap.put("AGS", AGS);
    airportMap.put("AKN", AKN);
    airportMap.put("ALO", ALO);
    airportMap.put("ALS", ALS);
    airportMap.put("ALW", ALW);
    airportMap.put("AMA", AMA);
    airportMap.put("APN", APN);
    airportMap.put("ART", ART);
    airportMap.put("ASE", ASE);
    airportMap.put("AVL", AVL);
    airportMap.put("AVP", AVP);
    airportMap.put("AZO", AZO);
    airportMap.put("BFF", BFF);
    airportMap.put("BFL", BFL);
    airportMap.put("BGM", BGM);
    airportMap.put("BGR", BGR);
    airportMap.put("BIH", BIH);
    airportMap.put("BJI", BJI);
    airportMap.put("BMI", BMI);
    airportMap.put("BPT", BPT);
    airportMap.put("BQK", BQK);
    airportMap.put("BQN", BQN);
    airportMap.put("BRD", BRD);
    airportMap.put("BRO", BRO);
    airportMap.put("BTM", BTM);
    airportMap.put("BTR", BTR);
    airportMap.put("BTV", BTV);
    airportMap.put("CAE", CAE);
    airportMap.put("CAK", CAK);
    airportMap.put("CDC", CDC);
    airportMap.put("CGI", CGI);
    airportMap.put("CHA", CHA);
    airportMap.put("CHO", CHO);
    airportMap.put("CIU", CIU);
    airportMap.put("CKB", CKB);
    airportMap.put("CLL", CLL);
    airportMap.put("CMI", CMI);
    airportMap.put("CMX", CMX);
    airportMap.put("CNY", CNY);
    airportMap.put("COD", COD);
    airportMap.put("COS", COS);
    airportMap.put("COU", COU);
    airportMap.put("CPR", CPR);
    airportMap.put("CRW", CRW);
    airportMap.put("CSG", CSG);
    airportMap.put("CWA", CWA);
    airportMap.put("CYS", CYS);
    airportMap.put("DAB", DAB);
    airportMap.put("DAY", DAY);
    airportMap.put("DBQ", DBQ);
    airportMap.put("DDC", DDC);
    airportMap.put("DEC", DEC);
    airportMap.put("DHN", DHN);
    airportMap.put("DIK", DIK);
    airportMap.put("DLG", DLG);
    airportMap.put("DLH", DLH);
    airportMap.put("DRO", DRO);
    airportMap.put("DRT", DRT);
    airportMap.put("DSM", DSM);
    airportMap.put("DVL", DVL);
    airportMap.put("EAR", EAR);
    airportMap.put("EAT", EAT);
    airportMap.put("EAU", EAU);
    airportMap.put("ECP", ECP);
    airportMap.put("EGE", EGE);
    airportMap.put("EKO", EKO);
    airportMap.put("ELM", ELM);
    airportMap.put("ERI", ERI);
    airportMap.put("ESC", ESC);
    airportMap.put("EVV", EVV);
    airportMap.put("EWN", EWN);
    airportMap.put("EYW", EYW);
    airportMap.put("FAY", FAY);
    airportMap.put("FCA", FCA);
    airportMap.put("FLG", FLG);
    airportMap.put("FLO", FLO);
    airportMap.put("FNT", FNT);
    airportMap.put("FOD", FOD);
    airportMap.put("FSD", FSD);
    airportMap.put("FSM", FSM);
    airportMap.put("FWA", FWA);
    airportMap.put("GCC", GCC);
    airportMap.put("GCK", GCK);
    airportMap.put("GFK", GFK);
    airportMap.put("GGG", GGG);
    airportMap.put("GNV", GNV);
    airportMap.put("GPT", GPT);
    airportMap.put("GRB", GRB);
    airportMap.put("GRI", GRI);
    airportMap.put("GRK", GRK);
    airportMap.put("GRR", GRR);
    airportMap.put("GSO", GSO);
    airportMap.put("GTR", GTR);
    airportMap.put("GUC", GUC);
    airportMap.put("GUM", GUM);
    airportMap.put("HDN", HDN);
    airportMap.put("HGR", HGR);
    airportMap.put("HHH", HHH);
    airportMap.put("HIB", HIB);
    airportMap.put("HLN", HLN);
    airportMap.put("HOB", HOB);
    airportMap.put("HRL", HRL);
    airportMap.put("HSV", HSV);
    airportMap.put("HTS", HTS);
    airportMap.put("HYS", HYS);
    airportMap.put("IAD", IAD);
    airportMap.put("IAG", IAG);
    airportMap.put("ICT", ICT);
    airportMap.put("ILG", ILG);
    airportMap.put("ILM", ILM);
    airportMap.put("IMT", IMT);
    airportMap.put("INL", INL);
    airportMap.put("ISP", ISP);
    airportMap.put("ITH", ITH);
    airportMap.put("JAC", JAC);
    airportMap.put("JLN", JLN);
    airportMap.put("JMS", JMS);
    airportMap.put("JST", JST);
    airportMap.put("LAN", LAN);
    airportMap.put("LAR", LAR);
    airportMap.put("LAW", LAW);
    airportMap.put("LBB", LBB);
    airportMap.put("LBE", LBE);
    airportMap.put("LBF", LBF);
    airportMap.put("LBL", LBL);
    airportMap.put("LCH", LCH);
    airportMap.put("LCK", LCK);
    airportMap.put("LEX", LEX);
    airportMap.put("LFT", LFT);
    airportMap.put("LIT", LIT);
    airportMap.put("LNK", LNK);
    airportMap.put("LRD", LRD);
    airportMap.put("LSE", LSE);
    airportMap.put("LWB", LWB);
    airportMap.put("LWS", LWS);
    airportMap.put("LYH", LYH);
    airportMap.put("MBS", MBS);
    airportMap.put("MCW", MCW);
    airportMap.put("MDT", MDT);
    airportMap.put("MEI", MEI);
    airportMap.put("MGM", MGM);
    airportMap.put("MHK", MHK);
    airportMap.put("MHT", MHT);
    airportMap.put("MKG", MKG);
    airportMap.put("MLB", MLB);
    airportMap.put("MLI", MLI);
    airportMap.put("MLU", MLU);
    airportMap.put("MOB", MOB);
    airportMap.put("MQT", MQT);
    airportMap.put("MRY", MRY);
    airportMap.put("MSN", MSN);
    airportMap.put("MTJ", MTJ);
    airportMap.put("OAJ", OAJ);
    airportMap.put("OGD", OGD);
    airportMap.put("OGS", OGS);
    airportMap.put("OMA", OMA);
    airportMap.put("OME", OME);
    airportMap.put("ORF", ORF);
    airportMap.put("ORH", ORH);
    airportMap.put("OTH", OTH);
    airportMap.put("OTZ", OTZ);
    airportMap.put("OWB", OWB);
    airportMap.put("PAE", PAE);
    airportMap.put("PAH", PAH);
    airportMap.put("PBG", PBG);
    airportMap.put("PGD", PGD);
    airportMap.put("PGV", PGV);
    airportMap.put("PHF", PHF);
    airportMap.put("PIB", PIB);
    airportMap.put("PIE", PIE);
    airportMap.put("PIH", PIH);
    airportMap.put("PIR", PIR);
    airportMap.put("PLN", PLN);
    airportMap.put("PNS", PNS);
    airportMap.put("PQI", PQI);
    airportMap.put("PRC", PRC);
    airportMap.put("PSC", PSC);
    airportMap.put("PSM", PSM);
    airportMap.put("PUB", PUB);
    airportMap.put("PUW", PUW);
    airportMap.put("PVD", PVD);
    airportMap.put("PVU", PVU);
    airportMap.put("PWM", PWM);
    airportMap.put("RDD", RDD);
    airportMap.put("RDM", RDM);
    airportMap.put("RHI", RHI);
    airportMap.put("RIC", RIC);
    airportMap.put("RIW", RIW);
    airportMap.put("RKS", RKS);
    airportMap.put("ROA", ROA);
    airportMap.put("ROC", ROC);
    airportMap.put("ROW", ROW);
    airportMap.put("RST", RST);
    airportMap.put("SAF", SAF);
    airportMap.put("SBA", SBA);
    airportMap.put("SBN", SBN);
    airportMap.put("SBP", SBP);
    airportMap.put("SBY", SBY);
    airportMap.put("SCE", SCE);
    airportMap.put("SFB", SFB);
    airportMap.put("SGU", SGU);
    airportMap.put("SHD", SHD);
    airportMap.put("SHR", SHR);
    airportMap.put("SHV", SHV);
    airportMap.put("SJT", SJT);
    airportMap.put("SLN", SLN);
    airportMap.put("SPI", SPI);
    airportMap.put("SPS", SPS);
    airportMap.put("STC", STC);
    airportMap.put("STS", STS);
    airportMap.put("SUN", SUN);
    airportMap.put("SUX", SUX);
    airportMap.put("SWF", SWF);
    airportMap.put("SWO", SWO);
    airportMap.put("SYR", SYR);
    airportMap.put("TBN", TBN);
    airportMap.put("TLH", TLH);
    airportMap.put("TOL", TOL);
    airportMap.put("TRI", TRI);
    airportMap.put("TTN", TTN);
    airportMap.put("TUS", TUS);
    airportMap.put("TVC", TVC);
    airportMap.put("TWF", TWF);
    airportMap.put("TXK", TXK);
    airportMap.put("TYR", TYR);
    airportMap.put("TYS", TYS);
    airportMap.put("USA", USA);
    airportMap.put("VCT", VCT);
    airportMap.put("VEL", VEL);
    airportMap.put("VLD", VLD);
    airportMap.put("XWA", XWA);
    airportMap.put("YKM", YKM);
    airportMap.put("YUM", YUM);
    airportMap.put("STT", new Location(18.3378, -64.9739)); 
    airportMap.put("STX", new Location(17.7019, -64.7986)); 
    airportMap.put("PSE", new Location(18.0086, -66.5630)); 
    airportMap.put("SPN", new Location(15.1196, 145.7299)); 
    airportMap.put("ATY", new Location(44.9122, -97.1551)); 
    airportMap.put("PPG", new Location(-14.3267, -170.7103));
  }

  public Location getLocation(String airportCode) {
    if (airportMap.containsKey(airportCode)) {
            // If the airport code is present, return the corresponding Location
            return airportMap.get(airportCode);
        } else {
            // If the airport code is not present
            println(airportCode, "does not exist");
            return null;
        }
  }
}
