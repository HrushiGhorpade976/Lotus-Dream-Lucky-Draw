import * as userService from "../services/userService.js";
import { success, error } from "../utils/apiResponse.js";

export const register = async (req, res, next) => {
  try {
    const { name, email, password } = req.body;
    const user = await userService.createUser({ name, email, password });
    const token = userService.generateToken(user);
    return success(res, { user, token }, "User registered", 201);
  } catch (err) {
    next(err);
  }
};

export const login = async (req, res, next) => {
  try {
    const { email, password } = req.body;
    const user = await userService.authUser(email, password);
    const token = userService.generateToken(user);
    return success(res, { user, token }, "Logged in", 200);
  } catch (err) {
    next(err);
  }
};
