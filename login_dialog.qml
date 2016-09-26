import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4

Window {
    visible: true
    id: root
    width: 524
    height: 930
    color: "#292929"
    visibility: "FullScreen"

    Text {
        id: headerText
        color: "#ffffff"
        text: qsTr("uniqCast")
        anchors.top: parent.top
        anchors.topMargin: 100
        anchors.horizontalCenter: parent.horizontalCenter
        font.pointSize: 45
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    Image {
        id: avatarImage
        width: 100
        height: 100
        anchors.top: headerText.bottom
        anchors.topMargin: 100
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
        source: "user-icon.png"
    }

    TextField {
        id: usernameInput
        width: 400
        height: 80
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 18
        anchors.top: avatarImage.bottom
        anchors.topMargin: 100
        anchors.horizontalCenter: parent.horizontalCenter
        placeholderText: qsTr("username")
        selectByMouse: true
        onAccepted: passwordInput.forceActiveFocus()
        color: "#fff"
        background: Rectangle {
            color: usernameInput.enabled ? "transparent" : "#fff"
            radius: 8
            border.color: "#fff"
            border.width: 1
        }
    }

    TextField {
        id: passwordInput
        width: 400
        height: 80
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 18
        anchors.top: usernameInput.bottom
        anchors.topMargin: 30
        anchors.horizontalCenter: parent.horizontalCenter
        placeholderText: qsTr("password")
        selectByMouse: true
        onAccepted: logInButton.clicked()
        color: "#fff"
        echoMode: TextInput.Password
        background: Rectangle {
            color: passwordInput.enabled ? "transparent" : "#fff"
            radius: 8
            border.color: "#fff"
            border.width: 1
        }
    }

    Button {
        id: logInButton
        width: 400
        height: 80
        font.pointSize: 18
        anchors.top: passwordInput.bottom
        anchors.topMargin: 30
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: login()
        background: Rectangle {
            color: logInButton.enabled ? "#fff" : "#fff"
            radius: 8
            border.color: logInButton.enabled ? "#151515" : "#151515"
            border.width: 1
        }
        Text {
            id: buttonText
            text: "Log In"
            anchors.centerIn: parent
            font.pixelSize: parent.height * .3
            color: "#292929"
            styleColor: "black"
        }
    }

    Text {
        id: statusText
        width: 400
        height: 35
        color: "#fff"
        text: ""
        horizontalAlignment: Text.AlignHCenter
        anchors.top: logInButton.bottom
        anchors.topMargin: 30
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 15
    }

    function login() {
        if(usernameInput.text != '' && passwordInput.text != '') {
            statusText.text = "Logging in..."
            var param = '{"identifier": "' + usernameInput.text + '","password": "' + passwordInput.text + '"}';
            var authReq = new XMLHttpRequest;
            authReq.open("POST", "http://176.31.182.158:3001/auth/local");
            authReq.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            authReq.onreadystatechange = function() {
                if (authReq.readyState == '4' && (authReq.status == '200' || authReq.status == '403')) {
                    if (authReq.status == '403') {
                        statusText.text = "Identifier or password invalid.";
                    } else {
                        statusText.text = "Login successful!";
                        var component = Qt.createComponent("welcome.qml");
                        if( component.status != Component.Ready )
                        {
                            if( component.status == Component.Error )
                                console.debug("Error:"+ component.errorString() );
                            return;
                        }
                        var window = component.createObject(root);
                        root.visible = false;
                        window.showFullScreen();
                    }
                } else if (authReq.status != '200' && authReq.status != '403')
                    console.log('Error: Status ' + authReq.status);
            }
            authReq.send(param);
        }
        else
            statusText.text = "All fields are required!"
    }
}
