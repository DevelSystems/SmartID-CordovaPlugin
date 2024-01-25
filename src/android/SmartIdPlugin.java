package com.develsystems.smartidplugin;

import android.content.Context;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;
import com.develsystems.smartid.SmartId;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.json.*;

/**
 * This class echoes a string called from JavaScript.
 */
public class SmartIdPlugin extends CordovaPlugin {

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (action.equals("getRawData")) {
            String backendDomain = "";

            if (args.length() > 0) {
                backendDomain = args.getString(0);
            }

            this.getRawData(backendDomain, callbackContext);
        }
        if (action.equals("startSmartId")) {
            this.startSmartId(callbackContext);
            return true;
        }

        return false;
    }

    private void startSmartId(CallbackContext callbackContext) {
        System.out.println("startSmartId method successful.");
    }

    private void getRawData(String backendDomain, CallbackContext callbackContext) {
        final Context context = this.cordova.getActivity().getApplicationContext();

        SmartId
                .getInstance()
                .GetRawData(context, backendDomain)
                .onSuccess((time, response) -> {
                    final JSONObject json = new new JSONObject();
                    json.put("data", response);

                    callbackContext.success(json);
                })
                .onFailure((time, message, errorCode) -> {
                    callbackContext.error(message + " - " + message);
                })
                .start();
    }

}
