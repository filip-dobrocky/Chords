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

    ListElement { chord: "A/C#"; color: "#77834E" }
    ListElement { chord: "A/E"; color: "#91B442" }
    ListElement { chord: "A/F"; color: "#659394" }
    ListElement { chord: "A/G"; color: "#31B2A6" }
    ListElement { chord: "A/G#"; color: "#2CA695" }
    ListElement { chord: "Am/C"; color: "#DD8B8C57" }
    ListElement { chord: "Am/F"; color: "#DD659394" }
    ListElement { chord: "Am/F#"; color: "#DD5E888F" }
    ListElement { chord: "Am/G"; color: "#DD31B2A6" }
    ListElement { chord: "Am/G#"; color: "#DD2CA695" }
    ListElement { chord: "C/E"; color: "#ED7427" }
    ListElement { chord: "C/F"; color: "#C15379" }
    ListElement { chord: "C/G"; color: "#8E728C" }
    ListElement { chord: "D/A"; color: "#8AA54A" }
    ListElement { chord: "D/B"; color: "#7E8F54" }
    ListElement { chord: "D/Bb"; color: "#879641" }
    ListElement { chord: "D/C"; color: "#E7652F" }
    ListElement { chord: "D/F#"; color: "#BA6168" }
    ListElement { chord: "E/B"; color: "#859E4C" }
    ListElement { chord: "E/C#"; color: "#DA6B1F" }
    ListElement { chord: "E/D"; color: "#ED8D1A" }
    ListElement { chord: "E/D#"; color: "#E37809" }
    ListElement { chord: "E/F"; color: "#C77B64" }
    ListElement { chord: "E/F#"; color: "#C17060" }
    ListElement { chord: "E/G"; color: "#949A77" }
    ListElement { chord: "E/G#"; color: "#8E8E66" }
    ListElement { chord: "Em/B"; color: "#DD859E4C" }
    ListElement { chord: "Em/C#"; color: "#DDDA6B1F" }
    ListElement { chord: "Em/D"; color: "#DDED8D1A" }
    ListElement { chord: "Em/D#"; color: "#DDE37809" }
    ListElement { chord: "Em/F"; color: "#DDC77B64" }
    ListElement { chord: "Em/F#"; color: "#DDC17060" }
    ListElement { chord: "Em/G"; color: "#DD949A77" }
    ListElement { chord: "Em/G#"; color: "#DD8E8E66" }
    ListElement { chord: "F/A"; color: "#659394" }
    ListElement { chord: "F/C"; color: "#C15379" }
    ListElement { chord: "F/D"; color: "#C16C6C" }
    ListElement { chord: "F/D#"; color: "#B7575B" }
    ListElement { chord: "F/E"; color: "#C77B64" }
    ListElement { chord: "F/G"; color: "#6879C9" }
    ListElement { chord: "Fm/C"; color: "#DDC15379" }
    ListElement { chord: "G/B"; color: "#259CB0" }
    ListElement { chord: "G/D"; color: "#8D8B7F" }
    ListElement { chord: "G/E"; color: "#949A77" }
    ListElement { chord: "G/F"; color: "#6879C9" }
    ListElement { chord: "G/F#"; color: "#616EC4" }
}
