"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __generator = (this && this.__generator) || function (thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g;
    return g = { next: verb(0), "throw": verb(1), "return": verb(2) }, typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (_) try {
            if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [op[0] & 2, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
};
exports.__esModule = true;
exports.VolunteerOpportunitiesService = void 0;
var common_1 = require("@nestjs/common");
var mongoose_1 = require("@nestjs/mongoose");
var VolunteerOpportunitiesService = /** @class */ (function () {
    function VolunteerOpportunitiesService(opportunityModel, bookingModel) {
        this.opportunityModel = opportunityModel;
        this.bookingModel = bookingModel;
    }
    // Existing opportunity methods...
    VolunteerOpportunitiesService.prototype.create = function (opportunityData) {
        return __awaiter(this, void 0, void 0, function () {
            var newOpportunity;
            return __generator(this, function (_a) {
                newOpportunity = new this.opportunityModel(opportunityData);
                return [2 /*return*/, newOpportunity.save()];
            });
        });
    };
    VolunteerOpportunitiesService.prototype.findAll = function () {
        return __awaiter(this, void 0, void 0, function () {
            return __generator(this, function (_a) {
                return [2 /*return*/, this.opportunityModel.find().exec()];
            });
        });
    };
    VolunteerOpportunitiesService.prototype.update = function (id, opportunityData) {
        return __awaiter(this, void 0, void 0, function () {
            return __generator(this, function (_a) {
                return [2 /*return*/, this.opportunityModel
                        .findByIdAndUpdate(id, opportunityData, { "new": true })
                        .exec()];
            });
        });
    };
    VolunteerOpportunitiesService.prototype.remove = function (id) {
        return __awaiter(this, void 0, void 0, function () {
            return __generator(this, function (_a) {
                return [2 /*return*/, this.opportunityModel.findOneAndDelete({ _id: id }).exec()];
            });
        });
    };
    // Booking functions
    VolunteerOpportunitiesService.prototype.bookOpportunity = function (userId, opportunityId) {
        return __awaiter(this, void 0, void 0, function () {
            var newBooking, error_1;
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0:
                        _a.trys.push([0, 2, , 3]);
                        console.log("Booking opportunity: ".concat(opportunityId, " for user: ").concat(userId));
                        newBooking = new this.bookingModel({
                            user: userId,
                            opportunity: opportunityId
                        });
                        return [4 /*yield*/, newBooking.save()];
                    case 1: return [2 /*return*/, _a.sent()];
                    case 2:
                        error_1 = _a.sent();
                        console.error('Error booking opportunity:', error_1);
                        throw error_1; // Re-throw the error so it can be handled by NestJS
                    case 3: return [2 /*return*/];
                }
            });
        });
    };
    VolunteerOpportunitiesService.prototype.getUserBookings = function (userId) {
        return __awaiter(this, void 0, void 0, function () {
            return __generator(this, function (_a) {
                return [2 /*return*/, this.bookingModel
                        .find({ user: userId })
                        .populate('opportunity')
                        .exec()];
            });
        });
    };
    VolunteerOpportunitiesService.prototype.unbookOpportunity = function (bookingId) {
        return __awaiter(this, void 0, void 0, function () {
            return __generator(this, function (_a) {
                return [2 /*return*/, this.bookingModel.findOneAndDelete({ _id: bookingId }).exec()];
            });
        });
    };
    VolunteerOpportunitiesService.prototype.getOpportunityBookings = function (opportunityId) {
        return __awaiter(this, void 0, void 0, function () {
            return __generator(this, function (_a) {
                return [2 /*return*/, this.bookingModel
                        .find({ opportunity: opportunityId })
                        .populate('user')
                        .exec()];
            });
        });
    };
    VolunteerOpportunitiesService = __decorate([
        (0, common_1.Injectable)(),
        __param(0, (0, mongoose_1.InjectModel)('VolunteerOpportunity')),
        __param(1, (0, mongoose_1.InjectModel)('Booking'))
    ], VolunteerOpportunitiesService);
    return VolunteerOpportunitiesService;
}());
exports.VolunteerOpportunitiesService = VolunteerOpportunitiesService;
