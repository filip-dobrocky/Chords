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

ListModel {    
    function getIndexByChord(value) {
        for (var i = 0; i < count; i++)
            if (get(i).chord == value) return i
    }

    ListElement { chord: "C"; color: "#e74c3c" }
    ListElement { chord: "C#/Db"; color: "#c0392b" }
    ListElement { chord: "D"; color: "#e67e22" }
    ListElement { chord: "D#/Eb"; color: "#d35400" }
    ListElement { chord: "E"; color: "#f39c12" }
    ListElement { chord: "F"; color: "#9b59b6" }
    ListElement { chord: "F#/Gb"; color: "#8e44ad" }
    ListElement { chord: "G"; color: "#3498db" }
    ListElement { chord: "G#/Ab"; color: "#2980b9" }
    ListElement { chord: "A"; color: "#2ecc71" }
    ListElement { chord: "A#/Bb"; color: "#27ae60" }
    ListElement { chord: "B"; color: "#16a085" }
}
