/*global define:false */
define([
    'underscore',
    'Backbone'
], function (
    _,
    Backbone
) {
    return Backbone.Model.extend({
        initialize: function (attrs, options) {
        },

        toJSON: function () {
            var obj = Backbone.Model.prototype.toJSON.call(this);
            return obj;
        }
    });
});
