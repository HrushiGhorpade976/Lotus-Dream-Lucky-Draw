import mongoose from "mongoose";

const participantSchema = new mongoose.Schema({
  name: String,
  email: String,
  joinedAt: { type: Date, default: Date.now },
});

const drawSchema = new mongoose.Schema({
  name: { type: String, required: true },
  description: { type: String, default: "" },
  entryFee: { type: Number, default: 0 },
  participants: { type: [participantSchema], default: [] },
  winners: { type: [participantSchema], default: [] },
  maxParticipants: { type: Number, default: 0 },
  createdBy: { type: mongoose.Schema.Types.ObjectId, ref: "User" },
  createdAt: { type: Date, default: Date.now }
});

export default mongoose.model("Draw", drawSchema);
