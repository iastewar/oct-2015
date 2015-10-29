var parseNote = function(noteStr) {
  var noteArray = noteStr.split("*");
  if (noteArray.length > 2)
    return;
  var note = {};
  note.pitch = noteArray[0];
  if (noteArray.length == 2)
    note.beats = parseInt(noteArray[1]);
  else
    note.beats = 1

  return note
}

var parseSong = function(songStr) {
  var songArray = songStr.split(" ");
  var noteArray = [];
  for (var i = 0; i < songArray.length; i++) {
    noteArray[i] = parseNote(songArray[i]);
  }
  return noteArray;
}
