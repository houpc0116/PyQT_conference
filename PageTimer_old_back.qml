import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: rootRect
    anchors.fill: parent
    color: "white"

    ColumnLayout { // 使用 ColumnLayout 而不是 Column，這樣 Layout 屬性更一致
        anchors.fill: parent
        anchors.margins: 20
        spacing: 20

        Text {
            text: "計時會議畫面"
            font.pixelSize: 20
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignHCenter // 在 Layouts 中使用 Layout.alignment
        }

        // ✅ 加入 ScrollView，讓 Grid 超出時可以捲動
        ScrollView {
            id: avatarScroll
            Layout.fillWidth: true // 填充 ColumnLayout 的寬度
            Layout.fillHeight: true // 填充 ColumnLayout 的剩餘高度

            // 內部的 Grid
            Grid {
                id: avatarGrid
                // 不直接設定 width: parent.width，讓 Grid 自動根據其內容和 columns 數量來計算寬度
                // 如果 contentWidth 超過 ScrollView 的可見寬度，水平捲軸會自動出現
                columns: 5
                rowSpacing: 10
                columnSpacing: 50

                // 確保 Grid 內容是水平居中的，如果它比 ScrollView 的可見寬度窄
                Layout.alignment: Qt.AlignHCenter

                Repeater {
                    model: 30 // 30 人
                    delegate: Item { // 使用 Item 作為每個單元的容器，而不是 Column
                                     // 這樣可以更好地控制單元格的尺寸
                        width: 100 // 設定每個頭像單元的固定寬度
                        height: 120 // 設定每個頭像單元的固定高度

                        Column { // 內部使用 Column 來垂直排列圖片和文字
                            anchors.centerIn: parent // 讓 Column 在 Item 內居中
                            spacing: 5

                            Image {
                                source: "assets/Sample_User_Icon.png"
                                width: 80
                                height: 80
                                fillMode: Image.PreserveAspectFit
                                anchors.horizontalCenter: parent.horizontalCenter // 圖片在 Column 內居中
                            }

                            Text {
                                text: "使用者 " + (index + 1)
                                font.pixelSize: 12
                                color: "#333"
                                horizontalAlignment: Text.AlignHCenter
                                anchors.horizontalCenter: parent.horizontalCenter // 文字在 Column 內居中
                            }
                        }
                    }
                }
            }
        }
    }
}