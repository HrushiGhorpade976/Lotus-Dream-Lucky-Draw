import * as drawService from "../services/drawService.js";
import { success } from "../utils/apiResponse.js";

export const createDraw = async (req, res, next) => {
  try {
    const payload = { ...req.body, createdBy: req.user?._id };
    const draw = await drawService.createDraw(payload);
    return success(res, draw, "Draw created", 201);
  } catch (err) {
    next(err);
  }
};

export const listDraws = async (req, res, next) => {
  try {
    const draws = await drawService.getAllDraws();
    return success(res, draws, "Draws fetched", 200);
  } catch (err) {
    next(err);
  }
};

export const getDraw = async (req, res, next) => {
  try {
    const draw = await drawService.getDrawById(req.params.id);
    return success(res, draw, "Draw fetched", 200);
  } catch (err) {
    next(err);
  }
};

export const join = async (req, res, next) => {
  try {
    const participant = req.body;
    const draw = await drawService.joinDraw(req.params.id, participant);
    return success(res, draw, "Joined draw", 200);
  } catch (err) {
    next(err);
  }
};

export const pick = async (req, res, next) => {
  try {
    const count = Number(req.body.count) || 1;
    const draw = await drawService.pickWinners(req.params.id, count);
    return success(res, draw, "Winners picked", 200);
  } catch (err) {
    next(err);
  }
};
