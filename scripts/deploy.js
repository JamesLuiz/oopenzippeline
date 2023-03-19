
const hre = require("hardhat");

async function main() {
  const SkyLink = await hre.ethers.getContractFactory("SkyLink")
  const skylink = await SkyLink.deploy(40000000000, 100)


  await skylink.deployed()

  console.log(
    `deployed to ${skylink.address}`
  );
}


main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
