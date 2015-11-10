var mongoose = require('mongoose');

var questionSchema = new mongoose.Schema({
  title: String,
  body: String
});
mongoose.model('Question', questionSchema);
