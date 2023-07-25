import HashMap "mo:base/HashMap";
import Hash "mo:base/Hash";
import List "mo:base/List";
import Result "mo:base/Result";

module {
    // Brand data
    public type Brand = {
        created : Int;
        owner : Principal;
        brand : Text;
        reward : Nat;
    };
    public type Reward = Int;
    public type BrandHash = Hash.Hash;

    // User data
    public type User = {
        id : Nat;
        balance : Int;
        lastPost : Int;
        lastFeedBack : Int;
        feedBack : List.List<BrandHash>;
    };

    // brandOwner data
    public type Owner = {
        id : Nat;
        owner : Principal;
        brand : Text;
        balance : Int;
        lastPost : Int;
        post : List.List<BrandHash>;
    };

    // public type Id = Nat;
    // public type Balance = Int;
    // public type LastPost = Int;

    // Stores
    public type Treasury = Nat;
    public type Owners = HashMap.HashMap<Principal, Owner>;
    public type BrandUsers = HashMap.HashMap<Principal, User>;
    public type BrandOwner = HashMap.HashMap<Principal, Owner>;
    public type BrandStore = HashMap.HashMap<BrandHash, Brand>;
    public type BrandHistory = List.List<BrandHash>;

    // stores
    public type State = object {
        owners : Owners;
        brandUsers : BrandUsers;
        brandOwner : BrandOwner;
        brandStore : BrandStore;
        var brandHistory : BrandHistory;
        var treasury : Treasury;
    };

    // Results

    type Error = {
        # TimeRemaining : Int;
        # AnonNotAllowed;
        # UserNotFound;
        # OwnerNotFound;
    };

    public type PostResult = Result.Result<(), PostError>;
    type PostError = Error or { # InvalidBrand;};

    public type LikeResult = Result.Result<Nat, LikeError>;
    type LikeError = Error or { # AlreadyLiked };

    // Queries
    public type QueryBrand = {
        created : Int;
        brandId : Text;
        brandBalance : Int;
        brand : Text;
    };

    public type QueryOwner = {
        id : Nat;
        balance : Int;
        brand : Text;
        lastPost : Int;
        post : [BrandHash];
    };
};
