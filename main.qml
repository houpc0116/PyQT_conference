import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    visible: true
    width: 960
    height: 540
    title: "會議系統選單"

    property bool showSystemMenu: false
    property string currentPage: ""  // ← 控制右側畫面切換

    RowLayout {
        anchors.fill: parent

        // 左側選單欄
        Rectangle {
            width: 200
            color: "#007BFF"
            Layout.fillHeight: true

            Column {
                spacing: 10
                anchors.margins: 20
                anchors.fill: parent

                Button {
                    text: "計時會議"
                    width: parent.width
                    font.pixelSize: 16
                    onClicked: currentPage = "PageTimer.qml"
                }

                Button {
                    text: "FIFO會議"
                    width: parent.width
                    font.pixelSize: 16
                    onClicked: currentPage = "PageFIFO.qml"
                }
                
                Button {
                    text: "DeBug模式"
                    width: parent.width
                    font.pixelSize: 16
                    onClicked: currentPage = "PageFIFO.qml"
                }

                Button {
                    text: showSystemMenu ? "系統設定 ▼" : "系統設定 ▶"
                    width: parent.width
                    font.pixelSize: 16
                    onClicked: showSystemMenu = !showSystemMenu
                }

                Loader {
                    width: parent.width
                    active: showSystemMenu
                    sourceComponent: systemSubMenu
                }

                Item { Layout.fillHeight: true }

                Button {
                    width: parent.width
                    contentItem: Text {
                        text: "退出"
                        color: "white"
                        font.pixelSize: 16
                        anchors.centerIn: parent
                    }
                    background: Rectangle {
                        color: "limegreen"
                        radius: 5
                    }
                    onClicked: Qt.quit()
                }
            }
        }

        // 右側主畫面區塊：使用 Loader 變換畫面
        Loader {
            id: mainView
            Layout.fillWidth: true
            Layout.fillHeight: true
            source: currentPage === "" ? "" : currentPage

            // 預設畫面（當 currentPage 為空時）
            Rectangle {
                anchors.fill: parent
                color: "#ffffff"

                Text {
                    anchors.centerIn: parent
                    text: "請選擇左側功能"
                    font.pixelSize: 24
                    color: "#444"
                }
            }
        }
    }

    // 系統管理子選單
    Component {
        id: systemSubMenu

        Column {
            spacing: 3

            Button {
                text: "．基本設定"
                width: 165
                font.pixelSize: 14
                background: Rectangle { color: "#3399FF" }
                onClicked: console.log("基本設定")
            }

            Button {
                text: "．攝影機設定"
                width: 165
                font.pixelSize: 14
                background: Rectangle { color: "#3399FF" }
                onClicked: console.log("攝影機設定")
            }

            Button {
                text: "．麥克風設定"
                width: 165
                font.pixelSize: 14
                background: Rectangle { color: "#3399FF" }
                onClicked: console.log("麥克風設定")
            }

            Button {
                text: "．修改密碼"
                width: 165
                font.pixelSize: 14
                background: Rectangle { color: "#3399FF" }
                onClicked: console.log("修改密碼")
            }

            Button {
                text: "．會議場景"
                width: 165
                font.pixelSize: 14
                background: Rectangle { color: "#3399FF" }
                onClicked: console.log("會議場景")
            }
        }
    }
}
