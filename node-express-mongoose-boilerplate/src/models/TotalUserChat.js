import mongoose from 'mongoose';

const { Schema } = mongoose;

const schema = new Schema(
  {
    user_id: String,
    plan: String,
    total_user_chat: Number,
    cpid: Schema.Types.Mixed,
  },
  { collection: 'total_user_chats', read: 'secondary' },
);
schema.index({ user_id: 1 });

export default mongoose.model('TotalUserChat', schema);
