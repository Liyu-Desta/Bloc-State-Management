"use strict";
exports.__esModule = true;
exports.VolunteerOpportunityModel = exports.VolunteerOpportunitySchema = void 0;
var mongoose_1 = require("mongoose");
exports.VolunteerOpportunitySchema = new mongoose_1.Schema({
    title: { type: String, required: true },
    description: { type: String, required: true },
    photo: { type: String, required: true },
    location: { type: String, required: true },
    date: { type: String, required: true }
}, { timestamps: true });
exports.VolunteerOpportunityModel = mongoose_1["default"].model('VolunteerOpportunity', exports.VolunteerOpportunitySchema);
