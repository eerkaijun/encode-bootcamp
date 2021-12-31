// Dependency
const IPFS = require('ipfs');
const all = require('it-all');

async function storeData() {
	// Initialise IPFS node
	const node = await IPFS.create();
	// Set some data to a variable
	const data = 'Hello, Kai';
	// Submit data to the network
	const cid = await node.add(data);
	// Log CID to console
	console.log(cid.path);
}

async function retrieveData() {
	// Initialise IPFS node
	const node = await IPFS.create();
	// Store CID in a variable
	const cid = 'QmPChd2hVbrJ6bfo3WBcTW4iZnpHm8TEzWkLHmLpXhF68A';
	// Retrieve data from CID
	const data = Buffer.concat(await all(node.cat(cid)));
	// Print data to console
	console.log(data);
}

storeData();
retrieveData();

