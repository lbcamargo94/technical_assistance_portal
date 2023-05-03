import { PrismaClient } from "@prisma/client";

const database = new PrismaClient({
  log: ["error", "warn", "info"],
});

export { database };
