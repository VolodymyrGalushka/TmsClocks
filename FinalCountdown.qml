import QtQuick 2.0
import "helpers.js" as Helpers

Item {

    id: countDown

    opacity: 0

    property int defaultSeconds: 10

    property int seconds: defaultSeconds

    property color countColor: "white"

    signal finalCall
    signal pulse

    function start() {
        seconds = defaultSeconds
        countdownText.text = countDown.seconds
        opacity = 1;
        countdownTimer.start();
    }


    function stop() {
        opacity = 0;
        countdownTimer.stop();
    }

    Timer {
        id: countdownTimer
        interval: 1000
        repeat: true
        onTriggered: {
            countDown.pulse()
            countDown.seconds--;
            countdownText.text = countDown.seconds

            if (countDown.seconds == 0) {
                running = false;
                countdownText.text = "ON AIR"
                Helpers.delay(1000, function(){
                    countDown.opacity = 0
                    countDown.seconds = countDown.defaultSeconds
                    countDown.finalCall()
                })
            }
        }
    }

    Text {
        id: countdownText
        anchors.centerIn: parent
        font.pixelSize: 384
        text: countDown.seconds
        color: countColor
    }

    Behavior on opacity {
        PropertyAnimation { duration: 200 }
    }

}
