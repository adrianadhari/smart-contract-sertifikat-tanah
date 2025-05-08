const hre = require("hardhat");

async function main() {
  const PendaftaranTanah = await hre.ethers.getContractFactory("PendaftaranTanah");
  const kontrak = await PendaftaranTanah.deploy();

  await kontrak.waitForDeployment();
  console.log("Kontrak PendaftaranTanah berhasil dideploy di:", kontrak.target);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
