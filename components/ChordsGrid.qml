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
import Ubuntu.Components.ListItems 0.1 as ListItem

Flickable {
    clip: true
    contentWidth: column.width
    contentHeight: column.height

    Column {
        id: column
        width: parent.parent.width
        spacing: units.gu(1)

        Item { width: 1; height: 1 }

        Label {
            width: parent.width

            text: i18n.tr("Normal chords")
            fontSize: "large"
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        }

        ListItem.ThinDivider { }

        Grid {
            spacing: units.gu(1)
            columns: (column.width > units.gu(50)) ? 3 : 2

            Repeater {
                model: NormalChordModel { }

                delegate: UbuntuShape {
                    id: normalChordSquare
                    width: (column.width > units.gu(50)) ? (column.width - units.gu(2)) / 3 : (column.width - units.gu(1)) / 2
                    height: width

                    color: model.color
                    Component.onCompleted: color.a -= 0.15

                    Label {
                        anchors.centerIn: parent

                        text: chord
                        fontSize: "large"
                        color: "white"
                    }

                    AbstractButton {
                        anchors.fill: parent

                        onClicked: {
                            if (chordLayouts.currentLayout == "phone") pageStack.push(chordPage, { chord: model.chord, color: model.color, modifier: "" })
                            chordView.chord = model.chord
                            chordView.columnColor = model.color
                            chordView.modifier = ""
                        }

                        onPressedChanged: normalChordSquare.color.a += (!pressed) ? 0.1 : -0.1
                    }
                }
            }
        }

        Label {
            width: parent.width

            text: i18n.tr("Split chords")
            fontSize: "large"
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        }

        ListItem.ThinDivider { }

        Grid {
            spacing: units.gu(1)
            columns: (column.width > units.gu(50)) ? 3 : 2

            Repeater {
                model: SplitChordModel { }

                delegate: UbuntuShape {
                    id: splitChordSquare
                    width: (column.width > units.gu(50)) ? (column.width - units.gu(2)) / 3 : (column.width - units.gu(1)) / 2
                    height: width

                    color: model.color
                    Component.onCompleted: color.a -= 0.15

                    Label {
                        anchors.centerIn: parent

                        text: chord
                        fontSize: "large"
                        color: "white"
                    }

                    AbstractButton {
                        anchors.fill: parent

                        onClicked: {
                            if (chordLayouts.currentLayout == "phone") pageStack.push(chordPage, { chord: model.chord, color: model.color, modifier: "*" })
                            chordView.chord = model.chord
                            chordView.columnColor = model.color
                            chordView.modifier = "*"
                        }

                        onPressedChanged: splitChordSquare.color.a += (!pressed) ? 0.1 : -0.1
                    }
                }
            }
        }

        Item { height: 1; width: 1}
    }
}
