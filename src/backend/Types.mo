import Map "mo:map/Map";
import Hash "mo:base/Hash";
import List "mo:base/List";
import R "mo:base/Result";
import Principal "mo:base/Principal";
import Error "mo:base/Error";
import Time "mo:base/Time";
// import Feedback "Feedback";

module {
    public type Time = Time.Time;
    public type Map<K,V> = Map.Map<K,V>;
    type Result<Ok, Err> = R.Result<Ok, Err>;
    type Status = {
        #Open;
        #Closed : Time;
    };
    // Brand data
    public type Post = {
        postId: Nat;
        created : Int;
        owner : Principal;
        brandName : Text;
        question : [Text];
        var reward : Nat;
        var feedbackList : List.List<FeedbackId>;   // to track feedbacks belongs to this post
        var status : Status;
    };
    public type Feedback = {
        feedbackId : FeedbackId;
        postId: Nat;
        created : Int;
        feedback: [Text];
        userName: Text;
    };

    // User data
    public type User = {
        id : Nat;
        principal: Principal;
        name : Text;
        var balance : Int;
        // lastPost : Int;
        var lastFeedback : Int;
        var feedbackList : List.List<FeedbackId>;   // To track all feedbacks by user
        var postList : List.List<PostId>;   // To know user already feedbacked Post

    };

    // brandOwner data
    public type Brand = {
        id : Nat;
        owner : Principal;
        name : Text;
        var balance : Nat;
        var lastPost : Int;
        var postList : List.List<PostId>;   // To know brand's own posts
    };

    public type Registration = {
        #Brand : Text;
        #User : Text;
    };
    // public type Brand2 = {
    //     id : Nat;
    //     owner : Principal;
    //     name : Text;
    //     balance : Nat;
    //     lastPost : Int;
    //     postList : List.List<PostId>;
    // };
    // public type Reward = Int;
    public type PostId = Nat;
    public type FeedbackId = Nat;

    // public type FeedbackHash = Hash.Hash;
    // public type PostHash = Hash.Hash;
    
    // public type Id = Nat;
    // public type Balance = Int;
    // public type LastPost = Int;

    // Stores 
    public type BrandMap = Map<Principal,Brand>;
    public type UserMap = Map<Principal, User>;
    public type PostMap = Map<PostId, Post>;
    public type FeedbackMap = Map<FeedbackId,Feedback>;

    // public type PostMap = Map<PostHash, Post>;
    // public type FeedbackMap = Map<FeedbackHash,Feedback>;


    // Stores
    // public type Treasury = Nat;


    type Error = {
        # TimeRemaining : Int;
        # AnonymousNotAllowed;
        # UserNotFound;
        # BrandNotFound;
        # OwnerNotFound;
        #PostNotFound;
    };

    public type RegisterResult = Result<(), RegisterError>; // both brand register and user reigster can use this
    public type RegisterError = Error or { #AlreadyRegisterd : (Principal, Text)};

    public type PostResult = Result<(), PostError>;
    type PostError = Error or { # LowBalance : Nat;};

    public type FeedbackResult = Result<(), FeedbackError>;
    type FeedbackError = Error or { #NoSpotLeft ; #AlreadyFeedbacked};

    public type QueryPostResult = Result<QueryPost, Error>;

    public type  QueryBrandResult =  Result<QueryBrand, QueryBrandError>;
    type QueryBrandError = Error or { #NotABrandOwner };

    public type QueryUserResult = Result<QueryUser, Error>;

    // public type MyFeedbackByUser = {
    //     feedbackId : FeedbackId;
    //     postId: Nat;
    //     created : Int;
    //     feedback: Text;

    // };

    public type UserFeedbacksResult = Result<[Feedback], Error>;

    public type BrandPostsResult = Result<[QueryPost],Error>;

    public type APostAndFeedbacksResult = Result<PostAndFeedbacks, PostAndFeedbacksError>;
    type PostAndFeedbacksError = Error or { #NotABrandOwner; #PostBelongsTo : (PostId, Text)};

    public type AllPostAndFeedbacksResult = Result<[PostAndFeedbacks], PostAndFeedbacksError>;

    public type AllUnfilledPostsResult = Result<[QueryPost], Error>;

    public type AllOpenPostsResult = Result<[QueryPost], Error> ;
    public type AllClosedPostsResult = Result<[QueryPost], Error>;
    

    public type AFeedbackAndPostResult = Result<FeedbackAndPost, Error or {#FeedbackNotInYourList}>;

    public type AllFeedbackAndPostResult = Result<[FeedbackAndPost], Error>;

    

    // // Queries
    public type QueryPost = {
        postId : Nat;
        created : Int;
        owner : Principal;
        brandName : Text;
        question : [Text];
        rewardLeft : Nat;
        totalspot : Nat;
        filledspot : Nat;
        spotLeft : Nat;
    };
    public type QueryBrand = {
        id : Nat;
        owner : Principal;
        name : Text;
        balance : Nat;
        lastPost : Int;
        totalPosts : Nat;
    };
    public type QueryUser = {
        id : Nat;
        principal: Principal;
        name : Text;
        balance : Int;
        lastFeedback : Int;
        totalFeedback : Nat;
    };

    public type PostAndFeedbacks = {
        post : QueryPost;
        feedbacks : [Feedback];
    };
    public type  FeedbackAndPost = {
        post : QueryPost;
        feedback : Feedback;
    }

};
