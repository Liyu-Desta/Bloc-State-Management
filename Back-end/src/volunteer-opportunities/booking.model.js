"use strict";
exports.__esModule = true;
exports.BookingModel = exports.BookingSchema = void 0;
var mongoose_1 = require("mongoose");
exports.BookingSchema = new mongoose_1.Schema({
    user: { type: mongoose_1.Schema.Types.ObjectId, ref: 'User', required: true },
    opportunity: {
        type: mongoose_1.Schema.Types.ObjectId,
        ref: 'VolunteerOpportunity',
        required: true
    }
});
// Create the model and export it
exports.BookingModel = mongoose_1["default"].model('Booking', exports.BookingSchema);
