package org.banrural;

import com.develsystems.smartid.SmartId;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;
import org.apache.cordova.PluginResult;
import org.apache.cordova.PluginResult.Status;
import org.json.JSONObject;
import org.json.JSONArray;
import org.json.JSONException;

import android.util.Log;

public class SmartIDPG extends CordovaPlugin {
  private static final String TAG = "SmartIDPG";

  public void initialize(CordovaInterface cordova, CordovaWebView webView) {
    super.initialize(cordova, webView);
    Log.d(TAG, "Inicializando SmartIDPG");
  }

  public boolean execute(String action, JSONArray args, final CallbackContext callbackContext) throws JSONException {
    if (action.equals("getRawData")) {
      getRawData(callbackContext);
    } else if (action.equals("startSmartId")) {
      startSmartId(callbackContext);
    }
    
    return true;
  }
  
  private void getRawData(CallbackContext callbackContext) {

    SmartId
                .getInstance()
                .GetRawData(this.webView.getContext())
                .onSuccess((time, response) -> {
                  try {
                    JSONObject json = new JSONObject();
                    json.put("data", response);

                    callbackContext.success(json);
                  } catch (Exception exception) {
                    callbackContext.error(exception.getMessage());
                  }
                })
                .onFailure((time, message, errorCode) -> {
                  callbackContext.error(message + " - " + message);
                })
                .start();
  }
  
  private void startSmartId(CallbackContext callbackContext) {
    PluginResult result = new PluginResult(PluginResult.Status.OK, "OK");
    callbackContext.sendPluginResult(result);
  }

}
