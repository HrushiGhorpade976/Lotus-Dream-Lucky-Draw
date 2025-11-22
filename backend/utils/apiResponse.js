export const success = (res, data = null, message = "OK", code = 200) => {
  return res.status(code).json({ success: true, message, data });
};

export const error = (res, message = "Server error", code = 500) => {
  return res.status(code).json({ success: false, message });
};
