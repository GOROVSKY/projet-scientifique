import java.io.IOException;
import java.util.ArrayList;

import org.json.*;

import models.Sensor;
import okhttp3.*;

public class ServerApi {

	OkHttpClient client = new OkHttpClient();
	public static final MediaType JSON = MediaType.parse("application/json; charset=utf-8");

	private String baseUrl = "http://192.168.37.83:5000/api/";

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
				
				Sensor sensor = new Sensor((int) json.get("id"), (String) json.get("code"), (int) json.get("longitude"),
						(int) json.get("latitude"), (int) json.get("type_id"),
						json.isNull("value") == true ? -1 : (int) json.get("value"));

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