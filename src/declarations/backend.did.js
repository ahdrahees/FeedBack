export const idlFactory = ({ IDL }) => {
  const QueryBrand = IDL.Record({
    'created' : IDL.Int,
    'brandBalance' : IDL.Int,
    'brandId' : IDL.Text,
    'brand' : IDL.Text,
  });
  const PostError = IDL.Variant({
    'InvalidBrand' : IDL.Null,
    'AnonNotAllowed' : IDL.Null,
    'OwnerNotFound' : IDL.Null,
    'UserNotFound' : IDL.Null,
    'TimeRemaining' : IDL.Int,
  });
  const PostResult = IDL.Variant({ 'ok' : IDL.Null, 'err' : PostError });
  const BrandHash = IDL.Nat32;
  const QueryOwner = IDL.Record({
    'id' : IDL.Nat,
    'balance' : IDL.Int,
    'post' : IDL.Vec(BrandHash),
    'brand' : IDL.Text,
    'lastPost' : IDL.Int,
  });
  return IDL.Service({
    'allBrands' : IDL.Func([], [IDL.Vec(QueryBrand)], ['query']),
    'postBrand' : IDL.Func([IDL.Text], [PostResult], []),
    'register' : IDL.Func([], [QueryOwner], []),
    'tokenTreasury' : IDL.Func([], [IDL.Int], ['query']),
  });
};
export const init = ({ IDL }) => { return []; };
