import QtQuick
import QtQuick.Controls

// A menu in Folio's look: the theme's colors, a hairline border, entries
// tinted in the accent when highlighted, and no opening or closing
// animation. Used for the right-click menu, its submenus and the sort menu.
Menu {
    enter: null
    exit: null
    topPadding: 4
    bottomPadding: 4
    // Submenu entries (Open With, Share) are made from this.
    delegate: FolioMenuItem { }
    // As wide as its widest entry shown, so a long label (in any language)
    // never runs into its keys.
    width: {
        let widest = implicitBackgroundWidth
        for (let i = 0; i < count; ++i) {
            const entry = itemAt(i)
            if (entry && entry.visible)
                widest = Math.max(widest, entry.implicitWidth + leftPadding + rightPadding)
        }
        return widest
    }

    // Rules go only between entries that show: none at the top or the
    // bottom, and one where several would meet. Which entries show is only
    // known once the menu's owner has set it up, so it's done as it opens.
    function tidyLines() {
        let entries = 0     // entries shown since the last rule kept
        let last = null     // the last rule kept, to drop if nothing follows it
        for (let i = 0; i < count; ++i) {
            const entry = itemAt(i)
            if (!entry)
                continue
            if (entry.isLine) {
                entry.tucked = false
                if (!entry.shown)
                    continue
                if (entries === 0) {
                    entry.tucked = true
                } else {
                    last = entry
                    entries = 0
                }
            } else if (entry.shown !== false) {
                ++entries
            }
        }
        if (entries === 0 && last)
            last.tucked = true
    }
    onAboutToShow: tidyLines()

    background: Rectangle {
        implicitWidth: 240
        color: theme.background
        border.width: 1
        border.color: Qt.alpha(theme.foreground, 0.16)
        radius: Math.min(6, theme.radius)
    }
}
