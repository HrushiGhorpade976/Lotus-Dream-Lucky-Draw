/**
 * getRandomWinners - picks `count` unique items from participants array
 * participants expected as array of objects (with email or id)
 */
export const getRandomWinners = (participants = [], count = 1) => {
  if (!Array.isArray(participants)) return [];
  const copy = [...participants];
  const winners = [];
  const max = Math.min(count, copy.length);
  for (let i = 0; i < max; i++) {
    const idx = Math.floor(Math.random() * copy.length);
    winners.push(copy[idx]);
    copy.splice(idx, 1);
  }
  return winners;
};
