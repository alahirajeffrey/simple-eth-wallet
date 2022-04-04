const hre = require("hardhat");

async function main() {

    // get contract to deploy
    const Wallet = await hre.ethers.getContractFactory("Wallet");
    const wallet = await Wallet.deploy("Simple ether wallet deployed!");

    await wallet.deployed();

    console.log("Wallet deployed to:", wallet.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
