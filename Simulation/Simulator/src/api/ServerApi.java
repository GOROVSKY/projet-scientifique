package api;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;

import org.json.*;

import models.Sensor;
import okhttp3.Call;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

public class ServerApi {

	OkHttpClient client = new OkHttpClient();
	public static final MediaType JSON = MediaType.parse("application/json; charset=utf-8");

	private String baseUrl = "http://127.0.0.1:5000/api/";

	public ArrayList<Sensor> getSensors(String method) throws IOException {
		ArrayList<Sensor> sensors = new ArrayList<Sensor>();
		Request request = new Request.Builder().url(this.baseUrl + method).build();

		Call call = client.newCall(request);
		Response response = call.execute();

		if (!this.HandleResponse(response))
			return sensors;

		String res = response.body().string();
		JSONArray jsonArray = new JSONArray(res);

		if (jsonArray != null) {
			for (int i = 0; i < jsonArray.length(); i++) {
				JSONObject json = (JSONObject) jsonArray.get(i);
				Sensor sensor = new Sensor((int) json.get("id"), (int) json.get("modeleId"),  (int) json.get("idTypeCapteur"), (String) json.get("modeleLibelle"), (String) json.get("typeCapteurLibelle"), (String) json.get("code"),
					((BigDecimal) json.get("latitude")).floatValue(),((BigDecimal) json.get("longitude")).floatValue(), (int) json.get("ligne"), (int) json.get("colonne"), 
					(String) json.get("valeur"));
				sensors.add(sensor);
			}
		}

		return sensors;
	}

	public String post(String method, String json) throws IOException {
		RequestBody body = RequestBody.create(json, JSON);
		Request request = new Request.Builder().url(this.baseUrl + method).post(body).build();
		Response response = client.newCall(request).execute();
		return response.body().string();
	}

	public Boolean HandleResponse(Response response) {
		if (response.code() != 200) {
			System.out.println("Error response : " + response);
		}

		return response.code() == 200;
	}
}