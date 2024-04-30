"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
exports.__esModule = true;
exports.AppModule = void 0;
// app.module.ts
var common_1 = require("@nestjs/common");
var mongoose_1 = require("@nestjs/mongoose"); // Corrected import
var auth_module_1 = require("./auth/auth.module");
var users_module_1 = require("./users/users.module");
var app_controller_1 = require("./app.controller");
var volunteer_opportunity_module_1 = require("./volunteer-opportunities/volunteer-opportunity.module");
var AppModule = /** @class */ (function () {
    function AppModule() {
    }
    AppModule = __decorate([
        (0, common_1.Module)({
            imports: [
                mongoose_1.MongooseModule.forRoot('mongodb://localhost:27017/Ankelba3'),
                auth_module_1.AuthModule,
                users_module_1.UsersModule,
                volunteer_opportunity_module_1.VolunteerOpportunitiesModule,
            ],
            controllers: [app_controller_1.AppController]
        })
    ], AppModule);
    return AppModule;
}());
exports.AppModule = AppModule;
