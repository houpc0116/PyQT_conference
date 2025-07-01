
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    width: 800
    height: 500
    color: "#f0f0f0"

    // 使用者資料模型
    ListModel {
        id: userModel
        ListElement { name: "使用者 1"; x: 60;  y: 50 }
        ListElement { name: "使用者 2"; x: 150; y: 80 }
        ListElement { name: "使用者 3"; x: 240; y: 110 }
        ListElement { name: "使用者 4"; x: 330; y: 140 }
        ListElement { name: "使用者 5"; x: 420; y: 170 }
    }

    Column {
        anchors.fill: parent
        spacing: 10
        anchors.margins: 20

        Row {
            spacing: 10

            Button {
                text: "自動排列"
                onClicked: {
                    const personWidth = 60
                    const personHeight = 80
                    const spacingX = 30
                    const spacingY = 30
                    const maxColumns = Math.floor(parent.width / (personWidth + spacingX))
                    const startX = 20
                    const startY = 40

                    let users = []
                    for (let i = 0; i < userModel.count; i++) {
                        let u = userModel.get(i)
                        users.push({ name: u.name, x: u.x, y: u.y })
                    }

                    users.sort((a, b) => {
                        if (a.y !== b.y) return a.y - b.y
                        return a.x - b.x
                    })

                    for (let i = 0; i < users.length; i++) {
                        const row = Math.floor(i / maxColumns)
                        const col = i % maxColumns
                        const newX = startX + col * (personWidth + spacingX)
                        const newY = startY + row * (personHeight + spacingY)

                        for (let j = 0; j < userModel.count; j++) {
                            if (userModel.get(j).name === users[i].name) {
                                userModel.set(j, { name: users[i].name, x: newX, y: newY })
                                break
                            }
                        }
                    }
                }
            }

            Button {
                text: "名稱排序"
                onClicked: {
                    const personWidth = 60
                    const personHeight = 80
                    const spacingX = 30
                    const spacingY = 30
                    const maxColumns = Math.floor(parent.width / (personWidth + spacingX))
                    const startX = 20
                    const startY = 40

                    let users = []
                    for (let i = 0; i < userModel.count; i++) {
                        let u = userModel.get(i)
                        users.push({ name: u.name, x: u.x, y: u.y })
                    }

                    users.sort((a, b) => a.name.localeCompare(b.name))

                    for (let i = 0; i < users.length; i++) {
                        const row = Math.floor(i / maxColumns)
                        const col = i % maxColumns
                        const newX = startX + col * (personWidth + spacingX)
                        const newY = startY + row * (personHeight + spacingY)

                        for (let j = 0; j < userModel.count; j++) {
                            if (userModel.get(j).name === users[i].name) {
                                userModel.set(j, { name: users[i].name, x: newX, y: newY })
                                break
                            }
                        }
                    }
                }
            }
        }

        Rectangle {
            id: background
            width: parent.width
            height: 400
            color: "#ffffff"
            radius: 4

            Repeater {
                model: userModel
                delegate: Item {
                    id: personItem
                    width: 60
                    height: 80
                    x: model.x
                    y: model.y

                    property real dragOffsetX: 0
                    property real dragOffsetY: 0

                    MouseArea {
                        anchors.fill: parent
                        drag.target: parent
                        onPressed: function(mouse) {
                            dragOffsetX = mouse.x
                            dragOffsetY = mouse.y
                        }
                        onPositionChanged: function(mouse) {
                            let newX = personItem.x + (mouse.x - dragOffsetX)
                            let newY = personItem.y + (mouse.y - dragOffsetY)

                            const maxX = background.width - personItem.width
                            const maxY = background.height - personItem.height

                            personItem.x = Math.max(0, Math.min(newX, maxX))
                            personItem.y = Math.max(0, Math.min(newY, maxY))
                        }
                        onReleased: {
                            userModel.set(index, {
                                name: model.name,
                                x: personItem.x,
                                y: personItem.y
                            })
                        }
                    }

                    Column {
                        anchors.centerIn: parent
                        spacing: 4
                        Image {
                            source: "assets/icon-member-m.gif"
                            width: 60
                            height: 60
                        }
                        Text {
                            text: model.name
                            font.pixelSize: 12
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                }
            }
        }
    }
}
