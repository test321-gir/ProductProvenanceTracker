# Product Provenance Tracker

A Move smart contract built on the Aptos blockchain for tracking product provenance and ownership history.

## Overview

This smart contract provides a simple but effective way to register products and track their ownership transfers on the Aptos blockchain. It enables manufacturers to create verifiable records of their products and maintain a transparent chain of custody as products change hands.

## Features

- **Product Registration**: Manufacturers can register new products with unique identifiers
- **Ownership Tracking**: Each product maintains a record of its current owner
- **Secure Transfers**: Only the current owner can transfer ownership to another address
- **Timestamped Creation**: Each product records its creation time for provenance verification

## Contract Structure

The contract consists of two main functions:

1. `register_product`: Creates a new product with manufacturer information
2. `transfer_ownership`: Transfers ownership of a product to a new address

## Usage

### Deploying the Contract

1. Install the Aptos CLI if you haven't already:
   ```
   curl -fsSL "https://aptos.dev/scripts/install_cli.py" | python3
   ```

2. Create an account on the Aptos blockchain:
   ```
   aptos init
   ```

3. Compile and deploy the contract:
   ```
   aptos move compile --named-addresses MyModule=<YOUR_ADDRESS>
   aptos move publish --named-addresses MyModule=<YOUR_ADDRESS>
   ```

### Interacting with the Contract

#### Register a Product

As a manufacturer, you can register a new product:

```
aptos move run \
  --function-id <YOUR_ADDRESS>::ProductProvenanceTracker::register_product \
  --args string:"PROD001" string:"Carbon Fiber Bicycle Frame" 
```

#### Transfer Ownership

As the current owner, you can transfer ownership to another address:

```
aptos move run \
  --function-id <YOUR_ADDRESS>::ProductProvenanceTracker::transfer_ownership \
  --args address:<NEW_OWNER_ADDRESS>
```

## Error Codes

The contract includes the following error codes:

- `E_NOT_AUTHORIZED (1)`: The signer is not authorized to perform this action
- `E_PRODUCT_ALREADY_EXISTS (2)`: A product with this ID already exists
- `E_PRODUCT_NOT_FOUND (3)`: The requested product does not exist

## Extension Ideas

The contract was designed to be minimal (40-50 lines) but can be extended with additional features:

- Product history tracking (storing previous owners)
- Certificate validation for authentic products
- Batch registration for multiple products
- Product metadata updates
- Expiration dates or warranty information

## License

[MIT License](LICENSE)

## Contact

For questions or contributions, please open an issue in the repository.
