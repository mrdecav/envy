/*jshint node:true */
var serviceLocator = require('./serviceLocator');

function fatalError (err) {
    console.error(err);
    process.exit(1);
}

// Returns a subset of the known services that match the specified glob string.
function getServices (glob, callback) {
    serviceLocator.getServices(function (err, svcMap) {
        var m;

        if (!err) {
            m = {};
            var r = new RegExp("^" + glob.replace(/\*/g, ".*") + "$"), i, len;

            console.log(r);
            var svcs = Object.keys(svcMap).filter(function (s) { return s.match(r); });

            for (i = 0, len = svcs.length; i < len; i++) {
                var svcName = svcs[i];
                m[svcName] = svcMap[svcName];
            }
        }

        callback(err, m);
    });
}

function buildDefaultImplementation (exports, methodName, fallback) {
    exports[methodName] = function (glob) {
        var args = Array.prototype.slice.call(arguments, 1);
        getServices(glob, function (err, svcMap) {
            var svc, serviceName, impl, hasAny = false;

            for (serviceName in svcMap) {
                hasAny = true;
                svc = svcMap[serviceName];

                if ((impl = svc[methodName])) {
                    return impl.apply(svc, args);
                } else if (fallback) {
                    fallback(svc);
                } else {
                    return fatalError(
                        serviceName + ": No implementation for \"" + methodName + "\" defined");
                }
            }

            if (!hasAny) {
                return fatalError(serviceName + ": No matching service implementation defined");
            }
        });
    };
}

buildDefaultImplementation(exports, "start");
buildDefaultImplementation(exports, "stop");
buildDefaultImplementation(exports, "restart", function (svc, callback) {
    svc.stop(function () {
        svc.start(callback);
    });
});

exports.list = exports.status = function () {
    serviceLocator.getServices(function (err, svcMap) {
        var svcNames = Object.keys(svcMap),
            svcName,
            svc,
            i,
            len;

        svcNames.sort();
        
        for (i = 0, len = svcNames.length; i < len; i++) {
            svcName = svcNames[i];
            svc = svcMap[svcName];
            console.log(svcName + ": " + (svc.isRunning ? svc.isRunning() : "unknown"));
        }
    });
};
