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
    function addProgression(name) {
        db.putDoc({ progressions: { name: name, count: 0 } })
    }

    /*function renameProgression(name) {
        var docs = db.listDocs()
        for (var i = 0; i < docs.length; i++)
            if (docs[i].indexOf(renameId) != -1)
                db.putDoc({ progressions: { name: name } }, docs[i])
    }*/

    function deleteProgression(docId) {
        var docs = db.listDocs()
        for (var i = 0; i < docs.length; i++)
            if (docs[i].indexOf(docId) != -1) db.deleteDoc(docs[i])
    }

    function containsProgression(name) {
        for (var i = 0; i < model.results.length; i++)
            if (model.results[i].progressions.name == name) return true
        return false
    }

    //property string renameId

    U1db.Database { id: db; path: "chords.u1db" }

    U1db.Index {
        id: dbIndex
        database: db
        expression: [ "progressions.name" ]
    }

    U1db.Query {
        id: progressions
        index: dbIndex
    }

    clip: true

    model: progressions

    delegate: ListItem.Standard {
        id: progressionListItem
        text: model.contents.progressions.name
        removable: true
        confirmRemoval: true

        onItemRemoved: {
            if (progressionView.progressionName == model.contents.progressions.name) progressionView.progressionName = ""
            deleteProgression(model.docId)
        }

        onClicked: {
            if (progressionLayouts.currentLayout == "phone") pageStack.push(progressionPage,
                                                                            { progressionName: model.contents.progressions.name,
                                                                             progressionId: model.docId })
            progressionView.progressionName = model.contents.progressions.name
            progressionView.progressionId = model.docId
        }

        /*onPressAndHold: {
            renameId = model.docId
            PopupUtils.open(progressionActionsPopoverComponent, progressionListItem)
        }*/
    }

    Label {
        anchors.centerIn: parent
        visible: (count == 0)
        opacity: 0.7

        text: i18n.tr("No progressions")
        fontSize: "large"
    }

    /*Component {
        id: progressionActionsPopoverComponent

        ActionSelectionPopover {
            id: progressionActionsPopover

            actions: [
                Action {
                    text: i18n.tr("Rename")
                    onTriggered: PopupUtils.open(renameDialogComponent)
                }
            ]
        }
    }

    Component {
        id: renameDialogComponent

        Dialog {
            id: renameDialog

            title: i18n.tr("Rename progression")

            TextField {
                id: nameField

                placeholderText: i18n.tr("Name")
            }

            Label {
                id: errorLabel
                visible: (text != "")

                color: "red"
            }

            Button {
                text: i18n.tr("Rename")
                color: UbuntuColors.orange

                onClicked: {
                    if (nameField.text == "")
                        errorLabel.text = i18n.tr("Name can't be empty.")
                    else if (containsProgression(nameField.text))
                        errorLabel.text = i18n.tr("Name is already used.")
                    else {
                        renameProgression(nameField.text, renameId)
                        PopupUtils.close(renameDialog)
                    }
                }
            }

            Button {
                text: i18n.tr("Cancel")
                color: UbuntuColors.warmGrey

                onClicked: PopupUtils.close(renameDialog)
            }
        }
    }*/
}
