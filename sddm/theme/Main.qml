import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import Qt5Compat.GraphicalEffects

Rectangle {
    id: root
    width: Screen.width
    height: Screen.height
    color: "black"

    // ---- config helpers -------------------------------------------------
    function cfg(key, fallback) {
        var v = config[key]
        return (v === undefined || v === "") ? fallback : v
    }
    function cfgNum(key, fallback) {
        var v = cfg(key, undefined)
        return v === undefined ? fallback : parseFloat(v)
    }
    function cfgBool(key, fallback) {
        var v = cfg(key, undefined)
        if (v === undefined) return fallback
        return v === true || v === "true" || v === "1"
    }

    property string bgSource: cfg("background", "")
    property real blurMax: cfgNum("blurMax", 64)
    property real brightnessAdj: cfgNum("brightness", -0.25)
    property real contrastAdj: cfgNum("contrast", -0.10)
    property bool showUsername: cfgBool("showUsername", false)

    property string clockFontFamily: cfg("clockFontFamily", "Inter")
    property string clockFontWeight: cfg("clockFontWeight", "DemiBold")
    property real clockFontSize: cfgNum("clockFontSize", 100)
    property color clockColor: cfg("clockColor", "#8CFFFFFF")
    property real clockOffsetY: cfgNum("clockOffsetY", -60)

    property real fieldWidth: cfgNum("fieldWidth", 220)
    property real fieldHeight: cfgNum("fieldHeight", 50)
    property real fieldRounding: cfgNum("fieldRounding", 15)
    property color fieldColor: cfg("fieldColor", "#2EFFFFFF")
    property color fieldFontColor: cfg("fieldFontColor", "#E6FFFFFF")
    property real fieldOffsetY: cfgNum("fieldOffsetY", 100)
    property real dotSize: cfgNum("dotSize", 9)

    function weightToEnum(name) {
        switch (String(name).toLowerCase()) {
            case "thin": return Font.Thin
            case "light": return Font.Light
            case "normal": return Font.Normal
            case "medium": return Font.Medium
            case "demibold":
            case "semibold": return Font.DemiBold
            case "bold": return Font.Bold
            case "black": return Font.Black
            default: return Font.DemiBold
        }
    }

    // ---- background: wallpaper + blur/dim, like hyprlock's background{} --
    Image {
        id: bg
        anchors.fill: parent
        source: root.bgSource ? "file://" + root.bgSource : ""
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
        cache: true
        smooth: true
    }

    // Plain fallback fill in case the wallpaper path can't be read
    // (e.g. permissions) so the screen isn't left blank.
    Rectangle {
        anchors.fill: parent
        color: "#1a1a1a"
        visible: bg.status !== Image.Ready
    }

    FastBlur {
        id: blurred
        anchors.fill: bg
        source: bg
        radius: root.blurMax
        visible: false
    }

    BrightnessContrast {
        anchors.fill: bg
        source: blurred
        visible: bg.status === Image.Ready
        brightness: root.brightnessAdj
        contrast: root.contrastAdj
    }

    // ---- clock, mirrors hyprlock's label{} -------------------------------
    Text {
        id: clock
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: root.clockOffsetY
        text: Qt.formatTime(new Date(), "hh:mm")
        font.family: root.clockFontFamily
        font.weight: root.weightToEnum(root.clockFontWeight)
        font.pixelSize: root.clockFontSize
        color: root.clockColor

        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: clock.text = Qt.formatTime(new Date(), "hh:mm")
        }
    }

    // Optional username, off by default to match the hyprlock config exactly
    Text {
        visible: root.showUsername
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: field.top
        anchors.bottomMargin: 14
        text: userModel.lastUser || ""
        font.family: root.clockFontFamily
        font.pixelSize: 16
        color: root.fieldFontColor
    }

    // ---- password pill, mirrors hyprlock's input-field{} -----------------
    Rectangle {
        id: field
        width: root.fieldWidth
        height: root.fieldHeight
        radius: root.fieldRounding
        color: root.fieldColor
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: root.fieldOffsetY

        SequentialAnimation {
            id: shake
            loops: 1
            NumberAnimation { target: field; property: "anchors.horizontalCenterOffset"; to: -10; duration: 40 }
            NumberAnimation { target: field; property: "anchors.horizontalCenterOffset"; to: 10; duration: 80 }
            NumberAnimation { target: field; property: "anchors.horizontalCenterOffset"; to: -6; duration: 80 }
            NumberAnimation { target: field; property: "anchors.horizontalCenterOffset"; to: 0; duration: 60 }
        }

        TextInput {
            id: passwordInput
            anchors.fill: parent
            anchors.leftMargin: 18
            anchors.rightMargin: 18
            verticalAlignment: TextInput.AlignVCenter
            horizontalAlignment: TextInput.AlignHCenter
            echoMode: TextInput.Password
            passwordCharacter: "•"
            passwordMaskDelay: 0
            color: root.fieldFontColor
            font.pixelSize: root.dotSize * 2
            selectByMouse: true
            focus: true
            clip: true

            Keys.onReturnPressed: doLogin()
            Keys.onEnterPressed: doLogin()

            function doLogin() {
                if (text.length === 0) return
                sddm.login(userModel.lastUser, text, sessionModel.lastIndex)
            }

            Component.onCompleted: forceActiveFocus()
        }
    }

    // Small, unobtrusive error text underneath the pill
    Text {
        id: errorText
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: field.bottom
        anchors.topMargin: 14
        text: "Incorrect password"
        color: root.fieldFontColor
        font.pixelSize: 13
        opacity: 0

        Behavior on opacity { NumberAnimation { duration: 250 } }
    }

    Timer {
        id: errorHideTimer
        interval: 2200
        onTriggered: errorText.opacity = 0
    }

    Connections {
        target: sddm
        function onLoginFailed() {
            passwordInput.text = ""
            errorText.opacity = 1
            errorHideTimer.restart()
            shake.start()
        }
    }

    // ---- gentle fade-in on load, mirrors hyprlock's no_fade_in = false ----
    opacity: 0
    Component.onCompleted: fadeIn.start()
    NumberAnimation {
        id: fadeIn
        target: root
        property: "opacity"
        from: 0
        to: 1
        duration: 500
        easing.type: Easing.OutQuad
    }
}
