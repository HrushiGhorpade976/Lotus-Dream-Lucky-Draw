import express from "express";
import { body } from "express-validator";
import { validateRequest } from "../middleware/validateRequest.js";
import * as userController from "../controllers/userController.js";

const router = express.Router();

router.post(
  "/register",
  [
    body("name").notEmpty().withMessage("Name is required"),
    body("email").isEmail().withMessage("Valid email required"),
    body("password").isLength({ min: 6 }).withMessage("Password min 6 chars")
  ],
  validateRequest,
  userController.register
);

router.post(
  "/login",
  [
    body("email").isEmail(),
    body("password").notEmpty()
  ],
  validateRequest,
  userController.login
);

export default router;
