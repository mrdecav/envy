/*global define:false */
define([
    'jquery',
    'underscore',
    'Backbone'
], function (
    $,
    _,
    Backbone
) {
    return Backbone.View.extend({
        initialize: function () {
        },

        remove: function () {
            Backbone.View.prototype.remove.call(this);
            return this;
        },

        render: function () {
            return this;
        }
    });
});
