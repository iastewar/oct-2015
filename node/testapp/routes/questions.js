var express = require('express'),
    router = express.Router(),
    mongoose = require('mongoose'), //mongo connection
    bodyParser = require('body-parser'), //parses information from POST
    methodOverride = require('method-override'); //used to manipulate POST

router.use(bodyParser.urlencoded({ extended: true }));
router.use(methodOverride(function(req, res){
      if (req.body && typeof req.body === 'object' && '_method' in req.body) {
        // look in urlencoded POST bodies and delete it
        var method = req.body._method
        delete req.body._method
        return method
      }
}));

router.route('/')
  .get(function(req, res, next) {
    //retrieve all questions from Mongo
    mongoose.model('Question').find({}, function (err, questions) {
      if (err) {
        return console.error(err);
      } else {
        res.format({
          html: function() {
            res.render('questions/index', {
              title: 'All Questions',
              "questions": questions
            });
          },
          json: function() {
            res.json(infophotos);
          }
        });
      }
    });
  })

  .post(function(req, res) {
    var title = req.body.title;
    var body = req.body.body;
    // call the create function for our database
    mongoose.model('Question').create({
      title : title,
      body : body
    }, function (err, question) {
      if (err) {
        res.send("There was a problem adding the information to the database");
      } else {
        // Question has been created
        console.log('POST creating new question: ' + question);
        res.format({
          html: function() {
            res.location("questions");
            res.redirect("/questions");
          },
          json: function() {
            res.json(question);
          }
        });
      }
    })
  });

// GET New Question page.
router.get('/new', function(req, res) {
  res.render('questions/new', {title: 'Add New Question'});
});

// route middleware to validate :id
router.param('id', function(req, res, next, id) {
  // find the id in the database
  mongoose.model('Question').findById(id, function(err, question) {
    // respond with 404 if not Found
    if (err) {
      console.log(id + ' was not found');
      res.status(404);
      var err = new Error('Not Found');
      err.status = 404;
      res.format({
        html: function(){
          next(err);
        },
        json: function(){
          res.json({message: err.status + " " + err});
        }
      });
    } else {
      // validation done, save in req
      req.id = id;
      next();
    }
  });
});

router.route('/:id')
  .get(function(req, res) {
    mongoose.model('Question').findById(req.id, function(err, question) {
      if (err) {
        console.log('GET Error: There was a problem retrieving: ' + err);
      } else {
        console.log('GET Retrieving ID: ' + question._id);
        res.format({
          html: function(){
            res.render('questions/show', {
              "question": question
            });
          },
          json: function(){
            res.json(question);
          }
        });
      }
    });
  });

router.get('/:id/edit', function(req, res) {
  // search for the question within Mongo
  mongoose.model('Question').findById(req.id, function(err, question) {
    if (err) {
      console.log('GET Error: There was a problem retrieving: ' + err);
    } else {
      // return the question
      console.log("GET Retrieving ID: " + question._id);

      res.format({
        //HTML response renders the 'edit.jade' template
        html: function() {
          res.render('questions/edit', {
            title: 'Question' + question._id,
            "question": question
          });
        },
        json: function(){
          res.json(question);
        }
      });
    }
  });
});

//PUT to update a question by ID
router.put('/:id/edit', function(req, res) {

    var title = req.body.title;
    var body = req.body.body;

        mongoose.model('Question').findById(req.id, function (err, question) {
            //update it
            question.update({
                title : title,
                body : body
            }, function (err, questionID) {
              if (err) {
                  res.send("There was a problem updating the information to the database: " + err);
              }
              else {
                      //HTML responds by going back to the page or you can be fancy and create a new view that shows a success page.
                      res.format({
                          html: function(){
                               res.redirect("/questions/" + question._id);
                         },
                         //JSON responds showing the updated values
                        json: function(){
                               res.json(question);
                         }
                      });
               }
            })
        });
});

//DELETE a Question by ID
router.delete('/:id/edit', function (req, res){
    //find question by ID
    mongoose.model('Question').findById(req.id, function (err, question) {
        if (err) {
            return console.error(err);
        } else {
            //remove it from Mongo
            question.remove(function (err, question) {
                if (err) {
                    return console.error(err);
                } else {
                    //Returning success messages saying it was deleted
                    console.log('DELETE removing ID: ' + question._id);
                    res.format({
                        //HTML returns us back to the main page, or you can create a success page
                          html: function(){
                               res.redirect("/questions");
                         },
                         //JSON returns the item with the message that is has been deleted
                        json: function(){
                               res.json({message : 'deleted',
                                   item : question
                               });
                         }
                      });
                }
            });
        }
    });
});

module.exports = router;
