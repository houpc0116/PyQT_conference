import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    anchors.fill: parent
    color: "white"

    Text {
        text: "FIFO 會議畫面"
        font.pixelSize: 20
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 20
    }

    Image {
        source: "assets/user.png"
        width: 120
        height: 120
        anchors.centerIn: parent
        fillMode: Image.PreserveAspectFit
    }
}
