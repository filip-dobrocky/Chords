/*
 * Copyright (C) 2014 Filip Dobrocký <filip.dobrocky@gmail.com>
 * This file is part of Chords.
 *
 * Chords is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 3 as
 * published by the Free Software Foundation.
 *
 * Chords is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Chords.  If not, see <http://www.gnu.org/licenses/>.
 *
 */

import QtQuick 2.0
import Ubuntu.Components 0.1

Item {
    property var tones: []
    property color chordColor

    function lowestFret(stringArray) {
        if (stringArray != undefined) {
            var numArray = []
            var j = 0
            for (var i = 0; i < stringArray.length; i++) {
                if (stringArray[i] != "0" && stringArray[i] != "x") {
                    numArray[j] = parseInt(stringArray[i])
                    j++
                }
            }
            return Math.min.apply(null, numArray)
        }
    }

    function numArrayFromTo(from, to) {
        var array = [];
        for (var i = from; i <= to; i++) {
            array.push(i);
        }
        return array
    }

    Row {
        id: fretNumbersRow

        anchors {
            left: fretboardShape.left
            right: fretboardShape.right
            bottom: fretboardShape.top
            bottomMargin: units.gu(0.5)
        }

        Repeater {
            model: numArrayFromTo(lowestFret(tones), lowestFret(tones) + 3)

            Label {
                width: parent.width / 4

                horizontalAlignment: Text.AlignHCenter
                text: modelData
            }
        }
    }

    UbuntuShape {
        id: fretboardShape
        anchors {
            fill: parent
            leftMargin: units.gu(3)
            rightMargin: units.gu(3)
            topMargin: units.gu(2.5)
        }

        color: "#CF000000"

        Item {
            anchors.fill: parent

            Repeater {
                model: 3

                Image {
                    x: parent.width / 4 * (index + 1)
                    width: units.gu(0.5); height: parent.height
                    opacity: 0.9

                    source: "../graphics/fret.png"
                    fillMode: Image.TileVertically
                }
            }
        }

        Row {
            anchors.fill: parent

            Repeater {
                model: numArrayFromTo(lowestFret(tones), lowestFret(tones) + 3)
                Item {
                    width: parent.width / 4; height: parent.height

                    Image {
                        width: units.gu(2.5); height: (modelData != 12) ? units.gu(2.5) : units.gu(15)
                        anchors.centerIn: parent
                        visible: (modelData == 3 || modelData == 5 || modelData == 7
                                  || modelData == 9 || modelData == 12 || modelData == 15)
                        opacity: 0.6

                        source: (modelData != 12) ? "../graphics/circle.png" : "../graphics/2circles.png"
                    }
                }
            }
        }

        Item {
            width: parent.width; height: parent.height - units.gu(4)
            anchors.verticalCenter: parent.verticalCenter

            Repeater {
                model: ["E", "B", "G", "D", "A", "E"]

                Item {
                    width: parent.width
                    y: parent.height / 5 * (index)

                    property int stringIndex: index

                    UbuntuShape {
                        id: stringShape
                        width: units.gu(2.5); height: units.gu(2.5)
                        anchors {
                            right: stringRect.left
                            rightMargin: units.gu(0.5)
                            verticalCenter: stringRect.verticalCenter
                        }
                        visible: (tones != undefined && tones[index] == "0")

                        color: chordColor
                    }

                    Label {
                        anchors.centerIn: stringShape
                        text: modelData

                        color: (!stringShape.visible) ? Theme.palette.normal.baseText : "white"
                    }

                    Image {
                        id: stringRect
                        width: parent.width; height: (index > 2) ? units.gu(0.4) : units.gu(0.3)
                        source: (index > 2) ? "../graphics/low_string.png" : "../graphics/high_string.png"
                        fillMode: Image.TileHorizontally
                    }

                    Row {
                        anchors {
                            left: stringRect.left
                            right: stringRect.right
                            verticalCenter: stringRect.verticalCenter
                        }

                        Repeater {
                            model: numArrayFromTo(lowestFret(tones), lowestFret(tones) + 3)
                            Item {
                                width: parent.width / 4; height: units.gu(2.5)

                                UbuntuShape {
                                    width: units.gu(2.5); height: units.gu(2.5)
                                    anchors.centerIn: parent
                                    visible: (modelData == tones[stringIndex])
                                    opacity: 0.95

                                    color: chordColor
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
