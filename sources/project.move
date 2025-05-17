module MyModule::ProductProvenanceTracker {
    use std::string::String;
    use aptos_framework::timestamp;
    use aptos_framework::signer;

    /// Error codes
    const E_NOT_AUTHORIZED: u64 = 1;
    const E_PRODUCT_ALREADY_EXISTS: u64 = 2;
    const E_PRODUCT_NOT_FOUND: u64 = 3;

    /// Struct representing a product with provenance information
    struct Product has store, key {
        id: String,                // Unique product identifier
        manufacturer: address,     // Original product manufacturer
        current_owner: address,    // Current owner of the product
        creation_date: u64,        // Timestamp of product creation
        description: String,       // Product description
    }

    /// Function to register a new product with its provenance information
    public entry fun register_product(
        manufacturer: &signer,
        id: String,
        description: String
    ) {
        let manufacturer_addr = signer::address_of(manufacturer);
        
        // Check if the product already exists
        assert!(!exists<Product>(manufacturer_addr), E_PRODUCT_ALREADY_EXISTS);
        
        let product = Product {
            id,
            manufacturer: manufacturer_addr,
            current_owner: manufacturer_addr,
            creation_date: timestamp::now_microseconds(),
            description,
        };
        
        move_to(manufacturer, product);
    }

    /// Function to transfer product ownership to a new owner
    public entry fun transfer_ownership(
        current_owner: &signer,
        new_owner: address,
    ) acquires Product {
        let owner_addr = signer::address_of(current_owner);
        
        // Check if the product exists and is owned by the sender
        assert!(exists<Product>(owner_addr), E_PRODUCT_NOT_FOUND);
        
        let product = borrow_global_mut<Product>(owner_addr);
        assert!(product.current_owner == owner_addr, E_NOT_AUTHORIZED);
        
        // Update ownership
        product.current_owner = new_owner;
    }
}