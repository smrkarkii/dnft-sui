// module dynamic_nft::dnft {

//     use sui::url::{Self, Url};
//     use sui::display;
//     use sui::package;
//     use std::string;
//     use sui::clock::{Self, Clock};
//     use sui::tx_context::{sender, TxContext};

   

   
//     public struct NFT has key, store {
//         id: UID,
//         name: string::String,
//         description: string::String,
//         day_image_url: Url,
//         night_image_url: Url,
//         image_url:Url,
//         current_mode: string::String,
//         last_updated: u64,
//         current_hour:u64
//     }

//     public struct DNFT has drop {}

//     public struct AdminCap has key {
//         id: UID,
//     }

//     fun init(otw: DNFT, ctx: &mut TxContext) {
//         let admin_cap = AdminCap {
//             id: object::new(ctx)
//         };

//         let keys = vector[
//             string::utf8(b"name"),
//             string::utf8(b"link"),
//             string::utf8(b"image_url"),
//             string::utf8(b"description"),
//         ];

//         let values = vector[
//             string::utf8(b"{name}"),
//             string::utf8(b"https://explorer.sui.io/object/{id}"),
//             string::utf8(b"{image_url}"),
//             string::utf8(b"{description}"),
//         ];

//         let publisher = package::claim(otw, ctx);
//         let mut display = display::new_with_fields<NFT>(&publisher, keys, values, ctx);
//         display::update_version(&mut display);

//         transfer::transfer(admin_cap, ctx.sender());
//         transfer::public_transfer(publisher, ctx.sender());
//         transfer::public_transfer(display, ctx.sender());
//     }

//     public fun get_current_image(nft: &NFT): &Url {
//         if (nft.current_mode == string::utf8(b"day")) {
//             &nft.day_image_url
//         } else {
//             &nft.night_image_url
//         }
//     }

//      //dark mode https://i.ibb.co/HHzGGhp/lighty-1.png
//     // light mode https://i.ibb.co/yg38p4J/lighty.png


//     public fun create_dynamic_nft(
//         recipient: address,
//         name: vector<u8>,
//         description: vector<u8>,
//         day_image_url: vector<u8>,
//         night_image_url: vector<u8>,
//         clock: &Clock,
//         ctx: &mut TxContext
//     ) {
//         let current_mode;
//         let current_time = timestamp_ms(clock);
//         let hour = (current_time / 3600000) % 24;
//         let current_image;

//         if (hour >= 6 && hour < 18) {
//             current_mode = string::utf8(b"day");
//             current_image = url::new_unsafe_from_bytes(day_image_url);
//         } else {
//             current_mode = string::utf8(b"night");
//             current_image = url::new_unsafe_from_bytes(night_image_url);
//         };



//         let nft = NFT {
//             id: object::new(ctx),
//             name: string::utf8(name),
//             description: string::utf8(description),
//             day_image_url: url::new_unsafe_from_bytes(day_image_url),
//             night_image_url: url::new_unsafe_from_bytes(night_image_url),
//             image_url:current_image,
//             current_mode: current_mode,
//             last_updated: timestamp_ms(clock),
//             current_hour:hour
//         };

//         transfer::public_transfer(nft, recipient);
//     }

//     public fun timestamp_ms(clock: &Clock): u64 {
//         clock.timestamp_ms()
//     }

//     public fun get_hour(clock:&Clock): u64 {
//         let curr = clock.timestamp_ms();
//          (curr/3600000) % 24
//     }

//     public fun update_mode(nft: &mut NFT, clock: &Clock) {
//         let current_time = timestamp_ms(clock);
//         let hour = (current_time / 3600000) % 24;
        

//         if (hour >= 6 && hour < 18) {
//             nft.current_mode = string::utf8(b"day");
//             nft.image_url = nft.day_image_url;
          
//         } else {
//             nft.current_mode = string::utf8(b"night");
//              nft.image_url = nft.night_image_url;
            
//         };

//         nft.last_updated = current_time;
//           nft.current_hour = hour;
//     }
// }
