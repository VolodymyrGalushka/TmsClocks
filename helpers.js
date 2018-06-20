function Timer() {
    return Qt.createQmlObject("import QtQuick 2.9; Timer {}", mainWin);
}

function delay(delayTime, cb) {
    var timer = new Timer();
    timer.interval = delayTime;
    timer.repeat = false;
    timer.triggered.connect(cb);
    timer.start();
}
