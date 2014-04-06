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
import U1db 1.0 as U1db
import Ubuntu.Components 0.1
import Ubuntu.Components.Popups 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem

ListView {
    id: list

    property string progressionName: ""
    property string progressionId
    property string editDocId
    property string selectedChord
    property string selectedModifier
    property color selectedColor

    function addToProgression(name, chord, modifier, color, text) {
        var doc = db.getDoc(progressionId)
        db.putDoc({ progression: { name: name,
                          properties: { chord: chord, modifier: modifier, color: color, text: text } } }, progressionId + "c" + doc.progressions.count)
        doc.progressions.count++
        db.putDoc(doc, progressionId)
    }

    function editChord(name, chord, modifier, color, text, id) {
        db.putDoc({ progression: { name: name,
                          properties: { chord: chord, modifier: modifier, color: color, text: text } } }, id)
    }

    U1db.Database { id: db; path: "chords.u1db" }

    U1db.Index {
        id: dbIndex
        database: db
        expression: [ "progression.name" ]
    }

    U1db.Query {
        id: progression
        index: dbIndex
        query:  [ { name: progressionName } ]
    }

    clip: true

    model: progression

    delegate: ListItem.Empty {
        id: chordListItem
        width: parent.width; height: units.gu(15)

        removable: true
        confirmRemoval: true

        onItemRemoved: {
            //positionViewAtIndex(index + 1, ListView.Visible)
            db.deleteDoc(model.docId)
        }
        onClicked: {
            selectedChord = model.contents.progression.properties.chord
            selectedModifier = model.contents.progression.properties.modifier
            selectedColor = model.contents.progression.properties.color
            PopupUtils.open(chordViewSheetComponent)
        }
        onPressAndHold: {
            editDocId = model.docId
            PopupUtils.open(actionPopoverComponent, chordListItem)
        }
        onPressedChanged: chordShape.color.a += (!pressed) ? 0.1 : -0.1

        Column {
            anchors {
                fill: parent
                margins: units.gu(1)
            }
            spacing: units.gu(1)

            Label {
                id: chordText
                width: parent.width
                visible: (text != "")

                text: model.contents.progression.properties.text
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            }

            UbuntuShape {
                id: chordShape
                width: parent.width; height: (chordText.visible) ? parent.height - chordText.height - units.gu(1) : parent.height

                color: model.contents.progression.properties.color
                Component.onCompleted: color.a -= 0.15

                Label {
                    anchors.centerIn: parent

                    text: "<b>" + model.contents.progression.properties.chord + "</b> "
                          + ((model.contents.progression.properties.modifier != "*") ?
                              model.contents.progression.properties.modifier : "")
                    fontSize: "large"
                    color: "white"
                }
            }
        }
    }

    header: (mainView.width >= units.gu(75)) ? nameHeader : emptyHeader

    Component {
        id: emptyHeader
        Item {
            height: 0
        }
    }

    Component {
        id: nameHeader

        Label {
            width: list.width

            text: progressionName
            fontSize: "x-large"
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        }
    }

    footer: ListItem.Standard {
        visible: (progressionName != "")

        text: i18n.tr("Add chord")
        iconSource: Qt.resolvedUrl("../graphics/add.svg")
        iconFrame: false

        onClicked: PopupUtils.open(addChordSheetComponent)
    }

    Component {
        id: actionPopoverComponent

        ActionSelectionPopover {
            id: actionPopover

            actions: [
                Action {
                    text: i18n.tr("Edit chord")
                    onTriggered: PopupUtils.open(editChordSheetComponent)
                }
            ]
        }
    }

    Component {
        id: addChordSheetComponent

        ComposerSheet {
            id: addChordSheet

            title: i18n.tr("Add chord")

            onConfirmClicked: addToProgression(progressionName, chordSelector.model.get(chordSelector.selectedIndex).chord,
                                               (chordSelector.selectedIndex < 12) ?
                                                   modifierSelector.model.get(modifierSelector.selectedIndex).modifier : "*",
                                                   chordSelector.model.get(chordSelector.selectedIndex).color, chordTextArea.text)

            Column {
                anchors.fill: parent
                spacing: units.gu(1)

                Row {
                    width: parent.width; height: (parent.height - units.gu(1)) / 3 * 2
                    spacing: units.gu(1)

                    OptionSelector {
                        id: chordSelector
                        width: (parent.width - units.gu(1)) / 2; height: parent.height

                        model: AllChordModel { }
                        delegate: OptionSelectorDelegate { text: model.chord }
                    }

                    OptionSelector {
                        id: modifierSelector
                        width: (parent.width - units.gu(1)) / 2; height: parent.height
                        visible: (chordSelector.selectedIndex < 12)

                        model: ModifierModel { }
                    }
                }

                TextArea {
                    id: chordTextArea
                    width: parent.width; height: (parent.height - units.gu(1)) / 3

                    placeholderText: i18n.tr("Add a note (optional)")
                }
            }
        }
    }

    Component {
        id: editChordSheetComponent

        ComposerSheet {
            id: editChordSheet

            property var doc: db.getDoc(editDocId)

            title: i18n.tr("Edit chord")

            onConfirmClicked: editChord(progressionName, chordSelector.model.get(chordSelector.selectedIndex).chord,
                                        (chordSelector.selectedIndex < 12) ?
                                            modifierSelector.model.get(modifierSelector.selectedIndex).modifier : "*",
                                            chordSelector.model.get(chordSelector.selectedIndex).color, chordTextArea.text, editDocId)

            Column {
                anchors.fill: parent
                spacing: units.gu(1)

                Row {
                    width: parent.width; height: (parent.height - units.gu(1)) / 3 * 2
                    spacing: units.gu(1)

                    OptionSelector {
                        id: chordSelector
                        width: (parent.width - units.gu(1)) / 2; height: parent.height

                        model: AllChordModel { }
                        delegate: OptionSelectorDelegate { text: model.chord }
                        selectedIndex: model.getIndexByChord(doc.progression.properties.chord)
                    }

                    OptionSelector {
                        id: modifierSelector
                        width: (parent.width - units.gu(1)) / 2; height: parent.height

                        model: ModifierModel { }
                        selectedIndex: model.getIndexByModifier(doc.progression.properties.modifier)
                    }
                }

                TextArea {
                    id: chordTextArea
                    width: parent.width; height: (parent.height - units.gu(1)) / 3

                    text: doc.progression.properties.text
                    placeholderText: i18n.tr("Add a note (optional)")
                }
            }
        }
    }

    Component {
        id: chordViewSheetComponent

        DefaultSheet {
            id: chordViewSheet
            contentsHeight: units.gu(45)

            title: "<b>" + chordView.chord + "</b> " + ((chordView.modifier != "*") ? chordView.modifier : "")

            ChordView {
                id: chordView
                anchors.fill: parent

                chord: selectedChord
                modifier: selectedModifier
                columnColor: selectedColor
                labelVisible: false
            }
        }
    }

    Label {
        anchors.centerIn: parent
        visible: (progressionName == "")
        opacity: 0.7

        text: i18n.tr("No progression selected")
    }
}
