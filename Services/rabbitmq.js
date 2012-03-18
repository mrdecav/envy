/*jshint node:true */
var spawn = require('child_process').spawn,
    exec = require('child_process').exec,
    path = require('path');

var SERVICES_PATH = path.join(process.env.HOME, "Services");

// These values will be overridden by the current environment if they
// are defined.
var env = {
    RABBITMQ_BASE:        path.join(SERVICES_PATH, "rabbitmq-server"),
    RABBITMQ_MNESIA_BASE: path.join(SERVICES_PATH, "data/rabbitmq"),
    RABBITMQ_LOG_BASE:    path.join(SERVICES_PATH, "log/rabbitmq.log")
};

// Returns a string that represents the specified command that is safe
// to use in concatenation. 
function sbin (cmd) {
    var server = path.join(env.RABBITMQ_BASE, "sbin", cmd);
    return '"' + server.replace('"', '\\"') + '"';
}

for (var key in process.env) {
    env[key] = process.env[key];
}

var execArgs = {
    env: env,
    cmd: env.RABBITMQ_BASE
};

exports.start = function () {
    exec(sbin('rabbitmq-server') + ' -detached', execArgs, function (error, stdout, stderr) {
        if (stdout) console.log(stdout);
        if (stderr) console.error(stderr);
    });
};

exports.status = function () {
    exec(sbin('rabbitmqctl') + ' status', execArgs, function (error, stdout, stderr) {
        if (stdout) console.log(stdout);
        if (stderr) console.error(stderr);
    });
};

exports.stop = function () {
    exec(sbin('rabbitmqctl') + ' stop', execArgs, function (error, stdout, stderr) {
        if (stdout) console.log(stdout);
        if (stderr) console.error(stderr);
    });
};
