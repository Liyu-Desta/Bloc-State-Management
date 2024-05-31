"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.VolunteerOpportunitiesService = void 0;
const common_1 = require("@nestjs/common");
const mongoose_1 = require("@nestjs/mongoose");
const mongoose_2 = require("mongoose");
let VolunteerOpportunitiesService = class VolunteerOpportunitiesService {
    constructor(opportunityModel, bookingModel) {
        this.opportunityModel = opportunityModel;
        this.bookingModel = bookingModel;
    }
    // Existing opportunity methods...
    async create(opportunityData) {
        const newOpportunity = new this.opportunityModel(opportunityData);
        return newOpportunity.save();
    }
    async findAll() {
        return this.opportunityModel.find().exec();
    }
    async update(id, opportunityData) {
        return this.opportunityModel
            .findByIdAndUpdate(id, opportunityData, { new: true })
            .exec();
    }
    async remove(id) {
        return this.opportunityModel.findOneAndDelete({ _id: id }).exec();
    }
    // Booking functions
    async bookOpportunity(userId, opportunityId) {
        try {
            console.log(`Booking opportunity: ${opportunityId} for user: ${userId}`);
            const newBooking = new this.bookingModel({
                userId: userId,
                opportunityId: opportunityId,
            });
            return await newBooking.save();
        }
        catch (error) {
            console.error('Error booking opportunity:', error);
            throw error; // Re-throw the error so it can be handled by NestJS
        }
    }
    async getUserBookings(userId) {
        try {
            const bookings = await this.bookingModel
                .find({ userId: userId })
                .populate('opportunityId')
                .exec();
            if (!bookings) {
                throw new Error('No bookings found for the user.');
            }
            return bookings;
        }
        catch (error) {
            // Handle the error here
            console.error('Error fetching user bookings:', error);
            throw error; // Re-throwing the error for further handling
        }
    }
    async unbookOpportunity(bookingId) {
        return this.bookingModel.findOneAndDelete({ _id: bookingId }).exec();
    }
    async getOpportunityBookings(opportunityId) {
        return this.bookingModel
            .find({ opportunity: opportunityId })
            .populate('user')
            .exec();
    }
    async updateBooking(bookingId, bookingData) {
        console.log("reached here");
        return this.bookingModel
            .findByIdAndUpdate(bookingId, bookingData, { new: true })
            .exec();
    }
};
VolunteerOpportunitiesService = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, mongoose_1.InjectModel)('VolunteerOpportunity')),
    __param(1, (0, mongoose_1.InjectModel)('Booking')),
    __metadata("design:paramtypes", [mongoose_2.Model,
        mongoose_2.Model])
], VolunteerOpportunitiesService);
exports.VolunteerOpportunitiesService = VolunteerOpportunitiesService;
//# sourceMappingURL=volunteer-opportunity.service.js.map