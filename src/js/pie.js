var partyCount;
var data = [];

document.getElementById("button2").disabled = true;
document.getElementById("button3").disabled = true;

function loadChart() {
    var chart = anychart.pie();
    chart.title("RESULTS");
    console.log(data);
    chart.data(data);
    chart.container('container');
    chart.draw();
    document.getElementById("button3").disabled = true;
}

function getData() {
    for (let i = 1; i <= partyCount; i++) {
        VoteTrackerContract.methods.getNames(i)
            .call((error, response) => {
                document.getElementById("button3").disabled = false;
                data.push({ x: response[1], value: response[0] });
            });
    }
    console.log(data);
    document.getElementById("button2").disabled = true;
    document.getElementById("button3").disabled = false;
}

function getPartyCount() {
    VoteTrackerContract.methods.getPartyCount()
        .call((error, response) => {
            if (error) {
                console.log(error);
            } else {
                partyCount = response;
                console.log(partyCount);
            }
        });
    document.getElementById("button1").disabled = true;
    document.getElementById("button2").disabled = false;
}