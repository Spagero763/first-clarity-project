# First Clarity Project - Testnet Faucet

A testnet faucet contract built with Clarity for the Stacks blockchain.

## Features

- Rate-limited token distribution
- 24-hour cooldown between claims
- User claim tracking
- Admin controls for pause/enable
- Emergency withdrawal function

## Contract Functions

| Function | Description |
|----------|-------------|
| \claim\ | Claim tokens from faucet |
| \und\ | Add tokens to faucet |
| \can-claim\ | Check if user can claim |
| \get-faucet-balance\ | Get available balance |

## Quick Start

\\\ash
clarinet check
clarinet console
npm test
\\\

## License

MIT
