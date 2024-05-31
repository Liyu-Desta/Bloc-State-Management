import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { User, UserDocument } from './users.model';

@Injectable()
export class UsersService {
  constructor(@InjectModel(User.name) private userModel: Model<UserDocument>) {}
  
  async findOne(email: string): Promise<User | undefined> {
    return this.userModel.findOne({ email }).exec();
  }
  async createUser(userData: User): Promise<UserDocument> {
    const createdUser = new this.userModel(userData);
    return createdUser.save();
  }

  async getAllUsers(): Promise<UserDocument[]> {
    return this.userModel.find().exec();
  }

  async getUser(id: string): Promise<UserDocument> {
    return this.userModel.findById(id).exec();
  }

  async updateUser(id: string, updateData: Partial<User>): Promise<UserDocument> {
    return this.userModel.findByIdAndUpdate(id, updateData, { new: true }).exec();
  }

  async deleteUser(id: string): Promise<UserDocument> {
    return this.userModel.findByIdAndDelete(id).exec();
  }

  async updateRole(id: string, role: string): Promise<UserDocument> {
    return this.userModel.findByIdAndUpdate(id, { roles: [role] }, { new: true }).exec();
  }

  async getUserRole(id: string): Promise<string[]> {
    const user = await this.userModel.findById(id).exec();
    return user.roles;
  }
}