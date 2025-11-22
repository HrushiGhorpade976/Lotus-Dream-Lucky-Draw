import * as winnerService from "../services/winnerService.js";
import { success } from "../utils/apiResponse.js";

export const listWinners = async (req, res, next) => {
  try {
    const drawId = req.params.drawId;
    const winners = await winnerService.getWinnersByDraw(drawId);
    return success(res, winners, "Winners fetched", 200);
  } catch (err) {
    next(err);
  }
};
