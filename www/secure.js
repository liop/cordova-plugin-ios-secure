
var exec = require("cordova/exec");

var CDVSecure = function () {
    this.name = "CDVSecure";
};

CDVSecure.prototype.signedParamsByMd5 = function (params, onComplete) {
     
    exec(onComplete, null, "NativeTransitions", "signedParamsByMd5", [params]);
};

CDVSecure.prototype.addMd5SignToParma = function (params, onComplete) {
    var options = {
        "duration": duration,
        "direction": direction
    };
    exec(onComplete, null, "CDVSecure", "addMd5SignToParma", [params]);
};

module.exports = new CDVSecure();
