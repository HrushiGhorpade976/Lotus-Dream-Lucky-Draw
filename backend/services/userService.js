import User from "../models/User.js";
import jwt from "jsonwebtoken";

export const createUser = async ({ name, email, password }) => {
  const exists = await User.findOne({ email });
  if (exists) throw new Error("Email already registered");
  const user = await User.create({ name, email, password });
  return user;
};

export const authUser = async (email, password) => {
  const user = await User.findOne({ email }).select("+password");
  if (!user) throw new Error("Invalid credentials");
  const match = await user.matchPassword(password);
  if (!match) throw new Error("Invalid credentials");
  return user;
};

export const generateToken = (user) => {
  const payload = { id: user._id };
  const token = jwt.sign(payload, process.env.JWT_SECRET, { expiresIn: process.env.JWT_EXPIRES_IN || "7d" });
  return token;
};
