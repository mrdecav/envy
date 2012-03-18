/*jshint node:true */
var spawn = require('child_process').spawn,
    exec = require('child_process').exec,
    fs = require('fs'),
    path = require('path');

var SERVICES_PATH  = path.join(process.env.HOME, "Services"),
    MONGODB_ROOT   = path.join(SERVICES_PATH, "mongo"),
    MONGOD_BIN     = path.join(MONGODB_ROOT, "bin", "mongod"),
    MONGO_DATA_DIR = path.join(SERVICES_PATH, "data", "mongo"),
    MONGO_LOG_PATH = path.join(SERVICES_PATH, "log", "mongo.log");

var pid;
var pidFile = path.join(process.env.HOME, ".services", "mongo.pid");
if (path.existsSync(pidFile)) {
    try {
        pid = parseInt(fs.readFileSync(pidFile, 'utf8'), 10);
    } catch (ex) {
    }
} else if (!path.existsSync(path.dirname(pidFile))) {
    fs.mkdirSync(path.dirname(pidFile));
}

var execArgs = {
    env: process.env,
    cmd: MONGODB_ROOT,
    setsid: false
};

exports.start = function () {
    fs.mkdir(MONGO_DATA_DIR);
    fs.mkdir(path.dirname(MONGO_LOG_PATH));

    var args = ['--dbpath', MONGO_DATA_DIR, '--logpath' , MONGO_LOG_PATH];
    var child = spawn(MONGOD_BIN, args, execArgs);

    pid = child.pid;
    fs.writeFileSync(pidFile, pid.toString());
    console.log(MONGOD_BIN + ' ' + args.join(' '));
    console.log("Started with pid " + pid);
    process.exit(0);
};

exports.isRunning = function () {
    return !!pid;
};

exports.stop = function () {
    if (pid) {
        console.log("Killing pid " + pid + "...");
        process.kill(pid);
        fs.unlink(pidFile, function (err) {
            if (err) {
                console.error(err);
            }
        });
    }
};
