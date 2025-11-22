import request from "supertest";
import app from "../server.js";

// These tests expect a running test DB — they are illustrative.
// Better: mock mongoose or use in-memory mongodb (mongodb-memory-server).

describe("GET /", () => {
  test("root endpoint", async () => {
    const res = await request(app).get("/");
    expect(res.statusCode).toBe(200);
    expect(res.body.ok).toBe(true);
  });
});
