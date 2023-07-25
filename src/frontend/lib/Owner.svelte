<script lang="ts">
	import type { QueryOwner } from '$declarations/backend.did';
	import { ownerStore } from '$lib/owner.store';
	import { treasuryStore } from '$lib/treasury.store';
	import { onMount } from 'svelte';
	import Post from './Post.svelte';

	let user: QueryOwner | null | undefined = null;

	const update = async () => {
		await ownerStore.update();
		await treasuryStore.update();
	};

	onMount(async () => {
		user = $ownerStore;
	});

	$: user = $ownerStore;
</script>

{#await update()}
	Loading user...
{:then _}
	{#if user}
		<div class="mr-3 ml-3 mt-5 mb-5 flex justify-between">
			<div>
				<p class="h2">User{user.id}</p>
				<span class="text-tertiary-900">Logged in</span>
			</div>
			<div>
				<p class="h2">{user.balance}</p>
				<span class="text-tertiary-900">Balance</span>
			</div>
		</div>

		<Post on:updateOwner={update} />
	{/if}
{/await}
