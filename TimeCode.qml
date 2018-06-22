import QtQuick 2.0

Item {

    id: timeCode

    property int seconds: 0
    property int minutes: 0
    property int hours: 0

    function start() {
        timeCode.hours = 0
        timeCode.minutes = 0
        timeCode.seconds = 0
        timeCodeTimer.start()
        timeCodeText.visible = true
    }

    function stop() {
        timeCodeText.visible = false
        timeCode.hours = 0
        timeCode.minutes = 0
        timeCode.seconds = 0
        timeCodeTimer.stop()
    }

    Timer {
        id: timeCodeTimer
        interval: 1000
        repeat: true
        onTriggered: {
            ++timeCode.seconds
            if(timeCode.seconds == 60) {
                if(timeCode.minutes == 60) {
                    ++timeCode.hours
                    timeCode.minutes = 0
                }
                else {
                    ++timeCode.minutes
                    timeCode.seconds = 0
                }
            }

            timeCodeText.text = pad(timeCode.hours) + ":" + pad(timeCode.minutes) + ":" + pad(timeCode.seconds)
        }

        function pad(n) {
            return (n < 10) ? ("0" + n) : n;
        }
    }

    Text {
        id: timeCodeText
        color: "white"
        font.pixelSize: 148
        anchors.fill: parent
        text: "00:00:00"
        visible: false
    }

}
