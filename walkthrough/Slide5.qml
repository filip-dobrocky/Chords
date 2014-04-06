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
import QtGraphicalEffects 1.0
import Ubuntu.Components 0.1

// Walkthrough - Slide 7
Component {
    id: slide7
    Item {
        id: slide7Container
        
        UbuntuNumberAnimation on x {
            from: isForward ? width : -width; to: 0;
        }
        
        Label {
            id: introductionText
            fontSize: "x-large"
            text: i18n.tr("Ready!")
            anchors.top: parent.top
            anchors.topMargin: units.gu(5)
            anchors.horizontalCenter: parent.horizontalCenter
        }
        
        Image {
            id: smileImage
            smooth: true
            width: units.gu(16)
            antialiasing: true
            fillMode: Image.PreserveAspectFit
            source: Qt.resolvedUrl("../graphics/guitarist.png")
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: units.gu(15)
            }
        }

        ColorOverlay {
                anchors.fill: smileImage
                opacity: 0.6

                source: smileImage
                color: Theme.palette.normal.foreground
            }
        
        Button {
            id: continueButton
            color: "green"
            height: units.gu(5)
            width: units.gu(25)
            text: i18n.tr("Start using") + " Chords!"
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: smileImage.bottom
                topMargin: units.gu(5)
            }
            
            onClicked: {
                if(isFirstRun) {
                    firstRunDocument.contents = {
                        firstrun: "false"
                    }
                    pageStack.pop()
                    pageStack.push(tabs)
                }
                else {
                    while(pageStack.depth !== 2)
                        pageStack.pop()
                }
            }
        }
    }
}
