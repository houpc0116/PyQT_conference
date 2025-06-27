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


    // ✅ 彈跳視窗元件（一開始隱藏）
    Dialog {
        id: sceneDialog
        width: 600
        height: 400
        title: "會議場景設定"
        modal: true  // 擋背景互動
        standardButtons: Dialog.Ok

        // 內部內容你可自訂
        Rectangle {
            anchors.fill: parent
            color: "white"

            Text {
                text: "這是會議場景彈窗"
                anchors.centerIn: parent
                font.pixelSize: 18
            }
        }
    }

    Window {
        id: sceneWindow
        width: 600
        height: 400
        visible: false
        title: "會議場景視窗"
        modality: Qt.ApplicationModal  // 可選：阻擋其他視窗互動

        Rectangle {
            anchors.fill: parent
            color: "#ccc"

            Column {
                anchors.fill: parent
                spacing: 10
                anchors.margins: 15

                // 上方 Row 兩個按鈕
                Row {
                    spacing: 10

                    Button {
                        text: "載入背景"
                        onClicked: console.log("點擊儲存")
                    }

                    Button {
                        text: "自動排列"
                        onClicked: sceneWindow.visible = false
                    }
                }

                // 下方內容區
                Rectangle {
                    width: parent.width
                    height: 300
                    color: "#f2f2f2"
                    radius: 4

                    // 預設白色背景
                    Rectangle {
                        id: fallbackBackground
                        anchors.fill: parent
                        color: "white"
                        visible: true  // 預設可見
                    }

                    // 背景圖片（成功載入時會蓋住白底）
                    Image {
                        id: background
                        anchors.fill: parent
                        source: "assets/scene_bg.png"
                        fillMode: Image.PreserveAspectCrop
                        visible: status === Image.Ready  // 只有載入成功才顯示
                        onStatusChanged: {
                            fallbackBackground.visible = !(status === Image.Ready)
                        }
                    }

                    // 可拖曳的人形圖像
                    Image {
                        id: personIcon
                        source: "assets/Sample_User_Icon.png"
                        width: 60
                        height: 60
                        x: 100
                        y: 100

                        MouseArea {
                            anchors.fill: parent
                            drag.target: parent
                            cursorShape: Qt.OpenHandCursor
                            onPressed: cursorShape = Qt.ClosedHandCursor
                            onReleased: cursorShape = Qt.OpenHandCursor
                        }
                    }
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
                onClicked: {
                    console.log("開啟獨立會議視窗")
                    sceneWindow.visible = true
                }
            }
        }
    }
}
