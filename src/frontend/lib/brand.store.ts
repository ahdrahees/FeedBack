import { writable, type Readable } from 'svelte/store';
import type { QueryBrand } from '$declarations/backend.did';
import { allBrands } from './api';

export interface BrandStore extends Readable<QueryBrand[]> {
	update: () => Promise<void>;
}

const init = async (): Promise<BrandStore> => {
	const comments = await allBrands();

	const { subscribe, set } = writable<QueryBrand[]>(comments);

	return {
		subscribe,

		update: async () => {
			set(await allBrands());
		}
	};
};

export const brandStore: BrandStore = await init();
