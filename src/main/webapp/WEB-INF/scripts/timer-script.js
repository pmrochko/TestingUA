function setTimer(time) {

    var min = parseInt(time, 10);

    var countDownDate = new Date().getTime() + (min * 60000 + 2000);

    // Update the count-down every 1 second
    var x = setInterval(function() {

        // Get today's date and time
        var now = new Date().getTime();

        // Find the distance between now and the count-down date
        var distance = countDownDate - now;

        // Time calculations for minutes and seconds
        var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
        var seconds = Math.floor((distance % (1000 * 60)) / 1000);

        // Display the result in the element with id="demo"
        document.getElementById("timer").innerHTML = minutes + ":" + seconds;

        // If the count-down is finished, write some text
        if (distance < 0) {
            clearInterval(x);
            document.getElementById("timer").innerHTML = "EXPIRED";
            document.getElementById("timeInputInForm").setAttribute("value", "EXPIRED");
            document.getElementById("submit").click();
        }
    }, 1000);
}