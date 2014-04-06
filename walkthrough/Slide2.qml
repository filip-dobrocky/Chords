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

// Walkthrough - Slide 2
Component {
    id: slide2
    Item {
        id: slide2Container
        
        UbuntuNumberAnimation on x {
            from: isForward ? width : -width; to: 0;
        }
        
        Label {
            id: introductionText
            text: i18n.tr("Chords")
            fontSize: "x-large"
            anchors.top: parent.top
            anchors.topMargin: units.gu(5)
            anchors.horizontalCenter: parent.horizontalCenter
        }
        
        Column {
            id: mainColumn
            spacing: units.gu(1)
            anchors {
                top: introductionText.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
                margins: units.gu(4)
            }
            
            Label {
                id: bodyText
                wrapMode: Text.WordWrap
                anchors.left: parent.left
                anchors.right: parent.right
                font.pixelSize: units.dp(17)
                horizontalAlignment: Text.AlignHCenter
                text: i18n.tr("Select from a wide range of chord names and modifiers.")
            }
        }

        Image {
            id: centerImage
            height: parent.height / 3
            fillMode: Image.PreserveAspectFit
            anchors {
                bottom: parent.bottom
                bottomMargin: units.gu(5)
                horizontalCenter: parent.horizontalCenter
            }
            source: Qt.resolvedUrl("../graphics/intro_image1.png")
        }
    }
}
