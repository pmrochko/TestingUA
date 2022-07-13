function setTimer(hours, minutes, seconds) {

    var timeInMilliseconds = (hours * 3_600_000) + (minutes * 60000) + (seconds * 1000);
    var countDownDate = new Date().getTime() + (timeInMilliseconds + 2000);

    // Update the count-down every 1 second
    var x = setInterval(function() {

        // Get today's date and time
        var now = new Date().getTime();

        // Find the distance between now and the count-down date
        var distance = countDownDate - now;

        // Time calculations for hours, minutes and seconds
        var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
        var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
        var seconds = Math.floor((distance % (1000 * 60)) / 1000);

        // Display the result in the element with id="demo"
        if (hours !== 0) {
            document.getElementById("timer").innerHTML = hours + ":" + minutes + ":" + seconds;
        } else {
            document.getElementById("timer").innerHTML = minutes + ":" + seconds;
        }

        // If the count-down is finished, write some text
        if (distance < 0) {
            clearInterval(x);
            document.getElementById("timer").innerHTML = "EXPIRED";
            document.getElementById("timeInputInForm").setAttribute("value", "EXPIRED");
            document.getElementById("submit").click();
        }
    }, 1000);
}