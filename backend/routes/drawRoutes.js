import express from "express";
import { body } from "express-validator";
import { validateRequest } from "../middleware/validateRequest.js";
import * as drawController from "../controllers/drawController.js";
import { protect } from "../middleware/authMiddleware.js";

const router = express.Router();

router.get("/", drawController.listDraws);
router.get("/:id", drawController.getDraw);

// protected endpoints
router.post(
  "/",
  protect,
  [
    body("name").notEmpty().withMessage("Name required")
  ],
  validateRequest,
  drawController.createDraw
);

router.post("/:id/join", [
  body("name").notEmpty(),
  body("email").isEmail()
], validateRequest, drawController.join);

// pick winners (admin/protect)
router.post("/:id/pick", protect, drawController.pick);

export default router;
