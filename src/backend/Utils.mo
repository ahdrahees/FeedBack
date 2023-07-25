import Hash "mo:base/Hash";
import Principal "mo:base/Principal";
import Int "mo:base/Int";
import Text "mo:base/Text";
import List "mo:base/List";


import Types "Types";
import Constants "Constants";
module {
    type Owner = Types.Owner;
    type Brand = Types.Brand;
    type Hash = Hash.Hash;
    type BrandHash = Types.BrandHash;
    
    type QueryOwner = Types.QueryOwner;

    public func compareBrand(c1 : Brand, c2 : Brand) : Bool {
        c1.created == c2.created and c1.owner == c2.owner and c1.brand == c2.brand
    };

    public func hashBrand(c : Brand) : Hash {
        let created = Int.toText(c.created);
        let owner = Principal.toText(c.owner);

        Text.hash(created # owner # c.brand);
    };

    public func hash(h : Hash) : Hash = h;

    public func validateBrand(c : Text) : Bool {
        c.size() <= Constants.MAX_BRAND_SIZE;
    };

    // User record conversion
    public func ownerToQueryOwner(owner : Owner) : QueryOwner {
        {
            id = owner.id;
            balance = owner.balance;
            brand = owner.brand;
            lastPost = owner.lastPost;
            post = List.toArray<BrandHash>(owner.post);
        } : QueryOwner;
    };

};
