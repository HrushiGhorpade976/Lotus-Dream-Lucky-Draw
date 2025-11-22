import express from "express";
import dotenv from "dotenv";
import morgan from "morgan";
import cors from "cors";
import { connectDB } from "./config/db.js";
import drawRoutes from "./routes/drawRoutes.js";
import userRoutes from "./routes/userRoutes.js";
import winnerRoutes from "./routes/winnerRoutes.js";
import { errorHandler } from "./middleware/errorMiddleware.js";
import logger from "./utils/logger.js";

dotenv.config();
connectDB();

const app = express();
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Logging in dev
if (process.env.NODE_ENV !== "test") {
  app.use(morgan("dev"));
}

app.get("/", (req, res) => res.json({ ok: true, msg: "Lotus Dream API" }));

app.use("/api/draws", drawRoutes);
app.use("/api/users", userRoutes);
app.use("/api/winners", winnerRoutes);

// error handler (last)
app.use(errorHandler);

const PORT = process.env.PORT || 5000;
if (process.env.NODE_ENV !== "test") {
  app.listen(PORT, () => logger.info(`Server running on port ${PORT}`));
}

export default app;
