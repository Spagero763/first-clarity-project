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
## Contributing

1. Fork the repository
2. Create feature branch
3. Run \clarinet check\
4. Run \
pm test\
5. Submit PR

## Resources

- [Clarity Documentation](https://docs.stacks.co/clarity)
- [Clarinet Guide](https://docs.hiro.so/clarinet)
