"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.BookingModel = exports.BookingSchema = void 0;
const mongoose_1 = require("mongoose");
exports.BookingSchema = new mongoose_1.Schema({
    user: { type: mongoose_1.Schema.Types.ObjectId, ref: 'User', required: true },
    opportunity: {
        type: mongoose_1.Schema.Types.ObjectId,
        ref: 'VolunteerOpportunity',
        required: true,
    },
    // Additional fields as necessary
});
// Create the model and export it
exports.BookingModel = mongoose_1.default.model('Booking', exports.BookingSchema);
//# sourceMappingURL=booking.model.js.map