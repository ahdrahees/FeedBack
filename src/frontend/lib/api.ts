import type {
	PostResult,
	QueryBrand,
	QueryOwner,
	BrandHash
} from '$declarations/backend.did';
import { authStore } from './auth.store';
import { get } from 'svelte/store';

export const register = async (): Promise<QueryOwner> => {
	const actor = get(authStore).actor;
	return await actor.register();
};
export const postBrand = async (comment: string): Promise<PostResult> => {
	const actor = get(authStore).actor;
	return await actor.postBrand(comment);
};


export const treasury = async (): Promise<bigint> => {
	const actor = get(authStore).actor;
	return await actor.tokenTreasury();
};

export const allBrands = async (): Promise<QueryBrand[]> => {
	const actor = get(authStore).actor;
	return await actor.allBrands();
};


// export const like = async (hash: BrandHash): Promise<LikeResult> => {
// 	const actor = get(authStore).actor;
// 	return await actor.likeComment(hash);
// };

// export const deleteComment = async (hash: CommentHash): Promise<void> => {
// 	const actor = get(authStore).actor;
// 	return await actor.deleteComment(hash);
// };
