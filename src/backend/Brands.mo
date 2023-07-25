import Nat "mo:base/Nat";
import Time "mo:base/Time";
import List "mo:base/List";
import Error "mo:base/Error";

import Types "Types";
import Constants "Constants";
import { validateBrand; hashBrand ;ownerToQueryOwner} "Utils";

module {
    type State = Types.State;
    type Owners = Types.Owners;
    type User = Types.User;
    type Owner = Types.Owner;

    type Brand = Types.Brand;
    type Reward = Types.Reward;
    type BrandHash = Types.BrandHash;

    type PostResult = Types.PostResult;
    type QueryBrand = Types.QueryBrand;
    type QueryOwner = Types.QueryOwner;

    public func register(owners : Owners, principal : Principal) : QueryOwner {
        switch (owners.get(principal)) {

            // If owner doesn't exist, create a new one
            case (null) {
                let newOwner : Owner = {
                    id = owners.size() + 1;
                    owner = principal;
                    balance = 0;
                    lastPost = 0;
                    brand = "";
                    post = List.nil<BrandHash>();
                };

                owners.put(principal, newOwner);

                ownerToQueryOwner(newOwner);
            };

            // If owner exists, return it
            case (?postowner) { ownerToQueryOwner(postowner) };
        };
    };

    public func postBrand(state : State, owner : Principal, brand : Text) : PostResult {
        if (not validateBrand(brand)) return #err(#InvalidBrand);

        switch (state.owners.get(owner)) {

            case (null) { return #err(#OwnerNotFound) };

            case (?postowner) {
                let now = Time.now();

                // Check if owner has posted recently
                if (now - postowner.lastPost < Constants.POST_INTERVAL) {
                    return #err(#TimeRemaining(Constants.POST_INTERVAL - (now - postowner.lastPost)));
                };

                let postBrand : Brand = {
                    created = now;
                    owner;
                    brand;
                    reward = 0;
                };

                let hash = hashBrand(postBrand);

                let balance = 100;

                let newOwner : Owner = {
                    id = 1;
                    owner = owner;
                    balance = balance;
                    brand = brand;
                    lastPost = now;
                    post = List.push<BrandHash>(hash, postowner.post);
                };

                // Update state within atomic block after all checks have passed
                state.owners.put(owner, newOwner);

                state.brandStore.put(hash, postBrand);

                state.brandHistory := List.push<BrandHash>(hash, state.brandHistory);

                #ok();

            };

        };

    };

    public func allBrands(state : State) : [QueryBrand] {

        let allHashes = List.take<BrandHash>(state.brandHistory, List.size(state.brandHistory));

        let brands = List.mapFilter<BrandHash, QueryBrand>(
            allHashes,
            func(hash : BrandHash) : ?QueryBrand {

                switch (state.brandStore.get(hash)) {
                    case (null) return null;
                    case (?brand) {
                        switch (state.owners.get(brand.owner)) {
                            case (null) return null;
                            case (?User) {
                                let brandId = "User" # Nat.toText(User.id);
                                ?{
                                    created = brand.created;
                                    brandId;
                                    brandBalance = User.balance;
                                    brand = brand.brand;
                                };
                            };
                        };
                    };
                };
            },
        );
        List.toArray(brands);
    };

};
