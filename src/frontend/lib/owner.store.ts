import { writable, type Readable } from 'svelte/store';
import type { QueryOwner } from '/home/vishnu/motoko-project/Feedback/src/declarations/backend.did';
import { authStore } from './auth.store';
import { get } from 'svelte/store';
import { Actor } from '@dfinity/agent';

export interface OwnerStore extends Readable<QueryOwner | null | undefined> {
	update: () => Promise<void>;
}

const getOwner = async (): Promise<QueryOwner | null | undefined> => {
	const actor = get(authStore).actor;

	const principal = await Actor.agentOf(actor)?.getPrincipal();

	if (principal === undefined || principal.isAnonymous()) {
		return null;
	}

	return await actor.register();
};

const init = async (): Promise<OwnerStore> => {
	const { subscribe, set } = writable<QueryOwner | null | undefined>(await getOwner());

	return {
		subscribe,

		update: async () => {
			set(await getOwner());
		}
	};
};

export const ownerStore: OwnerStore = await init();

authStore.subscribe(async () => {
    await ownerStore.update();
});
