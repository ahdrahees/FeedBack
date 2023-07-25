import Nat "mo:base/Nat";
import Time "mo:base/Time";
import List "mo:base/List";
import Error "mo:base/Error";

import Types "Types";
import Constants "Constants";
import { validateBrand; hashBrand } "Utils";
import Principal "mo:base/Principal";

module {
    type State = Types.State;
    type LikeResult = Types.LikeResult;

    type Brand = Types.Brand;
    type Reward = Types.Reward;
    type BrandHash = Types.BrandHash;

    type PostResult = Types.PostResult;
    type QueryBrand = Types.QueryBrand;

    /*public func likeBrand(state : State, hash : BrandHash, liker : Principal) : async* LikeResult {

        switch (state.brandUsers.get(liker)) {
            case (null) { return #err(#UserNotFound) };
            case (?user) {

                let now = Time.now();

                // Check if user has liked this comment before
                if (List.some<BrandHash>(user.feedBack, func(h : BrandHash) : Bool { h == hash })) {
                    return #err(#AlreadyLiked);
                };

                // Check if user has liked recently
        if (now - user.lastFeedBack < LIKE_INTERVAL) {
          return #err(#TimeRemaining(LIKE_INTERVAL - (now - user.lastLike)));
        };

        // Add comment to user's liked comments list
        let newUser : User = {
          user with
          lastLike = now;
          lastPost = now;
          likes = List.push<CommentHash>(hash, user.likes);
        };

                switch (brandUsers.get(brand.owner)) {
                    case (null) {
                        throw Error.reject("Brand has now owner");
                    };
                    case (?User) {
                        state.treasury[0] -= Constants.FEEDBACK_REWARD;
                        state.brandStore.put(hash, (brand, reward + Constants.FEEDBACK_REWARD));
                        brandUsers.put(brand.owner, (id, balance + Constants.FEEDBACK_REWARD));
                    };  sahara!nd!@

                };
            };
        };
        ?();
    };*/
};