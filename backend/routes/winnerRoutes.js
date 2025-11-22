import express from "express";
import * as winnerController from "../controllers/winnerController.js";

const router = express.Router();

router.get("/:drawId", winnerController.listWinners);

export default router;
