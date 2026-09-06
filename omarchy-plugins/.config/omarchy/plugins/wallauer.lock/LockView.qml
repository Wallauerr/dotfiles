import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Services.Mpris
import qs.Commons
import qs.Ui

// hyprlock "Dashboard Edition" ported to the Quattro Quickshell lock plugin.
// Keeps every security-relevant behavior of the built-in LockView (PAM
// password + fingerprint hint, wake on input, background blur) and adds the
// personal dashboard: clock/date, profile picture, greeting, music box and a
// power menu, all colored from the active aether theme (Color.lock.*).

Item {
  id: root

  property string backgroundPath: ""
  property int backgroundVersion: 0
  property bool fingerprintConfigured: false
  property bool authenticatingPassword: false
  property string failureMessage: ""
  property int failedAttempts: 0
  property bool inputEnabled: true
  property bool loadBackground: true
  property string passwordText: ""
  property bool syncingPasswordText: false

  readonly property string home: Quickshell.env("HOME")
  readonly property string userName: Quickshell.env("USER") || "user"
  readonly property string pluginDir: home + "/.config/omarchy/plugins/" + userName + ".lock"
  readonly property string profilePath: pluginDir + "/profile.jpg"

  // Reads MPRIS directly (Quickshell.Services.Mpris) so the music box works
  // without playerctl. Prefers a playing player, otherwise the first one with
  // any metadata. Bindings re-evaluate as players appear/change/drop out.
  readonly property var mprisPlayers: Mpris.players ? Mpris.players.values : []
  readonly property var mprisPlayer: {
    var list = mprisPlayers
    var first = null
    for (var i = 0; i < list.length; i++) {
      var p = list[i]
      if (!p) continue
      if (p.isPlaying) return p
      if (!first && (p.trackTitle || p.trackArtist || p.identity || p.desktopEntry)) first = p
    }
    return first
  }
  property int musicBarFrame: 0
  readonly property var musicBarsAnim: ["▃ ▆ █ ▆", "▆ █ ▆ ▃", "█ ▆ ▃ ▆", "▆ ▃ ▆ █"]

  property bool showDashboard: true

  readonly property string placeholderText: "Enter Password"
  readonly property int fieldWidth: 381
  readonly property int fieldHeight: 67
  readonly property int outlineThickness: 3
  readonly property int fieldFontSize: Math.round(Style.font.heading * 1.125)
  readonly property int passwordDotFontSize: Math.round(Style.font.heading * 1.33)
  readonly property int passwordDotLetterSpacing: Math.round(Style.font.heading * 0.19)
  // Space to keep clear on each side of the field for the fingerprint icon
  // (icon width plus a gap) so the centered dots never run under it.
  readonly property real fingerprintReserve: fingerprintConfigured ? Math.round(fingerprintIcon.implicitWidth + 12) : 0
  // Shrink the dots to fit once the password outgrows the field, so every
  // keystroke stays visible — otherwise long passwords clip with no feedback.
  readonly property real passwordDotScale: dotMetrics.advanceWidth > 0
    ? Math.min(1, (passwordInput.width - 4) / dotMetrics.advanceWidth)
    : 1
  readonly property bool showPasswordCursor: inputEnabled && !authenticatingPassword && failureMessage.length === 0
  readonly property bool errorState: failureMessage.length > 0
  readonly property var inputBorderSpec: errorState
    ? Border.surfaceSpec("lock", "border-error", Color.lock.borderError, root.outlineThickness, "border-alpha")
    : Border.surfaceSpec("lock", "border-active", Color.lock.borderActive, root.outlineThickness, "border-alpha")

  signal submitPassword(string password)
  signal passwordTextEdited(string password)
  signal clearFailureRequested()
  signal wakeRequested()
  signal requestAction(string action)

  // Cache-busts the lock background by appending `?v=`. Adding a query
  // string keeps Image's loader happy while forcing it to reload when the
  // user picks a new background mid-session.
  function fileUrl(path) {
    if (!path) return ""
    var encoded = String(path).split("/").map(encodeURIComponent).join("/")
    return "file://" + encoded + "?v=" + backgroundVersion
  }

  function forcePasswordFocus() {
    passwordInput.forceActiveFocus()
  }

  function clearPassword() {
    passwordTextEdited("")
  }

  function syncPasswordText() {
    if (passwordInput.text === passwordText) return
    syncingPasswordText = true
    passwordInput.text = passwordText
    syncingPasswordText = false
  }

  function pad2(value) {
    return String(value).padStart(2, "0")
  }

  function formatClock() {
    var now = new Date()
    return pad2(now.getHours()) + ":" + pad2(now.getMinutes())
  }

  function formatDate() {
    return new Date().toLocaleString(Qt.locale("en_US"), "dddd, dd MMMM yyyy")
  }

  function refreshClock() {
    clockText.text = formatClock()
    dateText.text = formatDate()
  }

  function musicGlyph() {
    if (!mprisPlayer) return "󰎆"
    if (!mprisPlayer.isPlaying) return "󰏤"
    return musicBarsAnim[musicBarFrame % musicBarsAnim.length]
  }

  function shorten(text, max) {
    var s = String(text || "")
    return s.length <= max ? s : s.slice(0, max - 3) + "..."
  }

  onPasswordTextChanged: syncPasswordText()
  onInputEnabledChanged: {
    if (inputEnabled) Qt.callLater(forcePasswordFocus)
  }
  Component.onCompleted: {
    syncPasswordText()
    refreshClock()
    if (inputEnabled) Qt.callLater(forcePasswordFocus)
  }

  // Measures the masked password at full size; passwordDotScale compares this
  // against the field width to decide how far the dots must shrink to fit.
  TextMetrics {
    id: dotMetrics
    font.family: Style.font.family
    font.pixelSize: root.passwordDotFontSize
    font.letterSpacing: root.passwordDotLetterSpacing
    text: "●".repeat(passwordInput.text.length)
  }

  Timer {
    id: clockTimer
    interval: 1000
    repeat: true
    running: root.loadBackground && root.showDashboard
    onTriggered: root.refreshClock()
  }

  // Advances the animated music bars while a track is actually playing.
  Timer {
    id: musicBarTimer
    interval: 180
    repeat: true
    running: root.loadBackground && root.showDashboard && mprisPlayer !== null && mprisPlayer.isPlaying
    onTriggered: root.musicBarFrame += 1
  }

  // Power menu button (label below the icon, mirrored from the hyprlock
  // dashboard's onclick power labels).
  component PowerButton: Item {
    id: btn
    property string iconText
    property string labelText
    property string action

    implicitWidth: 140
    implicitHeight: 86

    Text {
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.top: parent.top
      text: btn.iconText
      color: hover.hovered ? Color.lock.borderActive : Color.lock.text
      font.family: Style.font.family
      font.pixelSize: 34
    }

    Text {
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.top: parent.top
      anchors.topMargin: 48
      text: btn.labelText
      color: hover.hovered ? Color.lock.borderActive : Color.lock.placeholder
      font.family: Style.font.family
      font.pixelSize: 12
    }

    MouseArea {
      id: hover
      anchors.fill: parent
      hoverEnabled: true
      onClicked: root.requestAction(btn.action)
    }
  }

  Rectangle {
    anchors.fill: parent
    color: Color.background

    Image {
      id: wallpaper
      anchors.fill: parent
      source: root.loadBackground ? root.fileUrl(root.backgroundPath) : ""
      fillMode: Image.PreserveAspectCrop
      asynchronous: true
      cache: false
      sourceSize.width: width
      sourceSize.height: height
    }

    MultiEffect {
      anchors.fill: wallpaper
      source: wallpaper
      autoPaddingEnabled: false
      blurEnabled: root.loadBackground && wallpaper.status === Image.Ready
      blur: 1.0
      blurMax: 128
      blurMultiplier: 1.25
      contrast: -0.08
    }

    MouseArea {
      anchors.fill: parent
      hoverEnabled: true
      onClicked: { root.wakeRequested(); root.forcePasswordFocus() }
      onPositionChanged: root.wakeRequested()
    }

    // ---- Dashboard column: clock, date, profile, greeting, password,
    // music (top to bottom), matching the hyprlock layout ----
    Column {
      id: dashboard
      anchors.centerIn: parent
      width: parent.width
      visible: root.showDashboard
      spacing: 10

      Text {
        id: clockText
        anchors.horizontalCenter: parent.horizontalCenter
        text: "00:00"
        color: Color.lock.text
        font.family: Style.font.family
        font.pixelSize: 100
        font.weight: Font.Thin
        horizontalAlignment: Text.AlignHCenter
      }

      Text {
        id: dateText
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Sunday, 06 September 2026"
        color: Color.lock.placeholder
        font.family: Style.font.family
        font.pixelSize: 18
        font.weight: Font.Light
        horizontalAlignment: Text.AlignHCenter
      }

      Item {
        width: 1
        height: 36
      }

      // Profile picture, from profile.jpg in the plugin dir, with a straight
      // colored frame (no rounded corners). Hidden until the image loads or
      // if the file is missing. The source depends only on showDashboard — not
      // on the frame being visible — so the image can load and flip the frame.
      Rectangle {
        id: profileFrame
        anchors.horizontalCenter: parent.horizontalCenter
        visible: profileImage.status === Image.Ready
        width: 188
        height: 188
        color: "transparent"
        border.color: Color.lock.borderActive
        border.width: 4

        Image {
          id: profileImage
          anchors.fill: parent
          anchors.margins: 4
          source: root.showDashboard ? "file://" + root.profilePath : ""
          fillMode: Image.PreserveAspectCrop
          asynchronous: true
          cache: false
          sourceSize.width: 360
        }
      }

      Text {
        id: greetingText
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Welcome back, Wallauer"
        color: Color.lock.text
        font.family: Style.font.family
        font.pixelSize: 20
        font.weight: Font.Bold
        horizontalAlignment: Text.AlignHCenter
      }

      Item {
        width: 1
        height: 8
      }

      BorderSurface {
        id: inputField
        width: root.fieldWidth
        height: root.fieldHeight
        anchors.horizontalCenter: parent.horizontalCenter
        color: Color.lock.background
        borderSpec: root.inputBorderSpec
        radius: Style.cornerRadius
        clip: true

        TextInput {
          id: passwordInput
          anchors.fill: parent
          anchors.topMargin: inputField.borderTop
          // Reserve the fingerprint icon's width on both sides so the centered
          // dots stay symmetric and never slide under the icon as they grow.
          anchors.rightMargin: inputField.borderRight + 18 + root.fingerprintReserve
          anchors.bottomMargin: inputField.borderBottom
          anchors.leftMargin: inputField.borderLeft + 18 + root.fingerprintReserve
          verticalAlignment: TextInput.AlignVCenter
          horizontalAlignment: TextInput.AlignHCenter
          activeFocusOnPress: true
          clip: true
          enabled: root.inputEnabled && !root.authenticatingPassword
          readOnly: root.authenticatingPassword
          echoMode: TextInput.Password
          passwordCharacter: "\u25CF"
          passwordMaskDelay: 0
          color: Color.lock.text
          selectionColor: Color.lock.selection
          selectedTextColor: Color.lock.text
          font.family: Style.font.family
          font.pixelSize: text.length > 0 ? Math.max(1, Math.floor(root.passwordDotFontSize * root.passwordDotScale)) : root.fieldFontSize
          font.letterSpacing: text.length > 0 ? root.passwordDotLetterSpacing * root.passwordDotScale : 0
          cursorVisible: activeFocus && root.showPasswordCursor && text.length > 0
          cursorDelegate: Rectangle {
            width: 2
            color: Color.lock.text
            visible: passwordInput.cursorVisible
          }

          onTextChanged: {
            if (!root.syncingPasswordText) root.passwordTextEdited(text)
            if (text.length > 0) {
              root.wakeRequested()
            }
            if (text.length > 0 && root.failureMessage.length > 0) root.clearFailureRequested()
          }

          onAccepted: {
            var submitted = root.passwordText
            root.passwordTextEdited("")
            if (submitted.length > 0) root.submitPassword(submitted)
          }

          Keys.onPressed: function(event) {
            root.wakeRequested()
            if (event.key === Qt.Key_Escape || (event.modifiers & Qt.ControlModifier && event.key === Qt.Key_U)) {
              root.passwordTextEdited("")
              event.accepted = true
            }
          }
        }

        Text {
          textFormat: Text.PlainText
          anchors.fill: passwordInput
          text: root.authenticatingPassword ? "Checking…" : (root.failureMessage.length > 0 ? root.failureMessage : root.placeholderText)
          visible: passwordInput.text.length === 0
          color: root.authenticatingPassword ? Color.lock.text : (root.failureMessage.length > 0 ? Color.lock.textError : Color.lock.placeholder)
          font.family: Style.font.family
          font.pixelSize: root.fieldFontSize
          font.italic: !root.authenticatingPassword && root.failureMessage.length > 0
          horizontalAlignment: Text.AlignHCenter
          verticalAlignment: Text.AlignVCenter
          elide: Text.ElideRight
        }

        // Fingerprint hint pinned inside the field's right edge when a sensor is
        // enrolled, so the user knows they can touch to unlock instead of typing.
        // Matches hyprlock, which draws its fingerprint icon in the same spot.
        Text {
          id: fingerprintIcon
          objectName: "fingerprintIndicator"
          anchors.right: parent.right
          anchors.rightMargin: inputField.borderRight + 18
          anchors.verticalCenter: parent.verticalCenter
          visible: root.fingerprintConfigured
          text: "󰈷"
          color: Color.lock.placeholder
          font.family: Style.font.family
          font.pixelSize: Math.round(root.fieldFontSize * 1.1)
          horizontalAlignment: Text.AlignHCenter
          verticalAlignment: Text.AlignVCenter
        }
      }

      Item {
        width: 1
        height: 6
      }

      // Music box (animated bars + title/artist) fed by MPRIS. Shows a
      // music glyph when nothing plays and a pause glyph when paused.
      Row {
        id: musicBox
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 8
        visible: root.showDashboard

        Text {
          id: musicBars
          text: root.musicGlyph()
          color: Color.lock.borderActive
          font.family: Style.font.family
          font.pixelSize: 15
          horizontalAlignment: Text.AlignHCenter
          verticalAlignment: Text.AlignVCenter
        }

        Text {
          id: musicTitle
          text: root.mprisPlayer
            ? root.shorten(root.mprisPlayer.trackTitle || root.mprisPlayer.identity || "Now Playing", 26)
            : "Silence"
          color: Color.lock.text
          font.family: Style.font.family
          font.pixelSize: 15
          font.weight: Font.Bold
          horizontalAlignment: Text.AlignHCenter
          verticalAlignment: Text.AlignVCenter
        }

        Text {
          id: musicArtist
          text: root.mprisPlayer && root.mprisPlayer.trackArtist
            ? "by " + root.shorten(root.mprisPlayer.trackArtist, 20)
            : ""
          color: Color.lock.placeholder
          font.family: Style.font.family
          font.pixelSize: 15
          horizontalAlignment: Text.AlignHCenter
          verticalAlignment: Text.AlignVCenter
        }
      }
    }

    // ---- Power menu pinned to the bottom ----
    Row {
      anchors { bottom: parent.bottom; bottomMargin: 56; horizontalCenter: parent.horizontalCenter }
      spacing: 90
      visible: root.showDashboard

      PowerButton {
        iconText: "󰤄"
        labelText: "Suspend"
        action: "suspend"
      }
      PowerButton {
        iconText: "󰐥"
        labelText: "Power Off"
        action: "poweroff"
      }
      PowerButton {
        iconText: "󰜉"
        labelText: "Reboot"
        action: "reboot"
      }
    }
  }
}