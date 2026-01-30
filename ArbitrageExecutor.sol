// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IFlashLoanSimpleReceiver} from "@aave/core-v3/contracts/flashloan/interfaces/IFlashLoanSimpleReceiver.sol";
import {IPoolAddressesProvider} from "@aave/core-v3/contracts/interfaces/IPoolAddressesProvider.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract ArbitrageExecutor is IFlashLoanSimpleReceiver {
    address private immutable owner;
    IPoolAddressesProvider public immutable ADDRESSES_PROVIDER;

    constructor(address _addressProvider) {
        ADDRESSES_PROVIDER = IPoolAddressesProvider(_addressProvider);
        owner = msg.sender;
    }

    function executeOperation(
        address asset,
        uint256 amount,
        uint256 premium,
        address initiator,
        bytes calldata params
    ) external override returns (bool) {
        // ARBITRAGE LOGIC GOES HERE
        // 1. Swap borrowed 'asset' on DEX A for 'TargetToken'
        // 2. Swap 'TargetToken' back to 'asset' on DEX B
        
        uint256 amountToRepay = amount + premium;
        require(IERC20(asset).balanceOf(address(this)) >= amountToRepay, "Not enough to repay loan");
        
        IERC20(asset).approve(address(ADDRESSES_PROVIDER.getPool()), amountToRepay);
        return true;
    }

    function requestFlashLoan(address _token, uint256 _amount) public {
        address receiverAddress = address(this);
        address asset = _token;
        uint256 amount = _amount;
        bytes memory params = "";
        uint16 referralCode = 0;

        ADDRESSES_PROVIDER.getPool().flashLoanSimple(
            receiverAddress,
            asset,
            amount,
            params,
            referralCode
        );
    }

    receive() external payable {}
}
