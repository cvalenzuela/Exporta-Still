import processing.pdf.*;

PImage mapImage;
MercatorMap mercatorMap;
JSONObject json;
JSONObject originMaster;
JSONObject originYear;

JSONArray allDestinations;
JSONArray sizeOfExportation;
JSONArray latOfExportation;
JSONArray longOfExportation;
	
String[] destination;
int[] size;
float[] destinationLat;
float[] destinationLong;

float latOrigin;
float longOrigin;
float year;
PFont font;

PVector from;
PVector to;

float maxValue;
float minValue;
int maxIndex;
int minIndex;

color[] rojoA = {#7A9F35, #D4EE9F, #A5C663, #567714, #354F00};
color[] rojoB = {#741010, #9E3030, #4E0000, #2B0000, #C95E5E};
color[] verdeA = {#7A9F35, #D4EE9F, #A5C663, #567714, #354F00};
color[] verdeB = {#226666, #407F7F, #0D4D4D, #003333, #669999};
color[] verdeAB = {#226666, #407F7F, #0D4D4D, #003333, #669999, #7A9F35, #D4EE9F, #A5C663, #567714, #354F00};
color[] azulA = {};

String[] paises = { "ARGENTINA", "BELICE", "BOLIVIA", "BRASIL", "BARBADOS", "CHILE", "COLOMBIA", "COSTA RICA", 
"DOMINICA", "REPUBLICA DOMINICANA", "ECUADOR", "GUATEMALA", "GUYANA", "HONDURAS", "JAMAICA", "MEXICO", "NICARAGUA",
 "PANAMA", "PERU", "PARAGUAY", "EL SALVADOR", "URUGUAY", "USA", "VENEZUELA"};
String[] years = {"2005","2006","2007","2008","2009","2010","2011","2012","2013","2014"};

String whatCountry = "BOLIVIA";
String whatYear = "2014";

void setup(){
	size(3450, 1970,PDF, whatCountry+whatYear+".pdf"); //3450x1970
	smooth(8);
	font = createFont("Lato-Hairline", 10, true);
	mapImage = loadImage("mapa@3450.png");
	mercatorMap = new MercatorMap(3450, 1970);

	json = loadJSONObject("exports.json");

}


void draw(){
	//image(mapImage, 0, 0, width, height);
	//background(#aa3939); //ROJO
	background(#051938); //azul
	oneOnly();
	//all();

	noLoop();
	exit();

}

void mousePressed(){
	saveFrame();
}

void oneOnly(){
// ** UN SOLO PAIS **
	originMaster = json.getJSONObject(whatCountry);
	originYear = originMaster.getJSONObject(whatYear);
	latOrigin = originMaster.getFloat("LAT");
	longOrigin = originMaster.getFloat("LONG");

	allDestinations = originYear.getJSONArray("TO");
	sizeOfExportation = originYear.getJSONArray("VALUE");
	latOfExportation = originYear.getJSONArray("LAT");
	longOfExportation = originYear.getJSONArray("LONG");

	destination = allDestinations.getStringArray();
	size = sizeOfExportation.getIntArray();
	destinationLat = latOfExportation.getFloatArray();
	destinationLong = longOfExportation.getFloatArray();

	from = mercatorMap.getScreenLocation(new PVector(latOrigin,longOrigin));
	//** UN SOLO PAIS **
	textSize(10);
	for (int i = 0; i < size.length; i++){
		to = mercatorMap.getScreenLocation(new PVector(destinationLat[i], destinationLong[i]));
		//stroke(verdeAB[int(random(0,9))]);
		//stroke(int(random(50,150)),int(random(50,200)),int(random(10,100)),200); // RANDOM COLORS
		stroke(#7689A9,220);
		strokeWeight(map(size[i],1,319010819,1,300));
		curva(to.x, to.y, randomBool(), false , from.x, from.y );
		//text(destination[i], to.x, to.y - 5);	
	}
	text(whatCountry, from.x - 20, from.y - 5);
}

void all(){
	//** TODOS LOS PAISES **
	for (int k = 0; k < paises.length; k++){
		originMaster = json.getJSONObject(paises[k]);
		originYear = originMaster.getJSONObject("2005");
		latOrigin = originMaster.getFloat("LAT");
		longOrigin = originMaster.getFloat("LONG");

		allDestinations = originYear.getJSONArray("TO");
		sizeOfExportation = originYear.getJSONArray("VALUE");
		latOfExportation = originYear.getJSONArray("LAT");
		longOfExportation = originYear.getJSONArray("LONG");

		destination = allDestinations.getStringArray();
		size = sizeOfExportation.getIntArray();
		destinationLat = latOfExportation.getFloatArray();
		destinationLong = longOfExportation.getFloatArray();
		
		from = mercatorMap.getScreenLocation(new PVector(latOrigin,longOrigin));
		
		textSize(10);
		fill(255, 100);

		for (int i = 0; i < size.length; i++){

			to = mercatorMap.getScreenLocation(new PVector(destinationLat[i], destinationLong[i]));
			//stroke(rojoB[int(random(0,rojoB.length))],80); // RANDOM COLOR DE ARRAY
			//stroke(#7689A9,70); // COLOR ESPECÍFICO
			stroke(int(random(50,190)),int(random(50,200)),int(random(10,200)),80); // RANDOM COLORS
			//stroke(int(random(200,255)),int(random(200,255)),int(random(200,250)),30);
			strokeWeight(map(size[i],1,319010819,1,100));
			curva(to.x, to.y, randomBool() , false , from.x, from.y );
			//text(destination[i], to.x, to.y - 5);			
		}
		//text(paises[k], from.x - 60, from.y - 5);
	}
		
}