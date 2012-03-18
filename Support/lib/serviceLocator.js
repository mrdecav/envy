/*jshint node:true */
var fs   = require('fs'),
    path = require('path');

var SERVICES_ROOT = path.join(__dirname, "../../Services");

// Returns a map of avaiable services.
exports.getServices = function (callback) {
    fs.readdir(SERVICES_ROOT, function (err, files) {
        var i, len, fullPath, svc, svcName, svcMap = {};

        if (!err) {
            for (i = 0, len = files.length; i < len; i++) {
                if (!files[i].match(/^\./)) {
                    svcName = path.basename(files[i], ".js");
                    fullPath = path.join(SERVICES_ROOT, svcName);
                    svc = require(fullPath);
                    svcMap[svcName] = svc;
                }
            }
        }

        if (callback) {
            callback(err, svcMap);
        }
    });
};
