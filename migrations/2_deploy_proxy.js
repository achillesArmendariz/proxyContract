
//This code describes how we interact
const Dogs = artifacts.require('Dogs');
const DogsUpdated = artifacts.require('DogsUpdated');
const Proxy = artifacts.require('Proxy');

module.exports = async function(deployer, network, accounts){
  //deploy contracts, first version of dogs
  //proxy remains the same throughout this.
  const dogs = await Dogs.new();
  const proxy = await Proxy.new(dogs.address);


  //Create proxy dog to fool truffle, sending the
  //function calls to proxy.addy, which means it'll
  // go to our fallback function.
  var proxyDog = await Dogs.at(proxy.address);

  //set nr of dogs through the proxy
  await proxyDog.setNumberOfDogs(10);

  //tested to see where value is stored
  var nrOfDogs = await proxyDog.getNumberOfDogs();
  console.log(nrOfDogs.toNumber());

  //Deploy new version of Dogs
  const dogsUpdated = await DogsUpdated.new();
  proxy.upgrade(dogsUpdated.address);
  //this is because we added functionality
  // our function needs to upgrade we need to
  //fool the proxy, proxyDog has all functions
  proxyDog = await DogsUpdated.at(proxy.address);
  //go ahead and initialize it
  //we pass in truffle's built in array, and take the first
  // account in the array. initialize proxy state
  // initialize the proxy state. so we set up the owner
  //var in proxy scope.
  proxyDog.initialize(accounts[0]);

  //check so that storage remained, after the update.
  //value should be 10 like before
  nrOfDogs = await proxyDog.getNumberOfDogs();
  console.log(nrOfDogs.toNumber());

  //this line below shouldn't work, because it's a different
  //address, that isn't an owner. V
  //await proxyDog.setNumberOfDogs(30, {from: accounts[1]});

  //   NEW DogsUpdated SC
  await proxyDog.setNumberOfDogs(30);
  //  LETS FUCKING GOOO IT WORKS. 02/23/22
  //set the number of dogs through the proxy with NEW FUNC CONTRACT
  // new value should be 30
  nrOfDogs = await proxyDog.getNumberOfDogs();
  console.log(nrOfDogs.toNumber());



}
