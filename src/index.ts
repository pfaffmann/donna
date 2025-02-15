import { createPdf } from "./pdf";
import * as fs from "fs/promises";
import { parse } from "path";

async function main() {
  console.log("Startup");

  const pdf = await createPdf();
  const outputPath = parse(`${process.env.DONNA_PDF_PATH}`);

  try {
    await fs.writeFile(`${outputPath.dir}/${outputPath.name}/test.pdf`, pdf);
    console.log(`${outputPath.dir}/${outputPath.name}/test.pdf`);
  } catch (error) {
    console.error(error);
  }
}

main();

setTimeout(() => {}, 1 << 30);
