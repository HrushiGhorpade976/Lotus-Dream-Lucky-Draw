import mongoose from "mongoose";
import logger from "../utils/logger.js";

export const connectDB = async () => {
  const uri = process.env.MONGO_URI || "mongodb://localhost:27017/lotus_dream";
  try {
    await mongoose.connect(uri, {
      // options default in mongoose v6+
    });
    logger.info("MongoDB connected");
  } catch (err) {
    logger.error("MongoDB connection error: " + err.message);
    process.exit(1);
  }
};
