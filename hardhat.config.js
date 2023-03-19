require("@nomicfoundation/hardhat-toolbox");
require ("dotenv").config()
/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  networks: {
    polygon_mumbai: {
      url: process.env.INFURA_RINKEBY_ENDPOINT,
      accounts: [process.env.PRIVATE_KEY]
    }
    
  }
};

// test tokens
// 0xa231385d26ABDFdb3c92E8Bb50Aa4ea866AfC5D3