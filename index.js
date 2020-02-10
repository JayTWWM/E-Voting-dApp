var contractABI = null;
var contractAddress = null;
var account0 = null;
var VoteTrackerContract = null;
$.ajax({
    url: "./build/contracts/VoteTracker.json",
    async: false,
    dataType: "json",
    delay: 500,
    success: function(json) {
        assignVariable(json);

    }
});

function assignVariable(data) {
    contractABI = data.abi;
    contractAddress = data.networks[5777].address;
}

web3 = new Web3(new Web3.providers.HttpProvider("http://127.0.0.1:7545"));
web3.eth.getAccounts().then(function(result) {
    account0 = result[0];
    console.log(result);
});

setTimeout(function delay() {
    VoteTrackerContract = new web3.eth.Contract(
        contractABI,
        contractAddress, { from: account0, gas: 3000000 }
    );
}, 1000);


setTimeout(function delay() {
    console.log(account0);
    Object.freeze(account0);
}, 4000);