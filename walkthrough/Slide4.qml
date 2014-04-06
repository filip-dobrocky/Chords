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

// Walkthrough - Slide 4
Component {
    id: slide4
    Item {
        id: slide4Container
        
        UbuntuNumberAnimation on x {
            from: isForward ? width : -width; to: 0;
        }
        
        Label {
            id: introductionText
            fontSize: "x-large"
            text: i18n.tr("Progressions")
            anchors.top: parent.top
            anchors.topMargin: units.gu(5)
            anchors.horizontalCenter: parent.horizontalCenter
        }
        
        Image {
            id: centerImage
            height: parent.height / 2.5
            fillMode: Image.PreserveAspectFit
            source: Qt.resolvedUrl("../graphics/intro_image3.png")
            anchors.top: introductionText.top
            anchors.topMargin: units.gu(10)
            anchors.horizontalCenter: parent.horizontalCenter
        }
        
        Label {
            id: body
            text: i18n.tr("Place chords in a certain order to create your own chord progression.")
            font.pixelSize: units.dp(16)
            anchors {
                top: centerImage.bottom
                left: parent.left
                right: parent.right
                topMargin: units.gu(5)
                margins: units.gu(3)
            }
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
