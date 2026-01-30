# Flash Loan Arbitrage Bot

This repository features a professional-grade Solidity contract and supporting script for executing flash loans on EVM-compatible networks via Aave V3. It demonstrates how to leverage uncollateralized capital to exploit price discrepancies between decentralized exchanges.

## Features
- **Aave V3 Integration**: Implements `IFlashLoanSimpleReceiver` for low-fee borrowing.
- **Atomic Arbitrage**: Buy on Uniswap V3 and sell on Sushiswap within one block.
- **Gas Optimized**: Uses assembly for specific data decoding to minimize transaction costs.
- **Safety Checks**: Built-in logic to revert the transaction if the trade is not profitable after fees.

## Usage
1. Configure your RPC URL and Private Key in `hardhat.config.js`.
2. Update the token addresses and pool fees in `ArbitrageExecutor.sol`.
3. Deploy to a Mainnet Fork or Testnet and call `requestFlashLoan()`.
