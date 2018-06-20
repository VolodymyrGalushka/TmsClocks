import QtQuick 2.9

Item {

    id: air
    state: "OFF"

    property int w: parent.width
    property int h: parent.height
    property int tps: 64
    property color airTextColor: "white"

    function on() {
        air.state = "ON"
    }

    function off() {
        air.state = "OFF"
    }

    Rectangle{
        id: onAirRect
        width: w * 0.05
        height: width
        color: "red"
        radius: onAirRect.width * 0.5
    }

    Text {
        id: onAirText
        anchors.left: onAirRect.right
        anchors.leftMargin: 10
        anchors.verticalCenter: onAirRect.verticalCenter
        text: "OFF AIR"
        color: airTextColor
        font.pixelSize: tps
    }

    states: [
        State {
            name: "ON"
            PropertyChanges { target: onAirRect; color: "red"}
            PropertyChanges { target: onAirText; text: "ON AIR"}
        },
        State {
            name: "OFF"
            PropertyChanges { target: onAirRect; color: "grey"}
            PropertyChanges { target: onAirText; text: "OFF AIR"}
        }
    ]

    transitions: [
        Transition {
            from: "ON"
            to: "OFF"
            ColorAnimation { target: onAirRect; duration: 200}
            PropertyAnimation { target: onAirText; duration: 200 }
        },
        Transition {
            from: "OFF"
            to: "ON"
            ColorAnimation { target: onAirRect; duration: 200}
            PropertyAnimation { target: onAirText; duration: 200 }
        }
    ]

}
