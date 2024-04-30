import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from 'mongoose';
import { Role } from '../model/role.enum';


@Schema({ timestamps: true })
export class User {
  @Prop({ required: true, unique: true })
  email: string;

  @Prop({ required: true })
  password: string;

  @Prop({
    type: [{ type: String, enum: Object.values(Role), default: Role.User }],
  })
  roles: Role[];

  @Prop({ required: true })
  phoneNumber: string;
}
export type UserDocument = User & Document;
export const UserSchema = SchemaFactory.createForClass(User);


