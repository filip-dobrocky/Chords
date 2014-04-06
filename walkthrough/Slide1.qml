/*
 * Copyright (C) 2013, 2014 Nekhelesh Ramananthan <nik90@ubuntu.com>
 *                          Filip Dobrocký <filip.dobrocky@gmail.com>
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

// Slide 1
Component {
    id: slide1
    Item {
        id: slide1Container

        UbuntuNumberAnimation on x {
            from: isForward ? width : -width; to: 0;
        }

        Column {
            id: textColumn

            anchors.centerIn: parent
            spacing: units.gu(2)

            UbuntuShape {
                width: units.gu(12); height: width
                anchors {
                    bottomMargin: units.gu(4)
                    horizontalCenter: parent.horizontalCenter
                }

                image: Image {
                    smooth: true
                    antialiasing: true
                    fillMode: Image.PreserveAspectFit
                    source: Qt.resolvedUrl("../Chords.png")
                }
            }

            Column {
                anchors.horizontalCenter: parent.horizontalCenter

                Label {
                    text: i18n.tr("Welcome to")
                    fontSize: "large"
                    height: contentHeight
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Label {
                    text: "Chords"
                    font.bold: true
                    fontSize: "x-large"
                    height: contentHeight
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }

        Label {
            id: swipeText
            text: i18n.tr("Swipe left to continue")
            horizontalAlignment: Text.AlignHCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: units.gu(2)
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
