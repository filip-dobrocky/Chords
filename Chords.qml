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
import U1db 1.0 as U1db
import Ubuntu.Components 0.1
import Ubuntu.Components.Popups 0.1
import Ubuntu.Layouts 0.1
import "components"
import "walkthrough"

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "chords"
    id: mainView

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "com.ubuntu.developer.filip-dobrocky.chords"

    /*
     This property enables the application to change orientation
     when the device is rotated. The default is false.
    */
    automaticOrientation: true

    //backgroundColor: UbuntuColors.coolGrey

    width: units.gu(100)
    height: units.gu(75)

    U1db.Database { id: db; path: "chords.u1db" }

    U1db.Document {
        id: firstRunDocument
        database: db
        docId: "firstRun"
        create: true
        defaults: { "firstrun": "true" }
    }

    PageStack {
        id: pageStack

        Component.onCompleted: {
            if(String(firstRunDocument.contents.firstrun) === "true") {
                push(Qt.resolvedUrl("walkthrough/Walkthrough.qml"))
            }
            else
                push(tabs)
        }

        Component {
            id: tabs

        Tabs {
            visible: false

            Tab {
                title: i18n.tr("Chords")

                page: Page {
                    tools: ToolbarItems {
                        ToolbarButton {
                            text: i18n.tr("About")
                            iconSource: Qt.resolvedUrl("graphics/help.svg")

                            onTriggered: pageStack.push(Qt.resolvedUrl("./components/AboutPage.qml"))
                        }
                    }

                    Layouts {
                        id: chordLayouts
                        anchors {
                            fill: parent
                            leftMargin: units.gu(1)
                            rightMargin: units.gu(1)
                        }

                        onCurrentLayoutChanged: if (currentLayout == "tablet" && pageStack.depth > 1
                                                        && pageStack.currentPage.title != i18n.tr("About")
                                                        && pageStack.currentPage.title != "") pageStack.pop()

                        layouts: [
                            ConditionalLayout {
                                name: "tablet"
                                when: chordLayouts.width >= units.gu(75)

                                Row {
                                    anchors.fill: parent
                                    spacing: units.gu(1)

                                    ItemLayout {
                                        item: "grid"
                                        width: (parent.width - units.gu(2.1)) / 3
                                        anchors {
                                            top: parent.top
                                            bottom: parent.bottom
                                        }
                                    }

                                    Rectangle {
                                        width: units.gu(0.1)
                                        anchors {
                                            top: parent.top
                                            bottom: parent.bottom
                                        }
                                        opacity: 0.3

                                        color: Theme.palette.normal.foreground
                                        radius: 2
                                    }

                                    ItemLayout {
                                        item: "chord"
                                        width: (parent.width - units.gu(2.1)) / 3 * 2
                                        anchors {
                                            top: parent.top
                                            bottom: parent.bottom
                                        }
                                    }
                                }
                            },

                            ConditionalLayout {
                                name: "phone"
                                when: chordLayouts.width < units.gu(75)

                                Item {
                                    anchors.fill: parent

                                    ItemLayout {
                                        item: "grid"
                                        anchors {
                                            fill: parent
                                        }
                                    }

                                    ItemLayout {
                                        item: "chord"
                                        visible: false
                                    }
                                }
                            }
                        ]

                        ChordsGrid {
                            id: chordsGrid
                            Layouts.item: "grid"
                        }

                        ChordView {
                            id: chordView
                            Layouts.item: "chord"
                        }
                    }
                }
            }

            Tab {
                title: i18n.tr("Progressions")

                page: Page {
                    tools: ToolbarItems {
                        ToolbarButton {
                            text: i18n.tr("New")
                            iconSource: Qt.resolvedUrl("graphics/add.svg")

                            onTriggered: PopupUtils.open(addDialogComponent)
                        }
                    }

                    Layouts {
                        id: progressionLayouts
                        anchors.fill: parent

                        layouts: [
                            ConditionalLayout {
                                name: "tablet"
                                when: progressionLayouts.width >= units.gu(75)

                                Row {
                                    anchors.fill: parent

                                    ItemLayout {
                                        item: "progressionsList"
                                        width: (parent.width - units.gu(0.1)) / 3
                                        anchors {
                                            top: parent.top
                                            bottom: parent.bottom
                                        }
                                    }

                                    Rectangle {
                                        width: units.gu(0.1)
                                        anchors {
                                            top: parent.top
                                            bottom: parent.bottom
                                        }
                                        opacity: 0.3

                                        color: Theme.palette.normal.foreground
                                        radius: 2
                                    }

                                    ItemLayout {
                                        item: "progressionView"
                                        width: (parent.width - units.gu(0.1)) / 3 * 2
                                        anchors {
                                            top: parent.top
                                            bottom: parent.bottom
                                        }
                                    }
                                }
                            },

                            ConditionalLayout {
                                name: "phone"
                                when: progressionLayouts.width < units.gu(75)

                                Item {
                                    anchors.fill: parent

                                    ItemLayout {
                                        item: "progressionsList"
                                        anchors {
                                            fill: parent
                                            topMargin: units.gu(0.5)
                                        }
                                    }

                                    ItemLayout {
                                        item: "progressionView"
                                        visible: false
                                    }
                                }
                            }
                        ]

                        ProgressionsList {
                            id: progressionsList
                            Layouts.item: "progressionsList"
                        }

                        ProgressionView {
                            id: progressionView
                            Layouts.item: "progressionView"
                        }
                    }

                    Component {
                        id: addDialogComponent

                        Dialog {
                            id: addDialog

                            title: i18n.tr("New progression")
                            text: i18n.tr("Add new chord progression")

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
                                text: i18n.tr("Add")
                                color: UbuntuColors.orange

                                onClicked: {
                                    if (nameField.text == "")
                                        errorLabel.text = i18n.tr("Name can't be empty.")
                                    else if (progressionsList.containsProgression(nameField.text))
                                        errorLabel.text = i18n.tr("Name is already used.")
                                    else {
                                        progressionsList.addProgression(nameField.text)
                                        PopupUtils.close(addDialog)
                                    }
                                }
                            }

                            Button {
                                text: i18n.tr("Cancel")
                                color: UbuntuColors.warmGrey

                                onClicked: PopupUtils.close(addDialog)
                            }
                        }
                    }
                }
            }
        }
        }

        Component {
            id: chordPage

            Page {
                visible: false

                title: chord

                property string chord
                property string modifier
                property color color

                ChordView {
                    anchors {
                        fill: parent
                        leftMargin: units.gu(1)
                        rightMargin: units.gu(1)
                    }

                    chord: parent.chord
                    modifier: parent.modifier
                    columnColor: parent.color
                }
            }
        }

        Component {
            id: progressionPage

            Page {
                visible: false

                title: progressionName

                property string progressionName
                property string progressionId

                ProgressionView {
                    anchors.fill: parent

                    progressionName: parent.progressionName
                    progressionId: parent.progressionId
                }
            }
        }
    }
}
