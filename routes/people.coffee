express = require 'express'
router = express.Router()

mongoose = require 'mongoose'

require '../models/person'
Person = mongoose.model('Person')

# GET users listing.
router.get '/', (req, res) ->
  Person.find {}, (err, people) ->
    if err
      res.status(500).send err
    else
      res.status(200).send people

# TODO: Make this more robust by optionally saving instead of creating if _id is present
router.post '/', (req, res) ->
  person = new Person(req.body)

  person.save (err, person) ->
    if err
      res.status(500).send err
    else
      res.status(201).send {'message': 'person created'}

router.param 'id', (req, res, next, value) ->
  req.body['id'] = value
  next()

router.get '/:id', (req, res) ->
  Person.find {'_id': req.body['id']}, (err, people) ->
    if err
      res.status(500).send err
    else if people == null or people.length < 1
      res.status(404).send {'message': 'person not found'}
    else
      res.status(200).send people[0]

router.put '/:id', (req, res) ->
  console.log(req.body)
  Person.find {'_id': req.body['id']}, (err, people) ->
    if err
      res.status(500).send(err)
    else if people == null or people.length < 1
      res.status(404).send('message': 'person not found')
    else
      person = people[0]
      person.first_name = req.body['first_name']
      person.last_name = req.body['last_name']
      person.date_of_birth = req.body['date_of_birth']
      person.zip = req.body['zip']

      person.save (err, person) ->
        if err
          res.status(500).send err
        else
          res.status(202).send person

router.delete '/:id', (req, res) ->
  Person.find {'_id': req.body['id']}, (err, people) ->
    if err
      res.status(500).send err
    else if people == null or people.length < 1
      res.status(404).send {'message': 'person not found'}
    else
      console.log(people)
      console.log(people[0])
      person = people[0]
      person.remove (err, person) ->
        if err
          res.status(500).send err
        else
          res.status(203).send {'message': 'person deleted'}

module.exports = router
