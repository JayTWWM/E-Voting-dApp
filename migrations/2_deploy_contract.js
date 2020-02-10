const VoteTracker = artifacts.require("./VoteTracker.sol");

module.exports = function(deployer) {
  deployer.deploy(VoteTracker);
};
