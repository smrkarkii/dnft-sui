// dynamic nft using svgs base image and attributes

module dynamic_nft::dnft {

     use sui::url::{Self};
    use sui::display;
    use sui::package;
    use std::string;
    use sui::event;
 


    public struct NFT has key {
        id:UID,
        name:string::String,
        description:string::String,
        image_url:url::Url,
        hair_color:string::String,
       weapon_type:string::String

    }
    
    public struct AdminCap has key, store {
        id:UID
    }

     public struct NFTMinted has copy, drop {
        nft_id: ID,
        receiver: address,
        name: string::String,
    }

    public struct TraitChanged has copy, drop {
        nft_id: ID,
        trait_type: string::String,
        new_value: string::String,
    }

  

    public struct DNFT has drop {}

      fun init(otw: DNFT, ctx: &mut TxContext) {
        let admin_cap = AdminCap{
            id:object::new(ctx)
        };

        let keys = vector[
            b"name".to_string(),
            b"link".to_string(),
            b"image_url".to_string(),
            b"description".to_string(),
          
            b"project_url".to_string(),
            b"creator".to_string(),

        ];

        let values = vector[
            b"{name}".to_string(),
            b"https://explorer.sui.io/object/{id}".to_string(),
            b"{image_url}".to_string(),
            b"{description}".to_string(),
         
            b"https://dnft.xyz".to_string(),
            b"dNFT".to_string()
        ];

        let publisher = package::claim(otw, ctx);
        let mut display = display::new_with_fields<NFT>(&publisher, keys, values, ctx);
        display.update_version();

        transfer::transfer(admin_cap, ctx.sender());
        transfer::public_transfer(publisher, ctx.sender());
        transfer::public_transfer(display, ctx.sender());
    }


    public fun mintNFT(_:&AdminCap,  
    name:vector<u8>,
        description: vector<u8>,
        url: vector<u8>,
        hair_color: vector<u8>,
        weapon_type: vector<u8>,
        receiver:address,
        ctx: &mut TxContext) {
        
        let nft = NFT {
              id: object::new(ctx),
            name:string::utf8(name),
            description:string::utf8(description),
            image_url: url::new_unsafe_from_bytes(url),
            hair_color:string::utf8(hair_color),
            weapon_type:string::utf8(weapon_type),
        };

         let nft_id = object::id(&nft);

        transfer::transfer(nft,receiver );
       
         event::emit(NFTMinted {
            nft_id: nft_id,
            receiver: receiver,
            name: string::utf8(name),
        });

    }

     public fun change_hair_color(
        nft: &mut NFT,
        new_color: string::String,
        _ctx: &mut TxContext
    ) {
        
        nft.hair_color = new_color;

        event::emit(TraitChanged {
            nft_id: object::id(nft),
            trait_type: string::utf8(b"hair_color"),
            new_value: new_color,
        });
    }



     public fun change_weapon(
        nft: &mut NFT,
        new_weapon: string::String,
        _ctx: &mut TxContext
    ) {
      
        nft.weapon_type = new_weapon;

        event::emit(TraitChanged {
            nft_id: object::id(nft),
            trait_type: string::utf8(b"weapon_type"),
            new_value: new_weapon,
        });
    }


    
    public fun add_admin(_: &AdminCap, new_admin: address, ctx: &mut TxContext) {
    
    let new_admin_cap = AdminCap {
        id: object::new(ctx)
    };

  
    transfer::public_transfer(new_admin_cap, new_admin);
}




}