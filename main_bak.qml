import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    visible: true
    width: 960
    height: 540
    title: "會議系統選單"

    property bool showSystemMenu: false  // 布林屬性控制子選單顯示

    RowLayout {   // 元素水平排列。
        anchors.fill: parent // 讓 ColumnLayout 填滿父容器 (Window)

        // 左側選單欄
        Rectangle {
            width: 200
            color: "#007BFF"
            Layout.fillHeight: true

            Column {
                spacing: 10  // 在每個矩形之間創建了 10 像素的間距。
                anchors.margins: 20
                anchors.fill: parent

                // 主選單按鈕
                Button {
                    text: "計時會議"
                    width: parent.width
                    font.pixelSize: 16
                    onClicked: console.log("進入計時會議")
                }

                Button {
                    text: "FIFO會議"
                    width: parent.width
                    font.pixelSize: 16
                    onClicked: console.log("進入 FIFO 會議")
                }

                // 系統管理按鈕，切換展開狀態
                Button {
                    text: showSystemMenu ? "系統管理 ▼" : "系統管理 ▶"
                    width: parent.width
                    font.pixelSize: 16
                    onClicked: showSystemMenu = !showSystemMenu
                }

                // 用 Loader 代替 visible: false 的 Column
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

        // 右側主畫面區塊
        Rectangle {
            color: "#ffffff"
            Layout.fillWidth: true
            Layout.fillHeight: true

            Text {
                anchors.centerIn: parent
                text: "請選擇左側功能"
                font.pixelSize: 24
                color: "#444"
            }
        }
    }


    // 子選單 Component（僅在需要時載入）
    Component {
        id: systemSubMenu

        Column {
            spacing: 3

            Button {
                text: "．麥克風設定"
                width: 165
                font.pixelSize: 14
                background: Rectangle { color: "#3399FF" }
                onClicked: console.log("麥克風設定")
            }

            Button {
                text: "．攝影機設定"
                width: 165
                font.pixelSize: 14
                background: Rectangle { color: "#3399FF" }
                onClicked: console.log("攝影機設定")
            }
        }
    }
}
