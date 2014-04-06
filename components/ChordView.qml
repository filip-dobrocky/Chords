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
import QtMultimedia 5.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem
import "../JSON"

Flickable {
    property string chord: ""
    property string modifier: ""
    property color columnColor
    property variant sounds: [e1, b, g, d, a, e2]
    property bool labelVisible: true

    function stopAll() {
        for (var i = 0; i < sounds.length; i++) sounds[i].stop()
        playTimer.stop()
    }

    function isPlaying() {
        for (var i = 0; i < sounds.length; i++) if (sounds[i].playbackState == Audio.PlayingState) return true
        return false
    }

    contentHeight: column.height
    flickableDirection: Flickable.VerticalFlick
    clip: true

    onChordChanged: jsonModel.updateJSONModel()

    Column {
        id: column
        width: parent.parent.width
        visible: (chord != "")
        spacing: units.gu(1)

        Item { width: 1; height: 1 }

        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            visible: (mainView.width >= units.gu(75) && labelVisible)

            text: chord
            fontSize: "x-large"
        }

        ListItem.ItemSelector {
            id: modifierSelector
            width: parent.width
            containerHeight: units.gu(40)
            visible: (modifier == "")

            model: ModifierModel { }

            onSelectedIndexChanged: jsonModel.updateJSONModel()
        }

        Fretboard {
            id: fretboard
            width: (parent.width > units.gu(40)) ? units.gu(40) : parent.width
            height: units.gu(23)
            anchors.horizontalCenter: parent.horizontalCenter

            property var variation

            tones: (variation != undefined) ? [variation.e2, variation.b, variation.g, variation.d, variation.a, variation.e] : undefined
            chordColor: columnColor
        }

        Label {
            text: i18n.tr("Variations")
        }

        ListView {
            id: variationsList
            width: (parent.width > units.gu(5) * count + spacing * (count - 1))
                   ? units.gu(5) * count + spacing * (count - 1)
                   : parent.width
            height: units.gu(5)
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: units.gu(1)

            orientation: ListView.Horizontal
            model: jsonModel.model

            delegate: Button {
                width: units.gu(5); height: units.gu(5)

                color: (ListView.isCurrentItem) ? columnColor : "#50000000"
                text: index + 1

                onClicked: variationsList.currentIndex = index
            }

            onCurrentIndexChanged: {
                stopAll()
                fretboard.variation = variationsList.model.get(variationsList.currentIndex)
            }

            JSONListModel {
                id: jsonModel
                source: "../JSON/chords.json"
                query: (modifierSelector.visible)
                       ? "$.chords[?(@.chord == chord && @.modf == modifierSelector.model.get(modifierSelector.selectedIndex).modifier)]"
                       : (modifier == "*") ? "$.chords[?(@.chord == chord)]" : "$.chords[?(@.chord == chord && @.modf == modifier)]"

                onUpdated: fretboard.variation = variationsList.model.get(variationsList.currentIndex)
            }
        }

        ListItem.ThinDivider { }

        Button {
            width: parent.width; height: units.gu(6)

            text: (!isPlaying()) ? i18n.tr("Play") : i18n.tr("Stop")
            color: (!isPlaying()) ? "#50000000" : columnColor

            onClicked: {
                if (!isPlaying()) playTimer.start()
                else stopAll()
            }
        }

        Item { width: 1; height: 1 }

        Timer {
            id: playTimer

            running: false
            repeat: true
            triggeredOnStart: true
            interval: 20

            property int i: 5

            onTriggered: {
                while (i != 0 && sounds[i].source == "") i--
                sounds[i].play()
                i--
                if (i < 0) stop()
            }

            onRunningChanged: i = 5
        }

        Audio {
            id: e1

            source: (fretboard.tones != undefined && fretboard.tones[0] != "x") ? "../sounds/e" + fretboard.tones[0] + ".ogg" : ""
            volume: 0.8
        }

        Audio {
            id: b

            source: (fretboard.tones != undefined && fretboard.tones[1] != "x") ? "../sounds/b" + fretboard.tones[1] + ".ogg" : ""
            volume: 0.8
        }

        Audio {
            id: g

            source: (fretboard.tones != undefined && fretboard.tones[2] != "x") ? "../sounds/g" + fretboard.tones[2] + ".ogg" : ""
            volume: 0.8
        }

        Audio {
            id: d

            source: (fretboard.tones != undefined && fretboard.tones[3] != "x") ? "../sounds/D" + fretboard.tones[3] + ".ogg" : ""
            volume: 0.8
        }

        Audio {
            id: a

            source: (fretboard.tones != undefined && fretboard.tones[4] != "x") ? "../sounds/A" + fretboard.tones[4] + ".ogg" : ""
            volume: 0.8
        }

        Audio {
            id: e2

            source: (fretboard.tones != undefined && fretboard.tones[5] != "x") ? "../sounds/E" + fretboard.tones[5] + ".ogg" : ""
            volume: 0.8
        }

    }

    Label {
        anchors.centerIn: parent
        visible: (chord == "")
        opacity: 0.7

        text: i18n.tr("Select a chord")
        fontSize: "large"
    }
}
