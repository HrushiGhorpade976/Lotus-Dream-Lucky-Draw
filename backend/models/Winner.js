import mongoose from "mongoose";

const winnerSchema = new mongoose.Schema({
  drawId: { type: mongoose.Schema.Types.ObjectId, ref: "Draw", required: true },
  participant: {
    name: String,
    email: String
  },
  pickedAt: { type: Date, default: Date.now }
});

export default mongoose.model("Winner", winnerSchema);
