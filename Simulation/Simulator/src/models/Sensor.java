package models;

import java.util.Random;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;

public class Sensor {
	
	public int id;
	public String code;
	public float longitude;
	public float latitude;
	public int row;
	public int column;
	public int typeId;
	public int value;
	
	public static final int valueMin = 1;
	public static final int valueMax = 9;
	
	public Sensor(int id, String code, float longitude, float latitude, int row, int column, int typeId, int value) {
		this.id = id;
		this.code = code;
		this.longitude = longitude;
		this.latitude = latitude;
		this.row = row;
		this.column = column;
		this.typeId = typeId;
		this.value = value;
	}
	
	public Sensor(int id, String code, float longitude, float latitude, int typeid, int value) {
		this.id = id;
		this.code = code;
		this.longitude = longitude;
		this.latitude = latitude;
		this.typeId = typeid;
		this.value = value;
	}
	
	public void DetectFire() {
		// int aléatoire compris dans [0,9]
		if (this.typeId == Type.INTENSITY.value) {			
			this.value = new Random().nextInt(Sensor.valueMax - Sensor.valueMin + 1) + Sensor.valueMin;
		}
	}
	
	public void DetectNothing() {
		this.value = 0;
	}
	
	public String ToJson() {
		ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
		try {
			return ow.writeValueAsString(this);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
}
