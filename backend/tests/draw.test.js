import { getRandomWinners } from "../utils/randomUtils.js";

describe("randomUtils", () => {
  test("selects correct number of winners", () => {
    const participants = [{ email: "a@x" }, { email: "b@x" }, { email: "c@x" }];
    const winners = getRandomWinners(participants, 2);
    expect(winners.length).toBe(2);
    // winners unique
    const emails = winners.map(w => w.email);
    expect(new Set(emails).size).toBe(2);
  });

  test("does not exceed length", () => {
    const participants = [{ email: "a@x" }];
    const winners = getRandomWinners(participants, 5);
    expect(winners.length).toBe(1);
  });
});
