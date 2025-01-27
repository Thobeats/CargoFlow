# CargoFlow

CargoFlow is a decentralized cargo shipment tracking and management system built on the Stacks blockchain. The smart contract is written in Clarity and designed to enable transparent, secure, and decentralized logistics management.

## Features

- **Add Cargo**: Register new cargo shipments with a description and default status of "Pending."
- **Update Cargo Status**: Update the status of a cargo shipment (e.g., "In Transit," "Delivered"). Only the owner of the cargo can perform this action.
- **Retrieve Cargo Details**: Fetch the details of a specific cargo shipment by its ID.

## How It Works

1. **Add Cargo**: Call the `add-cargo` function with a description of the shipment. This generates a unique ID for the cargo and stores it on the blockchain.
2. **Update Status**: Use the `update-cargo-status` function to modify the status of a shipment. Only the cargo's owner can update its status.
3. **Get Cargo**: Retrieve cargo details using the `get-cargo` function and the cargo's ID.

## Contract Functions

### `add-cargo (description (string-ascii 100)) -> uint`
- Adds a new cargo shipment with the provided description.
- Returns the unique ID of the new cargo.

### `update-cargo-status (cargo-id uint) (new-status (string-ascii 20)) -> bool`
- Updates the status of a cargo shipment.
- Can only be performed by the owner of the cargo.

### `get-cargo (cargo-id uint) -> {description, status, owner}`
- Retrieves details of a cargo shipment by its ID.

## Error Codes

- `ERR_CARGO_NOT_FOUND` (100): The specified cargo ID does not exist.
- `ERR_NOT_OWNER` (101): The caller is not the owner of the cargo.

## Development

### Prerequisites
- [Clarinet](https://docs.hiro.so/clarinet/installation): Ensure Clarinet is installed to test and deploy the contract.

### Testing
Run the following command to check for errors or warnings:
```bash
clarinet check