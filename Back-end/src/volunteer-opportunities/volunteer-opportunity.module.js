"use strict";
// src/volunteer-opportunities/volunteer-opportunities.module.ts
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
exports.__esModule = true;
exports.VolunteerOpportunitiesModule = void 0;
var common_1 = require("@nestjs/common");
var mongoose_1 = require("@nestjs/mongoose");
var volunteer_opportunity_controller_1 = require("./volunteer-opportunity.controller");
var volunteer_opportunity_service_1 = require("./volunteer-opportunity.service");
var volunteer_opportunity_model_1 = require("./volunteer-opportunity.model");
var booking_model_1 = require("./booking.model");
var VolunteerOpportunitiesModule = /** @class */ (function () {
    function VolunteerOpportunitiesModule() {
    }
    VolunteerOpportunitiesModule = __decorate([
        (0, common_1.Module)({
            imports: [
                mongoose_1.MongooseModule.forFeature([
                    { name: 'VolunteerOpportunity', schema: volunteer_opportunity_model_1.VolunteerOpportunitySchema },
                    { name: 'Booking', schema: booking_model_1.BookingSchema },
                ]),
            ],
            controllers: [volunteer_opportunity_controller_1.VolunteerOpportunitiesController],
            providers: [volunteer_opportunity_service_1.VolunteerOpportunitiesService]
        })
    ], VolunteerOpportunitiesModule);
    return VolunteerOpportunitiesModule;
}());
exports.VolunteerOpportunitiesModule = VolunteerOpportunitiesModule;
