// `module` refers to this being a smart contract
// The first `car` is the package name
// The second `car` is this particular module's name
module car::car {
    /* 
        - By using the `use` import, we're importing objects from the Sui standard library
            - This allows us to instantiate and manipulate objects
    */ 
    use sui::object::{Self, UID};
    /* 
        - This is an object, it has the `has key` annotation and a unique identifier (`UID`) as the first field
        - `has key` allows us to write this variable to the Sui network
        - There are 3 more fields besides `has key`: `store, `copy`, and `drop`
            - `store`: youll be able to store this variable inside another object
            - Ex: `struct Car has key, store` means that this car can live independently on the Sui network as the top level of an object and/or live in another object as well
            - `copy` & `delete` refer to you being able to duplicate and delete the struct respectively
    */
    struct Car has key {
        id: UID,
        speed: u8,
        acceleration: u8,
        handling: u8
    }
    /* 
        - `TxContext` is a priveleged object that gives us information about the transaction we're currently executing
            - Anytime you want to instantiate a new object, you need to pass in a mutable reference to `TxContext`
            - This is used to generate the UID for the Car
    */
    use sui::tx_context::{Self, TxContext};
    /*
        - Function Visibility Modifiers
            - `public` means that anyone can call and import this function into another module
            - `public friend` means that modules we give permission to can use this function
            - `entry` functions can be called directly in a transaction
                - Ex: making an AMM, our `swap` function would have to be a `public entry` one 
                    - Has to be `public` because anyone has to be able to interact w/ this function 
                    - Needs `entry` b/c you're actually calling the transaction
            - `entry` functions cannot return anything
    */
    fun new(speed: u8, acceleration: u8, handling: u8, ctx: &mut TxContext): Car {
        Car {
            id: object::new(ctx), // This is needed to instantiate a new unique identifier
            speed,
            acceleration,
            handling
        }
    }

    use sui::transfer;
    /*
    - Here we are transferring the car object to another address
    - Constructors are named `new` while entry functions are `create`

    */
    public entry fun create(speed: u8, acceleration: u8, handling: u8, ctx: &mut TxContext) {
        let car = new(speed, acceleration, handling, ctx); // Instantiation
        transfer::transfer(car, tx_context::sender(ctx)); // `tx_context::sender(ctx)` is the person calling this function
    }

    public entry fun transfer(car: Car, recipient: address) {
        transfer::transfer(car, recipient);
    }
    /*
        - This is a getter function
        - You can use dot notation to access an object's fields
    */
    public fun get_stats(self: &Car): (u8, u8, u8) {
        (self.speed, self.handling, self.acceleration)
    }

    public entry fun upgrade_speed(self: &mut Car, amount: u8) {
        self.speed = self.speed + amount;
    }

    public entry fun upgrade_acceleration(self: &mut Car, amount: u8) {
        self.acceleration = self.acceleration + amount;
    }

    public entry fun upgrade_handling(self: &mut Car, amount: u8) {
        self.handling = self.handling + amount;
    }    
}