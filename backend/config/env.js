/**
 * Create a .env file in backend/ with the following keys (example):
 *
 * PORT=5000
 * NODE_ENV=development
 * MONGO_URI=mongodb://localhost:27017/lotus_dream
 * JWT_SECRET=replace_with_a_strong_secret
 * JWT_EXPIRES_IN=7d
 *
 * For production, use a secrets manager and do NOT commit .env to git.
 */
PORT=5000
NODE_ENV=development
MONGO_URI=mongodb://localhost:27017/lotus_dream
JWT_SECRET=replace_with_a_long_random_secret
JWT_EXPIRES_IN=7d
