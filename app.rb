# require("sinatra")
# require("sinatra/reloader")
# also_reload("lib/**/*.rb")
# require("./lib/patient")
# # require("./lib/doctor")
# require('pg')
#
# DB = PG.connect({:dbname => 'doctor_office_test'})

# get("/") do
#   @patients = patient.all()
#   erb(:index)
# end
#
# post("/patients") do
#   patient_name = params.fetch("patient_name") #patients table
#   # doctor_id = params.fetch("doctor_id").to_i() #patients table
#   # @doctor = doctor.find(doctor_id)
#   # @patient = patient.new({:patient_name => patient_name, :doctor_id => doctor_id})
#   # @patient.save()
#   # patient = patient.new(patient_name)
#   # patient.save()
#   erb(:output)
# end
