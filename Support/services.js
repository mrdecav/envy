/*jshint node:true */
var services = require('./lib/services');

var serviceMethod = process.argv[2],
    impl;

if ((impl = services[serviceMethod])) {
    impl.apply(null, Array.prototype.slice.call(process.argv, 3));
} else {
    console.error("Usage: service <service-method> <service-name>");
    process.exit(1);
}
