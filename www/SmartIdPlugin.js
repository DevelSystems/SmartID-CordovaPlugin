var exec = require('cordova/exec');

exports.getRawData = function (arg0, success, error) {
    exec(success, error, 'SmartIdPlugin', 'getRawData', arg0);
};

exports.startSmartId = function (arg0, success, error) {
    exec(success, error, 'SmartIdPlugin', 'startSmartId', arg0);
};
