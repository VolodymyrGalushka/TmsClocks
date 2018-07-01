import QtQuick 2.9
import QtQuick.Window 2.3
import QtQml 2.2
import QtQuick.Controls 2.2

Item {

    id: topItem

    Window {
        id: ctrlWin
        minimumWidth: 200
        minimumHeight : 200
        title: qsTr("TMS control panel")
        visibility: "Windowed"
        screen: Qt.application.screens[0]
        color: "black"

        OnAir {
            id: onAirStatus
            x: parent.width * 0.1
            y: parent.height * 0.1
            tps: 16
        }

        Column{

            spacing: 10
            anchors.centerIn: parent

            Button {
                id: motorBtn
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Motor!"
                onReleased: {
                    timeText.visible = false
                    fc.start()
                }

            }

            Button {
                id: motorOff
                text: "Finito"
                onClicked: {
                    onAir.off()
                    onAirStatus.off()
                    tc.stop()
                }
            }

        }
        onClosing: { Qt.quit() }
    }

    Window {
        id: mainWin
        visible: true
        title: qsTr("TMS Clocks")
        visibility: "FullScreen"
        screen: Qt.application.screens[1]
        color: "black"

        FinalCountdown {
            id: fc
            anchors.centerIn: parent
            width: mainWin.width * 0.2
            height: mainWin.width * 0.2
            onFinalCall: {
                onAir.on()
                onAirStatus.on()
                tc.start()
                timeText.visible = true
            }
            onPulse: topItem.switchBlack()
        }

        OnAir {
            id: onAir
            x: mainWin.width * 0.05
            y: mainWin.height * 0.1
        }


            Text {
                id: timeText
                visible: true
                anchors.centerIn: parent
                font.pixelSize: 350
                font.letterSpacing: 20
                font.weight: Font.DemiBold
                color: "white"
                text:  {
                    var ct = new Date()
                    var strct = ct.toLocaleTimeString(Qt.locale(), "hh:mm AP")
                    return strct.substring(0, 5)
                }
                Timer {
                    interval: 1000 * 60; running: true; repeat: true;
                    onTriggered: {
                        var ct = new Date()
                        var strct = ct.toLocaleTimeString(Qt.locale(), "hh:mm AP")
                        timeText.text = strct.substring(0, 5)
                    }
                }

                Behavior on visible {
                    PropertyAnimation { duration: 100 }
                }
            }

            TimeCode {
                id: tc
                anchors.top: timeText.bottom
                anchors.topMargin: 5
                anchors.horizontalCenter: timeText.horizontalCenter
                anchors.horizontalCenterOffset: -250
            }

    }

    //hello, Celldweller ! :-)
    function switchBlack() {
        topItem.state = (topItem.state == "POSITIVE") ? "NEGATIVE" : "POSITIVE"
    }

    states: [
        State {
            name: "POSITIVE"
            PropertyChanges { target: mainWin; color: "white"}
            PropertyChanges { target: fc; countColor: "black"}
            PropertyChanges { target: onAir; airTextColor: "black"}
        },
        State {
            name: "NEGATIVE"
            PropertyChanges { target: mainWin; color: "black"}
            PropertyChanges { target: fc; countColor: "white"}
            PropertyChanges { target: onAir; airTextColor: "white"}
        }
    ]

    transitions: [
        Transition {
            from: "POSITIVE"
            to: "NEGATIVE"
            ColorAnimation { target: mainWin; duration: 100 }
            PropertyAnimation { target: fc; duration: 100 }
            PropertyAnimation { target: onAir; duration: 100 }
        },
        Transition {
            from: "NEGATIVE"
            to: "POSITIVE"
            ColorAnimation { target: mainWin; duration: 100 }
            PropertyAnimation { target: fc; duration: 100 }
            PropertyAnimation { target: onAir; duration: 100 }
        }
    ]

}
