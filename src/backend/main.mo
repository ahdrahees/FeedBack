// Tokenized Brand Example
// For demonstration purposes only.
// Tokens are not transferable.

// import Time "mo:base/Time";
// import Int "mo:base/Int";
import Array "mo:base/Array";
import List "mo:base/List";
import Iter "mo:base/Iter";
import Hash "mo:base/Hash";
import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";

import Error "mo:base/Error";
import Types "Types";
import Constants "Constants";
import Utils "Utils";
import Brands "Brands";

actor {
    type Brand = Types.Brand;
    type Reward = Types.Reward;
    type BrandHash = Types.BrandHash;

    type User = Types.User;
    type Owner = Types.Owner;

    type Treasury = Types.Treasury;
    type BrandUsers = Types.BrandUsers;
    type BrandStore = Types.BrandStore;
    type BrandOwner = Types.BrandOwner;
    type BrandHistory = Types.BrandHistory;

    type State = Types.State;
    type Owners = Types.Owners;

    type PostResult = Types.PostResult;
    type QueryBrand = Types.QueryBrand;
    type QueryOwner = Types.QueryOwner;

    stable var stablebrandUsers : [(Principal, User)] = [];
    stable var stableOwners : [(Principal, Owner)] = [];
    stable var stableBrandOwner : [(Principal, Owner)] = [];
    stable var stableBrandStore : [(BrandHash, Brand)] = [];
    stable var stableBrandHistory : [BrandHash] = [];
    stable var stableTreasury : Treasury = Constants.TOTAL_SUPPLY;

    let state : State = object {

        public let brandUsers : BrandUsers = HashMap.fromIter<Principal, User>(
            Array.vals(stablebrandUsers),
            1000,
            Principal.equal,
            Principal.hash,
        );
        public let owners : Owners = HashMap.fromIter<Principal, Owner>(
            Array.vals(stableOwners),
            1000,
            Principal.equal,
            Principal.hash,
        );
        public let brandOwner : BrandOwner = HashMap.fromIter<Principal, Owner>(
            Array.vals(stableBrandOwner),
            1000,
            Principal.equal,
            Principal.hash,
        );

        public let brandStore : BrandStore = HashMap.fromIter<BrandHash, Brand>(
            Array.vals(stableBrandStore),
            10_000,
            Hash.equal,
            Utils.hash,
        );

       public var brandHistory : BrandHistory = List.fromArray<BrandHash>(stableBrandHistory);

        public var treasury = stableTreasury;

    };
   // public methods

    public shared (msg) func register() : async QueryOwner {
    // Anonymous users cannot register
        if (Principal.isAnonymous(msg.caller)) throw Error.reject("Anonymous owners cannot register");

        Brands.register(state.owners, msg.caller);

    };
    
    public shared (msg) func postBrand(brand : Text) : async PostResult {
        if (Principal.isAnonymous(msg.caller)) return #err(#AnonNotAllowed);

        Brands.postBrand(state, msg.caller, brand);
    };

    public query func allBrands() : async [QueryBrand] {

        Brands.allBrands(state);
    };

    public query func tokenTreasury() : async Int { state.treasury };
    
    // UPGRADING

    // Save state to stable arrays
    system func preupgrade() {
        stablebrandUsers := Iter.toArray<(Principal, User)>(
            state.brandUsers.entries()
        );

        stableBrandStore := Iter.toArray<(BrandHash, Brand)>(
            state.brandStore.entries()
        );

        stableBrandHistory := List.toArray<BrandHash>(
            state.brandHistory
        );

        stableTreasury := state.treasury;
    };

    // Empty stable arrays to save memory
    system func postupgrade() {
        stablebrandUsers := [];
        stableBrandStore := [];
        stableBrandHistory := [];
    };
};
