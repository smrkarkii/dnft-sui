// module dynamic_nft::dy_field {

//     use sui::dynamic_field as df;
//     use sui::dynamic_object_field as dof;

//     struct Parent has key {
//         id:UID
//     }

//     struct DFChild has store {
//         count:u64
//     }

//     struct DOFChild has key, store {
//         id:UID,
//         count:u64
//     }

// }

//     fun add_dfchild( parent: &mut Parent, dfchild:DFChild, name:vector<u64>) {
//         df::add(&mut parent.id, name, dfchild);
//     }

//     fun add_dofchild( parent: &mut Parent, dfchild:DOFChild, name:vector<u64>) {
//         dof::add(&mut parent.id, name, dofchild);
//     }

//     //access 
//     //borrow a refernece to child but only for dof as df don't have id 

//     fun borrow_dofchild(child:&DOFChild) :&DOFChild {
//         child
//     }

// //via parent
//     fun borrow_dfchild_via_parent(parent:&Parent, child_name:vector<u8>):&DFChild {
//         df::borrow<vector<u8>,DFChild>(&parent.id, child_name); //field::borrow<K, V>:
//     }

//     fun borrow_dofchild_via_parent(parent:&Parent, child_name:vector<u8>):DOFChild {
//         dof::borrow<vector<u8>, DOFChild>(&parent.id, child_name);
//     }

//     //mutate

//     fun mutate_dfchild(child:&mut DFChild) {//how is reference to df accesed??? no id
//         child.count = child.count + 1;
//     }

//     fun mutate_dofchild_via_parent(parent:&mut Parent, child_name:vector<u8>) {
//         let child = dof::borrow<vector<u8>,DOFChild>(&mut parent.id, child_name);
//         child.count = child.count + 1;
//     }


// //removing dynamic field
//     fun remove_dofchild(parent:&mut Parent, child_name:vector<u8>) {
//         let DOFChild{id, count: _} = dof::borrow<vector<u8>,DOFChild>(&mut parent.id,child_name);
//         object::delete(id); 
//     }

