// SPDX-License-Identifier: MIT
// import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";
// import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";
// import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";
// import "@openzeppelin/contracts/token/ERC20/extensions/ERC20FlashMint.sol";

// contract SkyLInk is ERC20, ERC20Burnable, Ownable, ERC20Permit, ERC20Votes, ERC20FlashMint {
//     constructor() ERC20("SkyLInk", "SKL") ERC20Permit("SkyLInk") {
//         _mint(msg.sender, 40000000000 * 10 ** decimals());
//     }

//     function mint(address to, uint256 amount) public onlyOwner {
//         _mint(to, amount);
//     }

//     // The following functions are overrides required by Solidity.

//     function _afterTokenTransfer(address from, address to, uint256 amount)
//         internal
//         override(ERC20, ERC20Votes)
//     {
//         super._afterTokenTransfer(from, to, amount);
//     }

//     function _mint(address to, uint256 amount)
//         internal
//         override(ERC20, ERC20Votes)
//     {
//         super._mint(to, amount);
//     }

//     function _burn(address account, uint256 amount)
//         internal
//         override(ERC20, ERC20Votes)
//     {
//         super._burn(account, amount);
//     }
// }


pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract SkyLink is ERC20Capped, ERC20Burnable {

    address payable public owner;
    uint256 public blockReward;

    constructor(uint256 _cap, uint256 _reward) ERC20("SkyLink", "SKL") ERC20Capped(_cap * 10 ** decimals())  {
        owner = payable(msg.sender);
        _mint(owner, 20000000000 * 10 ** decimals());
        blockReward = _reward * 10 ** decimals();
    }

    function _mint(address account, uint256 amount) internal virtual override(ERC20Capped, ERC20) {
        require(ERC20.totalSupply() + amount <= cap(), "ERC20Capped: cap exceeded");
        super._mint(account, amount);
    }

    function _mintMinerReward() internal {
        _mint(block.coinbase, blockReward);
    }

    function _beforeTokenTransfer(address _from, address _to, uint256 _value) internal virtual override {
        if(_from != address(0) && _to != block.coinbase && block.coinbase != address(0)) {
            _mintMinerReward();
        }
        super._beforeTokenTransfer(_from, _to, _value);
    }

    function setBlockReward(uint256 _reward) public onlyOwner {
        blockReward = _reward * 10 ** decimals();
    }

    function terminate() public onlyOwner {
        selfdestruct(owner);
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }
}