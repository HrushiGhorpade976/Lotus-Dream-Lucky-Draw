import logger from "../utils/logger.js";

export const errorHandler = (err, req, res, next) => {
  const status = err.statusCode || 500;
  const message = err.message || "Server Error";
  logger.error(`${req.method} ${req.originalUrl} - ${message}`);
  res.status(status).json({
    success: false,
    message,
    stack: process.env.NODE_ENV === "production" ? undefined : err.stack
  });
};
