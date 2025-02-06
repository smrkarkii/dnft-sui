
// module dynamic_nft::dynamic_ticket {

// // use sui::dynamic_field;
// use sui::url::{ Self,Url};
// use std::string::{ Self};
// use sui::package;
// use sui::display;

// const ETicketAlreadyUsed:u64 = 0;

// //https://i.ibb.co/vPKnhnW/Screenshot-2025-01-19-140832.png - used
//     //https://i.ibb.co/2Mz8RCT/Screenshot-2025-01-19-140839.png - not used



// public struct Ticket has key, store {
//     id:UID,
//     name:string::String,
//     count:u64,
//     url:Url,
//     spent:bool
    
// }



// public struct DYNAMIC_TICKET has drop {}

// public struct AdminCap has key {
//     id:UID
// }


// fun init(otw:DYNAMIC_TICKET,  ctx: &mut TxContext) {

//    let admin_cap = AdminCap {
//         id:object::new(ctx)
//     };

//     //display standard

//     let keys = vector[
//         b"name".to_string(),
//         b"image_url".to_string(),
       
//           ];

//     let values = vector[
//         b"{name}".to_string(),
//         b"{url}".to_string(),
      
            
//           ];

//     let publisher = package::claim(otw, ctx);
//     let mut display = display::new_with_fields<Ticket>(&publisher,keys, values, ctx);
//     display.update_version();

//     transfer::transfer(admin_cap, ctx.sender());
//     transfer::public_transfer(publisher, ctx.sender());
//     transfer::public_transfer(display, ctx.sender());
    


// }

// public fun mintTicket(count:u64, ctx:&mut TxContext) {

//     let tick = Ticket {
//         id:object::new(ctx),
//         name:string::utf8(b"Event Ticket"),
//         count:count,
//         url:url::new_unsafe_from_bytes(b"https://i.ibb.co/2Mz8RCT/Screenshot-2025-01-19-140839.png"),
//         spent:false
//     };

//     transfer::public_transfer(tick, tx_context::sender(ctx));
// } 


// public fun useTicket( ticket:&mut Ticket, ctx:&mut TxContext) {

//     assert!(ticket.spent == false, ETicketAlreadyUsed);
//     ticket.spent = true;
//     ticket.url = url::new_unsafe_from_bytes(b"https://i.ibb.co/vPKnhnW/Screenshot-2025-01-19-140832.png");
// }

// }