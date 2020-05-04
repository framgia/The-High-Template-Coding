import mongoose from 'mongoose';

const schema = new mongoose.Schema(
  {
    limit_user_flg: Number,
    locale: String,
    email: String,
    plan: String,
    delete_flg: Number,
  },
  { read: 'secondary' },
);
schema.index({ email: 1 });

export default mongoose.model('User', schema);
