module car::car_admin {
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;

    struct AdminCapability has key {
        id: UID
    }
    /*
        - Any function starting with `fun init` isn't a `public` or `entry` function; it's only called ONCE when the module is published
        - In this function, we're instantiating a new `AdminCapability` object and sending it to the sender (the person publishing this module)
    */
    fun init(ctx: &mut TxContext) {
        transfer::transfer(AdminCapability {
            id: object::new(ctx),
        }, tx_context::sender(ctx))
    }
    /*
        - In Sui Move, anytime you don't want the compiler to throw an error b/c you didn't use a variable by the end of the function, prefix it w/ an underscore
    */
    public entry fun create(_: &AdminCapability, speed: u8, acceleration: u8, handling: u8, ctx: &mut TxContext) {
        let car = new(speed, acceleration, handling, ctx);
        transfer::transfer(car, tx_context::sender(ctx));
    }
}