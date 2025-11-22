import Winner from "../models/Winner.js";

export const getWinnersByDraw = async (drawId) => {
  return Winner.find({ drawId }).sort({ pickedAt: -1 });
};
