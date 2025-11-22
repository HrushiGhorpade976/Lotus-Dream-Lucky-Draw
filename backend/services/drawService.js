import Draw from "../models/Draw.js";
import { getRandomWinners } from "../utils/randomUtils.js";
import Winner from "../models/Winner.js";

export const createDraw = async (payload) => {
  return Draw.create(payload);
};

export const getAllDraws = async () => {
  return Draw.find().sort({ createdAt: -1 });
};

export const getDrawById = async (id) => {
  return Draw.findById(id);
};

export const joinDraw = async (drawId, participant) => {
  const draw = await Draw.findById(drawId);
  if (!draw) throw new Error("Draw not found");
  if (draw.maxParticipants && draw.participants.length >= draw.maxParticipants) {
    throw new Error("Draw is full");
  }
  draw.participants.push(participant);
  await draw.save();
  return draw;
};

export const pickWinners = async (drawId, count = 1) => {
  const draw = await Draw.findById(drawId);
  if (!draw) throw new Error("Draw not found");
  const winners = getRandomWinners(draw.participants, count);
  draw.winners = winners;
  await draw.save();

  // Persist winners separately (optional)
  const winnerDocs = winners.map(w => ({ drawId: draw._id, participant: { name: w.name, email: w.email } }));
  await Winner.insertMany(winnerDocs);
  return draw;
};
