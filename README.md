# Encode x Sui Educate: Making Your First Smart Contract Using Sui Move

## Objects
- Objects can be thought of as the building blocks of programming on Sui

```move
struct ThisIsAnObject has key {
    id: UID
}
```
- Every object has 2 things that make it an object: the `has` key modifier and `id`
  - The `key` refers to a key in global storage
    - You can evenutally write this object to global storage
  - `id:UID` refers to the unique global identifier generated at runtime
- Objects can have 4 different types of ownership:
  - Objects can be *owned by an address*
    - Ex: when purchasing an NFT, the JPEG literally lives under the purchaser's address
    - Can be seen when looking up address in Sui explorer
  - Objects can be *owned by another object*
    - Ex: in an RPG, a player can either equip or sell a sword
    - Since your player is an object, this shows that objects can be owned by other objects
  - Objects can also be *shared*
    - Shared objects isn't owned by anybody; it just exists in the Sui network and anyone can interact with it given if they satify the constraints
  - Objects can also be *immutable*
    - Immutable objects cannot be changed in any way, anyone can interact with it to essentially get a read-only reference 

## Recap
- Sui utilizes an object-centric programming model
- Objects represent ownership
- Capabilities can be used to gate admin access for functions
- Shared objects can be accessed by anyone
- Interacting w/ shared objects is subject to consensus