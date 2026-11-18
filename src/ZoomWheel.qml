import QtQuick

// Ctrl+scroll over a view asks for a size step, the way Ctrl+= and Ctrl+-
// do: one step per notch of the wheel, up for bigger. The view says what
// a step means (the grid's tiles, the list's rows).
WheelHandler {
    signal zoomRequested(int step)

    acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
    acceptedModifiers: Qt.ControlModifier
    // A touchpad sends many small deltas: a step per notch's worth
    // (120), and nothing for an event that doesn't move up or down.
    property real pending: 0
    onWheel: (event) => {
        // Every whole notch is a step; the rest waits for the next event.
        pending += event.angleDelta.y
        while (Math.abs(pending) >= 120) {
            const step = pending > 0 ? 1 : -1
            zoomRequested(step)
            pending -= step * 120
        }
    }
}
