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
    function getIndexByModifier(value) {
        for (var i = 0; i < count; i++)
            if (get(i).modifier == value) return i
    }

    ListElement { modifier: "major" }
    ListElement { modifier: "minor" }
    ListElement { modifier: "7" }
    ListElement { modifier: "m7" }
    ListElement { modifier: "maj7" }
    ListElement { modifier: "mmaj7" }
    ListElement { modifier: "6" }
    ListElement { modifier: "m6" }
    ListElement { modifier: "sus" }
    ListElement { modifier: "dim" }
    ListElement { modifier: "aug" }
    ListElement { modifier: "7sus4" }
    ListElement { modifier: "5" }
    ListElement { modifier: "-5" }
    ListElement { modifier: "7-5" }
    ListElement { modifier: "7maj5" }
    ListElement { modifier: "m9" }
    ListElement { modifier: "maj9" }
    ListElement { modifier: "add9" }
    ListElement { modifier: "11" }
    ListElement { modifier: "13" }
    ListElement { modifier: "6add9" }
}
