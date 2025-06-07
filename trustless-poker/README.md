# Stacks Blockchain Card Game

A decentralized card game smart contract built on the Stacks blockchain, featuring provably fair card shuffling using cryptographic seeds.

## Overview

This smart contract implements a card game with deterministic, provably fair card shuffling. The system uses a combination of server and client seeds to generate unpredictable but verifiable card distributions, ensuring fairness and transparency in gameplay.

## Features

- **Provably Fair Shuffling**: Uses SHA-256 hash of combined server/client seeds
- **Deterministic Randomness**: Reproducible card shuffling for game verification
- **52-Card Standard Deck**: Full deck implementation with numeric card representation
- **Multi-Player Support**: Handles card dealing to multiple players
- **Blockchain Transparency**: All game states and shuffles are recorded on-chain

## Technical Implementation

### Card Shuffling Algorithm

The contract implements a deterministic pseudo-random shuffle using:

1. **Seed Combination**: Server seed + Client seed → SHA-256 hash
2. **Deterministic Logic**: Hash-based shuffle algorithm (simplified Fisher-Yates approach)
3. **Verifiable Results**: All shuffles can be independently verified

### Key Functions

- `shuffle-deck`: Core shuffling function using 32-byte seed
- `generate-shuffled-deck`: Retrieves seeds and generates shuffled deck for a game
- `deal-initial-cards`: Deals cards to players from shuffled deck

## Smart Contract Language

Written in **Clarity** - Stacks blockchain's smart contract language.

## Card Representation

Cards are represented as unsigned integers (u1-u52):
- u1-u13: First suit (e.g., Spades A-K)
- u14-u26: Second suit (e.g., Hearts A-K)
- u27-u39: Third suit (e.g., Diamonds A-K)
- u40-u52: Fourth suit (e.g., Clubs A-K)

## Usage

### Prerequisites

- Stacks blockchain node or testnet access
- Clarity CLI or Stacks development environment

### Deployment

1. Deploy the contract to Stacks blockchain
2. Initialize game with server/client seed pairs
3. Call game functions to start dealing cards

### Example Game Flow

```clarity
;; 1. Seeds are stored for game-id
(map-set random-seeds { game-id: u1 } 
  { server-seed: 0x..., client-seed: 0x... })

;; 2. Generate shuffled deck
(generate-shuffled-deck u1)

;; 3. Deal cards to players
(deal-initial-cards u1)
```

## Security Considerations

- Server seeds should be committed before client seeds are revealed
- Client seeds should be unpredictable and provided after server commitment
- Current implementation uses simplified shuffle - production should implement full Fisher-Yates

## Development Status

This is a development version with:
- ✅ Basic deterministic shuffling
- ✅ Seed-based randomness
- ⚠️ Simplified shuffle algorithm (production needs full Fisher-Yates)
- ⚠️ Error handling improvements needed

## Future Improvements

1. **Enhanced Shuffle Algorithm**: Full cryptographic Fisher-Yates implementation
2. **Commit-Reveal Scheme**: Proper seed commitment protocol
3. **Gas Optimization**: Reduce transaction costs for shuffling
4. **Advanced Error Handling**: Comprehensive error management
5. **Multi-Game Support**: Enhanced game state management

## Testing

Test the contract on Stacks testnet before mainnet deployment:

```bash
# Deploy to testnet
clarinet deploy --testnet

# Run integration tests
clarinet test
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Disclaimer

This smart contract is for educational and development purposes. Thoroughly audit and test before using in production with real value.

## Resources

- [Stacks Documentation](https://docs.stacks.co/)
- [Clarity Language Reference](https://docs.stacks.co/clarity/)
- [Stacks Testnet](https://testnet.stacks.co/)

---

**Note**: Always verify the randomness and fairness of card shuffling in gambling applications through independent audits.