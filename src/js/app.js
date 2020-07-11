var partyCount;
$(document).ready(() => {});

var apiKey = 'w08wk66j63i-lqsbdqbwns';

function getDropper() {
    getPartyCount();
    for (let i = 1; i <= partyCount; i++) {
        $("#partyNamed").html("");
        VoteTrackerContract.methods.getNames(i)
            .call((error, response) => {
                if (error) {
                    console.log(error);
                } else {
                    console.log(response[1]);
                    let additive = '<option value="' + response[1] + '"> ' + response[1] + ' </option>';
                    $("#partyNamed").append(additive);
                }
            });
    }
}

function createParty() {
    var partyName = document.getElementById("partyName").value;
    VoteTrackerContract.methods.createParty(partyName)
        .send()
        .then(result => {
            if (result.status === true) {
                alert("Success");
                console.log(result);
            }
        });
}

function generateNewVote() {
    var partyNamed = document.getElementById("partyNamed").value;
    var see = confirm("You have voted " + partyNamed);
    if (see) {
        generateVote();
    } else {
        location.reload();
    }

}

function generateVote() {
    var partyNamed = document.getElementById("partyNamed").value;
    var adhaar = document.getElementById("adhaarNumber").value;
    VoteTrackerContract.methods.generateVote(account0, partyNamed, adhaar, "Mumbai")
        .send()
        .then(result => {
            if (result.status === true) {
                alert("Success");
                console.log(result);
                window.location.href = "./VoterVerification1.html";
            }
        });
}

function getCount() {
    getPartyCount();
    for (let i = 1; i <= partyCount; i++) {
        $("#counts").html("");
        VoteTrackerContract.methods.getNames(i)
            .call((error, response) => {
                if (error) {
                    console.log(error);
                } else {
                    let additive = "<h1>" + response[0] + " " + response[1] + "</h1>";
                    $("#counts").append(additive);
                }
            });
    }
}

function getPartyCount() {
    VoteTrackerContract.methods.getPartyCount()
        .call((error, response) => {
            if (error) {
                console.log(error);
            } else {
                partyCount = response;
            }
        });
}

function verify() {
    var email = document.getElementById("email").value;
    var adhar = document.getElementById("adhaarNumber").value;
    VoteTrackerContract.methods.registerUser(account0, adhar, email, )
        .send()
        .then(result => {
            if (result.status === true) {
                alert("Success");
                console.log(result);
            }
        });
}

function loadVote() {
    window.location.href = "./VotingPortal.html";
}

function adminLogin() {
    var key;
    VoteTrackerContract.methods.getAdminKey()
        .call((error, response) => {
            if (error) {
                console.log(error);
            } else {
                key = response;
                var pass = document.getElementById("password").value;
                if (pass == key) {
                    window.location.href = "./PartyRegistration.html";
                } else {
                    alert("Wrong Key");
                }
            }
        });
}