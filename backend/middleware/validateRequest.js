import { validationResult } from "express-validator";

export const validateRequest = (req, res, next) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    const mapped = errors.array().map(e => ({ param: e.param, msg: e.msg }));
    return res.status(422).json({ success: false, errors: mapped });
  }
  next();
};
