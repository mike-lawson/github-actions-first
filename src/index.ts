import fs from "fs/promises";

const run = async () => {
  try {
    await fs.access(`${__dirname}/github-actions-second/README.md`);
    console.log("Good!");
  } catch (ex) {
    console.log("Bad job!");
  }
};

run();
