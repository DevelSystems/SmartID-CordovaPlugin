
var exec = require('cordova/exec');

var PLUGIN_NAME = 'SmartIDPG';

var SmartIDPG = {
  
  getRawData: function(successCallback, errorCallback)
  { 
    exec(successCallback, errorCallback, PLUGIN_NAME, "getRawData", []);
  },
  startSmartId: function(successCallback, errorCallback)
  {
    exec(successCallback, errorCallback, PLUGIN_NAME, "startSmartId", []);
  }

};

module.exports = SmartIDPG;
