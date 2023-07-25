import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';

export type BrandHash = number;
export type PostError = { 'InvalidBrand' : null } |
  { 'AnonNotAllowed' : null } |
  { 'OwnerNotFound' : null } |
  { 'UserNotFound' : null } |
  { 'TimeRemaining' : bigint };
export type PostResult = { 'ok' : null } |
  { 'err' : PostError };
export interface QueryBrand {
  'created' : bigint,
  'brandBalance' : bigint,
  'brandId' : string,
  'brand' : string,
}
export interface QueryOwner {
  'id' : bigint,
  'balance' : bigint,
  'post' : Uint32Array | number[],
  'brand' : string,
  'lastPost' : bigint,
}
export interface _SERVICE {
  'allBrands' : ActorMethod<[], Array<QueryBrand>>,
  'postBrand' : ActorMethod<[string], PostResult>,
  'register' : ActorMethod<[], QueryOwner>,
  'tokenTreasury' : ActorMethod<[], bigint>,
}
