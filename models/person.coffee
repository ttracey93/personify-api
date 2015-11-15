mongoose = require 'mongoose'

personSchema = new mongoose.Schema(
  first_name: { type: String, trim: true }
  last_name: { type: String, trim: true }
  date_of_birth: { type: Date }
  zip: { type: String, trim: true }
)

mongoose.model 'Person', personSchema