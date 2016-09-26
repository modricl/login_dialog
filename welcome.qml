import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4

Window {
    id: root
    color: "#216321"

    Image {
        id: backgroundImage
        width: Window.width
        height: Window.height
        fillMode: Image.Stretch
        source: "test.png"
    }

    Text {
        id: welcomeText
        color: "#ffffff"
        text: qsTr("Welcome!")
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 45
    }

    Button {
        id: exitButton
        width: 400
        height: 80
        font.pointSize: 18
        anchors.top: welcomeText.bottom
        anchors.topMargin: 50
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: Qt.quit()
        background: Rectangle {
            color: exitButton.enabled ? "#fff" : "#fff"
            radius: 8
            border.color: exitButton.enabled ? "#151515" : "#151515"
            border.width: 1
        }
        Text {
            id: buttonText
            text: "Exit"
            anchors.centerIn: parent
            font.pixelSize: parent.height * .3
            color: "#000"
            styleColor: "black"
        }
    }

}
