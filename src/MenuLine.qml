import QtQuick
import QtQuick.Controls

// A thin rule between groups of menu entries, with little room around it.
// `shown` is what the menu's owner asks for; FolioMenu also sets `tucked`
// for a rule that would have no entry on one side of it, or sit beside
// another rule (a group emptied by the entries that don't apply, as in the
// trash), so a menu never starts, ends or doubles up with a line.
MenuSeparator {
    property bool shown: true
    property bool tucked: false
    readonly property bool isLine: true
    visible: shown && !tucked
    height: shown && !tucked ? implicitHeight : 0
    topPadding: 4
    bottomPadding: 4
    contentItem: Rectangle {
        implicitWidth: 200
        implicitHeight: 1
        color: Qt.alpha(theme.foreground, 0.12)
    }
}
